import 'package:flutter/material.dart';
import '../../models/lesson.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_theme.dart';
import '../../widgets/thinking_indicator.dart';
import '../../widgets/typewriter_controller.dart';
import '../../widgets/staggered_fade_in.dart';

class ThoughtExperimentStep extends StatefulWidget {
  final ThoughtExperiment data;
  final AppLocalizations l10n;
  final VoidCallback onComplete;

  const ThoughtExperimentStep({
    super.key,
    required this.data,
    required this.l10n,
    required this.onComplete,
  });

  @override
  State<ThoughtExperimentStep> createState() => _ThoughtExperimentStepState();
}

class _ThoughtExperimentStepState extends State<ThoughtExperimentStep> {
  late List<String> _sentences;
  int _sentenceIndex = 0;

  // Phases: scenario → choices → thinking → transition → commonTransition
  bool _showChoices = false;
  int? _selectedIndex;
  bool _isThinking = false;
  bool _showTransition = false;
  bool _showCommonTransition = false;

  // Typewriter
  final _tw = TypewriterController();
  bool _typingDone = false;
  // For choices page: show choices after heading finishes typing
  bool _choicesVisible = false;

  bool get _isZh => widget.l10n.language == AppLanguage.zh;

  @override
  void initState() {
    super.initState();
    final text = _isZh ? widget.data.scenarioZh : widget.data.scenarioEn;
    _sentences = _splitScenario(text);
    _startTyping(_fmt(_sentences[_sentenceIndex]));
  }

  @override
  void dispose() {
    _tw.dispose();
    super.dispose();
  }

  /// Split scenario text into pages by \n\n.
  List<String> _splitScenario(String text) {
    return text
        .split('\n\n')
        .where((p) => p.trim().isNotEmpty)
        .map((p) => p.trim())
        .toList();
  }

  /// Format body text: one sentence per line.
  String _fmt(String text) {
    if (_isZh) {
      return text.replaceAllMapped(RegExp(r'。(?!$|\n)'), (m) => '。\n');
    }
    return text.replaceAllMapped(
        RegExp(r'([.!?])\s+(?=[A-Z])'), (m) => '${m.group(1)}\n');
  }

  void _startTyping(String text) {
    _typingDone = false;
    _tw.start(
      text: text,
      isZh: _isZh,
      onUpdate: () {
        if (mounted) setState(() {});
      },
      onComplete: () {
        if (mounted) setState(() => _typingDone = true);
      },
    );
  }

  void _skipTypewriter() {
    _tw.skip();
    setState(() => _typingDone = true);
  }

  @override
  Widget build(BuildContext context) {
    // Phase: Thinking (after choice, before transition)
    if (_isThinking) return _buildThinkingPage();

    // Phase 1: Scenario sentences — one at a time, centered
    if (!_showChoices &&
        _selectedIndex == null &&
        !_showTransition &&
        !_showCommonTransition) {
      return _buildSentencePage();
    }

    // Phase 2: Choices
    if (_selectedIndex == null && !_showTransition && !_showCommonTransition) {
      return _buildChoicesPage();
    }

    // Phase 3: Per-choice transition
    if (!_showCommonTransition) {
      return _buildTransitionPage();
    }

    // Phase 4: Common transition
    return _buildCommonTransitionPage();
  }

  // ─── Fast-forward button (shared across pages) ───

  Widget _buildFastForwardButton() {
    if (_typingDone || !_tw.isTyping) return const SizedBox.shrink();
    return Positioned(
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
    );
  }

  // ─── Phase 1: One sentence per page, centered ───

