import 'dart:async';
import 'package:flutter/material.dart';
import '../../models/lesson.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_theme.dart';
import '../../widgets/thinking_indicator.dart';
import '../../widgets/typewriter_controller.dart';
import '../../widgets/staggered_fade_in.dart';

class DialogueStepScreen extends StatefulWidget {
  final Dialogue data;
  final String philosopherName;
  final AppLocalizations l10n;
  final VoidCallback onComplete;

  const DialogueStepScreen({
    super.key,
    required this.data,
    required this.philosopherName,
    required this.l10n,
    required this.onComplete,
  });

  @override
  State<DialogueStepScreen> createState() => _DialogueStepScreenState();
}

class _DialogueStepScreenState extends State<DialogueStepScreen> {
  final List<_ChatMessage> _messages = [];
  String? _currentNodeId;
  bool _showMethodSummary = false;
  bool _showOpponentPreview = false;
  bool _opponentExpanded = false;
  bool _waitingForContinue = false;
  String? _pendingNextNodeId;
  final ScrollController _scrollController = ScrollController();

  // Typewriter state (for chat messages)
  bool _isTyping = false;
  int _revealedChars = 0;
  Timer? _typewriterTimer;
  String _currentTypingText = '';

  // Thinking pause state
  bool _isThinking = false;

  // Summary page typewriter
  final _summaryTw = TypewriterController();
  bool _summaryTypingDone = false;
  // Opponent preview typewriter
  final _opponentTw = TypewriterController();

  bool get _isZh => widget.l10n.language == AppLanguage.zh;

  @override
  void initState() {
    super.initState();
    _currentNodeId = widget.data.startNodeId;
    _showCurrentNode();
  }