  Widget _buildSentencePage() {
    return GestureDetector(
      onTap: _typingDone ? _nextSentence : null,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          Column(
            children: [
              // Step indicator
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _isZh ? '第一步 · ${widget.data.stepNameZh ?? '思想实验'}' : 'Step 1 · ${widget.data.stepNameEn ?? 'Thought Experiment'}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accent,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),

              // Centered sentence with typewriter
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      _tw.displayText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        color: AppColors.textPrimary,
                        height: 1.8,
                      ),
                    ),
                  ),
                ),
              ),

              // Tap hint
              AnimatedOpacity(
                opacity: _typingDone ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
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
          _buildFastForwardButton(),
        ],
      ),
    );
  }

  void _nextSentence() {
    if (_sentenceIndex < _sentences.length - 1) {
      setState(() {
        _sentenceIndex++;
      });
      _startTyping(_fmt(_sentences[_sentenceIndex]));
    } else {
      setState(() {
        _showChoices = true;
        _choicesVisible = false;
        _typingDone = false;
      });
      // Type the heading, then show choices
      final heading = _isZh
          ? (widget.data.choicesHeadingZh ?? '你会怎么做？')
          : (widget.data.choicesHeadingEn ?? 'What would you do?');
      _tw.start(
        text: heading,
        isZh: _isZh,
        onUpdate: () {
          if (mounted) setState(() {});
        },
        onComplete: () {
          if (mounted) {
            setState(() {
              _typingDone = true;
              _choicesVisible = true;
            });
          }
        },
      );
    }
  }

  // ─── Phase 2: Choices, centered ───

  Widget _buildChoicesPage() {
    return Column(
      children: [
        // Step indicator
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              _isZh ? '第一步 · ${widget.data.stepNameZh ?? '思想实验'}' : 'Step 1 · ${widget.data.stepNameEn ?? 'Thought Experiment'}',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.accent,
                letterSpacing: 1,
              ),
            ),
          ),
        ),

        // Centered choices
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _tw.displayText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: AppColors.textPrimary,
                      height: 1.8,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Choices fade in one by one after heading typing completes
                  StaggeredFadeIn(
                    show: _choicesVisible,
                    children: widget.data.choices.asMap().entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _ChoiceButton(
                          text: _isZh
                              ? entry.value.textZh
                              : entry.value.textEn,
                          onTap: () => _onChoiceSelected(entry.key),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onChoiceSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _isThinking = true;
    });

    // 1.5s thinking pause, then transition
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isThinking = false;
          _showTransition = true;
        });
        _startTyping(_fmt(_isZh
            ? widget.data.choices[_selectedIndex!].transitionZh
            : widget.data.choices[_selectedIndex!].transitionEn));
      }
    });
  }

  // ─── Thinking page (between choice and transition) ───

  Widget _buildThinkingPage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              _isZh ? '第一步 · ${widget.data.stepNameZh ?? '思想实验'}' : 'Step 1 · ${widget.data.stepNameEn ?? 'Thought Experiment'}',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.accent,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
        const Expanded(
          child: Center(
            child: ThinkingIndicator(asBubble: false),
          ),
        ),
      ],
    );
  }

  // ─── Phase 3: Per-choice transition, centered ───

  Widget _buildTransitionPage() {
    return GestureDetector(
      onTap: _typingDone
          ? () {
              setState(() {
                _showCommonTransition = true;
              });
              _startTyping(_fmt(_isZh
                  ? widget.data.commonTransitionZh
                  : widget.data.commonTransitionEn));
            }
          : null,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _isZh
                        ? '第一步 · ${widget.data.stepNameZh ?? '思想实验'}'
                        : 'Step 1 · ${widget.data.stepNameEn ?? 'Thought Experiment'}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accent,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      _tw.displayText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        color: AppColors.textPrimary,
                        height: 1.8,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: _typingDone ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
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
          _buildFastForwardButton(),
        ],
      ),
    );
  }

  // ─── Phase 4: Common transition, centered ───

  Widget _buildCommonTransitionPage() {
    return GestureDetector(
      onTap: _typingDone ? widget.onComplete : null,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _isZh
                        ? '第一步 · ${widget.data.stepNameZh ?? '思想实验'}'
                        : 'Step 1 · ${widget.data.stepNameEn ?? 'Thought Experiment'}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accent,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      _tw.displayText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        color: AppColors.textPrimary,
                        height: 1.8,
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: _typingDone ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                  child: Text(
                    _isZh ? '轻触开始学习' : 'tap to start learning',
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
          _buildFastForwardButton(),
        ],
      ),
    );
  }
}

class _ChoiceButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const _ChoiceButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border:
                Border.all(color: AppColors.accent.withValues(alpha: 0.4)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.textPrimary,
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