  @override
  void dispose() {
    _typewriterTimer?.cancel();
    _summaryTw.dispose();
    _opponentTw.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  DialogueNode? _getNode(String id) {
    try {
      return widget.data.nodes.firstWhere((n) => n.id == id);
    } catch (_) {
      return null;
    }
  }

  // ─── Show current dialogue node ───

  void _showCurrentNode() {
    final node = _getNode(_currentNodeId!);
    if (node == null) return;

    final text = _isZh ? node.textZh : node.textEn;

    setState(() {
      _messages.add(_ChatMessage(
        speaker: node.speaker,
        text: text,
        choices: node.choices,
      ));
    });
    _scrollToBottom();

    // Non-user messages get typewriter effect
    if (node.speaker != 'user') {
      _startTypewriter(text, node);
    } else {
      // User messages: show controls immediately
      _onTypewriterFinished(node);
    }
  }

  // ─── Typewriter effect ───

  void _startTypewriter(String text, DialogueNode node) {
    _typewriterTimer?.cancel();
    _currentTypingText = text;
    _revealedChars = 0;
    _isTyping = true;

    final interval = _isZh ? 100 : 60; // ms per character

    _typewriterTimer =
        Timer.periodic(Duration(milliseconds: interval), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _revealedChars++;
      });
      // Scroll during typing to keep text visible
      if (_revealedChars % 5 == 0) {
        _scrollToBottom();
      }
      if (_revealedChars >= _currentTypingText.length) {
        timer.cancel();
        _onTypewriterFinished(node);
      }
    });
  }

  void _skipTypewriter() {
    if (!_isTyping) return;
    _typewriterTimer?.cancel();
    final node = _getNode(_currentNodeId!);
    setState(() {
      _revealedChars = _currentTypingText.length;
      _isTyping = false;
    });
    if (node != null) {
      _onTypewriterFinished(node);
    }
  }

  void _onTypewriterFinished(DialogueNode node) {
    setState(() {
      _isTyping = false;
    });

    // Show "继续" if no choices and not end
    if (node.choices == null && !node.isEndNode && node.nextNodeId != null) {
      setState(() {
        _waitingForContinue = true;
        _pendingNextNodeId = node.nextNodeId;
      });
      _scrollToBottom();
    }

    // End node → show continue after a short delay
    if (node.isEndNode) {
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted) {
          setState(() => _waitingForContinue = true);
          _scrollToBottom();
        }
      });
    }

    // If has choices, they'll now be visible
    if (node.choices != null) {
      _scrollToBottom();
    }
  }

  // ─── Continue (tap to continue) ───

  void _onContinue() {
    if (_isTyping || _isThinking) return;
    if (!_waitingForContinue) return;

    if (_pendingNextNodeId != null) {
      setState(() {
        _waitingForContinue = false;
      });
      _currentNodeId = _pendingNextNodeId;
      _pendingNextNodeId = null;
      _showCurrentNode();
    } else {
      // End node → switch to summary page
      setState(() {
        _waitingForContinue = false;
        _showMethodSummary = true;
        _summaryTypingDone = false;
      });
      // Start typing summary
      _summaryTw.start(
        text: _isZh
            ? widget.data.methodSummaryZh
            : widget.data.methodSummaryEn,
        isZh: _isZh,
        onUpdate: () {
          if (mounted) setState(() {});
        },
        onComplete: () {
          if (mounted) setState(() => _summaryTypingDone = true);
        },
      );
    }
  }

  // ─── Choice selected → thinking pause ───

  void _onChoiceSelected(DialogueChoice choice) {
    if (_isThinking) return;

    final lastMsg = _messages.last;
    final choiceIndex = lastMsg.choices?.indexOf(choice) ?? 0;
    setState(() {
      _messages[_messages.length - 1] = _ChatMessage(
        speaker: lastMsg.speaker,
        text: lastMsg.text,
        choices: lastMsg.choices,
        selectedChoiceIndex: choiceIndex,
      );
      _isThinking = true;
    });
    _scrollToBottom();

    // 1.5s thinking pause, then show next node
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() => _isThinking = false);
        _currentNodeId = choice.nextNodeId;
        _showCurrentNode();
      }
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ─── Build ───

  @override
  Widget build(BuildContext context) {
    if (_showMethodSummary) return _buildSummaryPage();

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.accent.withValues(alpha: 0.2),
                child: Text(
                  widget.philosopherName.substring(0, 1),
                  style: TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                _isZh
                    ? '与${widget.philosopherName}对话'
                    : 'Dialogue with ${widget.philosopherName}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accent,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),

        // Chat messages
        Expanded(
          child: Stack(
            children: [
              // Tap to continue — the whole area is tappable
              GestureDetector(
                onTap: _waitingForContinue ? _onContinue : null,
                behavior: HitTestBehavior.translucent,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ..._messages.asMap().entries.map((entry) {
                        final index = entry.key;
                        final msg = entry.value;
                        final isLastMessage = index == _messages.length - 1;

                        return _ChatBubble(
                          message: msg,
                          isZh: _isZh,
                          philosopherName: widget.philosopherName,
                          onChoiceSelected: _onChoiceSelected,
                          revealedChars:
                              isLastMessage && _isTyping ? _revealedChars : null,
                          hideControls: isLastMessage && _isTyping,
                        );
                      }),

                      // Thinking indicator (shown between choice and response)
                      if (_isThinking) const ThinkingIndicator(asBubble: true),

                      // "Tap to continue" hint
                      if (_waitingForContinue && !_isTyping) ...[
                        const SizedBox(height: 24),
                        Center(
                          child: Text(
                            _isZh ? '轻触继续' : 'tap to continue',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textLight,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ],
                  ),
                ),
              ),

              // Fast-forward button during typewriter
              if (_isTyping)
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: GestureDetector(
                    onTap: _skipTypewriter,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.divider),
                      ),
                      child: Icon(Icons.fast_forward_rounded,
                          size: 18, color: AppColors.textSecondary),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  // ─── Summary page ───

  Widget _buildSummaryPage() {
    return GestureDetector(
      onTap: _summaryTypingDone ? widget.onComplete : null,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Method summary card with typewriter
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isZh ? '方法论总结' : 'Methodology Summary',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.accent,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _summaryTw.displayText,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),

                // Opponent preview (only show after summary typing done)
                if (widget.data.opponentPreview != null &&
                    _summaryTypingDone) ...[
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (!_showOpponentPreview) {
                          _showOpponentPreview = true;
                        }
                        _opponentExpanded = !_opponentExpanded;
                      });
                      if (_opponentExpanded) {
                        // Start typing opponent text
                        _opponentTw.start(
                          text: _isZh
                              ? widget.data.opponentPreview!.textZh
                              : widget.data.opponentPreview!.textEn,
                          isZh: _isZh,
                          onUpdate: () {
                            if (mounted) setState(() {});
                          },
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.divider),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.forum_outlined,
                                  size: 18, color: AppColors.textSecondary),
                              const SizedBox(width: 8),
                              Text(
                                _isZh
                                    ? '想听听反对者怎么说？'
                                    : 'Want to hear the opposition?',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                _opponentExpanded
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                color: AppColors.textSecondary,
                              ),
                            ],
                          ),
                          if (_opponentExpanded) ...[
                            const SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 14,
                                  backgroundColor:
                                      AppColors.accent.withValues(alpha: 0.2),
                                  child: Text(
                                    (_isZh
                                            ? widget
                                                .data.opponentPreview!.nameZh
                                            : widget
                                                .data.opponentPreview!.nameEn)
                                        .substring(0, 1),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.accent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _isZh
                                            ? widget
                                                .data.opponentPreview!.nameZh
                                            : widget
                                                .data.opponentPreview!.nameEn,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _opponentTw.displayText,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.textPrimary,
                                          height: 1.6,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 32),
                // Tap to continue hint
                AnimatedOpacity(
                  opacity: _summaryTypingDone ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Center(
                    child: Text(
                      _isZh ? '轻触继续' : 'tap to continue',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textLight,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Fast-forward for summary typing
          if (_summaryTw.isTyping)
            Positioned(
              right: 16,
              bottom: 16,
              child: GestureDetector(
                onTap: () {
                  _summaryTw.skip();
                  setState(() => _summaryTypingDone = true);
                  _scrollToBottom();
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Icon(Icons.fast_forward_rounded,
                      size: 18, color: AppColors.textSecondary),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final String speaker; // "philosopher", "narrator", "user"
  final String text;
  final List<DialogueChoice>? choices;
  final int? selectedChoiceIndex;

  const _ChatMessage({
    required this.speaker,
    required this.text,
    this.choices,
    this.selectedChoiceIndex,
  });
}

class _ChatBubble extends StatelessWidget {
  final _ChatMessage message;
  final bool isZh;
  final String philosopherName;
  final Function(DialogueChoice) onChoiceSelected;
  final int? revealedChars; // null = show full text
  final bool hideControls; // true = hide choices during typewriter

  const _ChatBubble({
    required this.message,
    required this.isZh,
    required this.philosopherName,
    required this.onChoiceSelected,
    this.revealedChars,
    this.hideControls = false,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.speaker == 'user';
    final displayText = revealedChars != null
        ? message.text
            .substring(0, revealedChars!.clamp(0, message.text.length))
        : message.text;

    // Don't show bubble when typewriter hasn't started yet
    final showBubble = revealedChars == null || revealedChars! > 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // Speaker label
          if (!isUser)
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 4),
              child: Text(
                message.speaker == 'philosopher' ? philosopherName : '',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

          // Bubble — grows with text, hidden when empty
          if (showBubble)
            AnimatedSize(
              duration: const Duration(milliseconds: 50),
              alignment: Alignment.topLeft,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.78,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isUser
                      ? AppColors.accent.withValues(alpha: 0.15)
                      : AppColors.surfaceLight,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft: Radius.circular(isUser ? 16 : 4),
                    bottomRight: Radius.circular(isUser ? 4 : 16),
                  ),
                ),
                child: Text(
                  displayText,
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.textPrimary,
                    height: 1.6,
                  ),
                ),
              ),
            ),

          // Choices (hidden during typewriter, staggered fade-in)
          if (message.choices != null && !hideControls) ...[
            const SizedBox(height: 12),
            StaggeredFadeIn(
              show: true,
              children: message.choices!.asMap().entries
                  .where((entry) =>
                      message.selectedChoiceIndex == null ||
                      entry.key == message.selectedChoiceIndex)
                  .map((entry) {
                final choice = entry.value;
                final isSelected = message.selectedChoiceIndex == entry.key;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap:
                          isSelected ? null : () => onChoiceSelected(choice),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.accent.withValues(alpha: 0.15)
                              : Colors.transparent,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.accent
                                : AppColors.accent.withValues(alpha: 0.5),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          isZh ? choice.textZh : choice.textEn,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.accent,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
