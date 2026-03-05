import 'dart:async';
import 'package:flutter/material.dart';
import '../../models/lesson.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_theme.dart';
import '../../widgets/typewriter_controller.dart';
import '../../widgets/staggered_fade_in.dart';

class TeachingStepScreen extends StatefulWidget {
  final Teaching data;
  final AppLocalizations l10n;
  final VoidCallback onComplete;

  const TeachingStepScreen({
    super.key,
    required this.data,
    required this.l10n,
    required this.onComplete,
  });

  @override
  State<TeachingStepScreen> createState() => _TeachingStepScreenState();
}

class _TeachingStepScreenState extends State<TeachingStepScreen> {
  int _currentStep = -1;
  bool _showExtra = false;
  int? _analogyChoice;
  final ScrollController _scrollController = ScrollController();

  // Typewriter
  final _tw = TypewriterController();
  bool _typingDone = false;
  // For analogy page: show question after analogy text finishes
  bool _analogyQuestionVisible = false;

  bool get _isZh => widget.l10n.language == AppLanguage.zh;
  int get _totalTeachingSteps => widget.data.steps.length;

  // Phases: background(-1, skipped if empty), steps(0..n-1), insight(n, skipped if empty), analogy(n+1), legacy(n+2, skipped if empty)
  bool get _hasBackground => widget.data.backgroundZh.isNotEmpty;
  bool get _hasInsight => widget.data.coreInsightZh.isNotEmpty;
  bool get _hasLegacy => widget.data.legacyZh.isNotEmpty;
  bool get _isBackground => _currentStep == -1;
  bool get _isTeachingStep =>
      _currentStep >= 0 && _currentStep < _totalTeachingSteps;
  bool get _isInsight => _currentStep == _totalTeachingSteps;
  bool get _isAnalogy => _currentStep == _totalTeachingSteps + 1;
  bool get _isLegacy => _currentStep == _totalTeachingSteps + 2;

  @override
  void initState() {
    super.initState();
    if (!_hasBackground) _currentStep = 0; // skip background if empty
    _startTypingForCurrentStep();
  }

  @override
  void dispose() {
    _tw.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// Format body text: one sentence per line.
  String _fmt(String text) {
    if (_isZh) {
      return text.replaceAllMapped(RegExp(r'。(?!$|\n)'), (m) => '。\n');
    }
    return text.replaceAllMapped(
        RegExp(r'([.!?])\s+(?=[A-Z])'), (m) => '${m.group(1)}\n');
  }

  void _startTypingForCurrentStep() {
    _typingDone = false;
    _analogyQuestionVisible = false;

    String text;
    if (_isBackground) {
      text = _fmt(_isZh ? widget.data.backgroundZh : widget.data.backgroundEn);
    } else if (_isTeachingStep) {
      final step = widget.data.steps[_currentStep];
      text = _isZh ? step.contentZh : step.contentEn;
    } else if (_isInsight) {
      text = _isZh ? widget.data.coreInsightZh : widget.data.coreInsightEn;
    } else if (_isAnalogy) {
      text = _isZh
          ? widget.data.modernAnalogyZh
          : widget.data.modernAnalogyEn;
    } else if (_isLegacy) {
      text = _isZh ? widget.data.legacyZh : widget.data.legacyEn;
    } else {
      return;
    }

    _tw.start(
      text: text,
      isZh: _isZh,
      fast: _isTeachingStep, // story content types faster
      onUpdate: () {
        if (mounted) setState(() {});
      },
      onScroll: _isTeachingStep ? _scrollToBottom : null,
      onComplete: () {
        if (mounted) {
          setState(() => _typingDone = true);
          if (_isAnalogy && widget.data.analogyQuestion != null) {
            // Show analogy question after a brief pause
            Future.delayed(const Duration(milliseconds: 300), () {
              if (mounted) setState(() => _analogyQuestionVisible = true);
            });
          }
          if (_isTeachingStep) _scrollToBottom();
        }
      },
    );
  }

  void _startTypingExtra() {
    final step = widget.data.steps[_currentStep];
    final text = _isZh
        ? step.extraExplanationZh!
        : (step.extraExplanationEn ?? step.extraExplanationZh!);
    _typingDone = false;
    _tw.start(
      text: text,
      isZh: _isZh,
      fast: true, // extra explanations also type faster
      onUpdate: () {
        if (mounted) setState(() {});
      },
      onScroll: _scrollToBottom,
      onComplete: () {
        if (mounted) setState(() => _typingDone = true);
      },
    );
  }

  void _skipTypewriter() {
    _tw.skip();
    setState(() => _typingDone = true);
    if (_isAnalogy && widget.data.analogyQuestion != null) {
      setState(() => _analogyQuestionVisible = true);
    }
    _scrollToBottom();
  }

  void _advance() {
    _showExtra = false;
    _currentStep++;
    // Skip empty insight page
    if (_isInsight && !_hasInsight) _currentStep++;
    // Skip empty legacy page → complete teaching
    if (_isLegacy && !_hasLegacy) {
      widget.onComplete();
      return;
    }
    setState(() {});
    _startTypingForCurrentStep();
    _scrollToBottom();
  }

  void _showExtraExplanation() {
    setState(() => _showExtra = true);
    _startTypingExtra();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ─── Fast-forward button ───

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

  @override
  Widget build(BuildContext context) {
    // Centered pages intercept early
    if (_isBackground) return _buildBackgroundPage();
    if (_isInsight) return _buildInsightPage();
    if (_isAnalogy) return _buildAnalogyPage();
    if (_isLegacy) return _buildLegacyPage();

    // Scrollable pages (teaching steps only)
    return Stack(
      children: [
        Column(
          children: [
            // Progress bar
            LinearProgressIndicator(
              value: (_currentStep + 2) / (_totalTeachingSteps + 4),
              backgroundColor: AppColors.divider,
              valueColor: AlwaysStoppedAnimation(AppColors.accent),
              minHeight: 3,
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step indicator
                    Text(
                      _isZh ? '第二步 · 核心教学' : 'Step 2 · Core Teaching',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accent,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Teaching steps shown so far (collapsed)
                    for (int i = 0;
                        i < _currentStep && i < _totalTeachingSteps;
                        i++) ...[
                      _TeachingStepCard(
                        step: widget.data.steps[i],
                        stepNumber: i + 1,
                        isZh: _isZh,
                        isExpanded: false,
                      ),
                      const SizedBox(height: 12),
                    ],

                    // Current teaching step (expanded, with typewriter)
                    if (_isTeachingStep) ...[
                      _TeachingStepCard(
                        step: widget.data.steps[_currentStep],
                        stepNumber: _currentStep + 1,
                        isZh: _isZh,
                        isExpanded: true,
                        // When extra is showing, main content is done → null = full text
                        displayText: _showExtra ? null : _tw.displayText,
                        showExtra: _showExtra,
                        extraDisplayText: _showExtra ? _tw.displayText : null,
                      ),
                      const SizedBox(height: 20),
                      // Buttons: fade in one by one after typing completes
                      StaggeredFadeIn(
                        show: _typingDone,
                        children: [
                          TextButton(
                            onPressed: _typingDone ? _advance : null,
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.accent,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: Text(
                              _isZh ? '继续 →' : 'Continue →',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          if (!_showExtra &&
                              widget.data.steps[_currentStep].extraExplanationZh != null)
                            TextButton(
                              onPressed: _typingDone ? _showExtraExplanation : null,
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.textSecondary,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              child: Text(
                                _isZh ? '再解释一下 🤔' : 'Explain more 🤔',
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                        ],
                      ),
                    ],

                    // Bottom padding so content sits in middle-lower area
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  ],
                ),
              ),
            ),
          ],
        ),
        _buildFastForwardButton(),
      ],
    );
  }

  // ─── Background: centered, grey italic ───

  Widget _buildBackgroundPage() {
    return GestureDetector(
      onTap: _typingDone ? _advance : null,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          Column(
            children: [
              LinearProgressIndicator(
                value: 1 / (_totalTeachingSteps + 4),
                backgroundColor: AppColors.divider,
                valueColor: AlwaysStoppedAnimation(AppColors.accent),
                minHeight: 3,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _isZh ? '第二步 · 核心教学' : 'Step 2 · Core Teaching',
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
                        fontSize: 16,
                        color: AppColors.textSecondary,
                        height: 1.8,
                        fontStyle: FontStyle.italic,
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

  // ─── Core Insight: centered with InsightCard ───

  Widget _buildInsightPage() {
    return GestureDetector(
      onTap: _typingDone ? _advance : null,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          Column(
            children: [
              LinearProgressIndicator(
                value: (_currentStep + 2) / (_totalTeachingSteps + 4),
                backgroundColor: AppColors.divider,
                valueColor: AlwaysStoppedAnimation(AppColors.accent),
                minHeight: 3,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _isZh ? '第二步 · 核心教学' : 'Step 2 · Core Teaching',
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
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _InsightCard(
                      displayText: _tw.displayText,
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

  // ─── Analogy + Question: scrollable standalone page ───

  Widget _buildAnalogyPage() {
    return Stack(
      children: [
        Column(
          children: [
            LinearProgressIndicator(
              value: (_currentStep + 2) / (_totalTeachingSteps + 4),
              backgroundColor: AppColors.divider,
              valueColor: AlwaysStoppedAnimation(AppColors.accent),
              minHeight: 3,
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step indicator
                    Text(
                      _isZh ? '第二步 · 核心教学' : 'Step 2 · Core Teaching',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accent,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Modern analogy card with typewriter
                    _ContentCard(
                      displayText: _tw.displayText,
                      icon: Icons.phone_android,
                    ),

                    // Analogy question (if present) — fade in after text typing
                    if (widget.data.analogyQuestion != null) ...[
                      AnimatedOpacity(
                        opacity: _analogyQuestionVisible ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            _isZh
                                ? widget.data.analogyQuestion!.questionZh
                                : widget.data.analogyQuestion!.questionEn,
                            style: const TextStyle(
                              fontSize: 15,
                              color: AppColors.textPrimary,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      StaggeredFadeIn(
                        show: _analogyQuestionVisible,
                        staggerDelay: const Duration(milliseconds: 250),
                        children: widget.data.analogyQuestion!.options
                            .asMap()
                            .entries
                            .map((entry) {
                          final selected = _analogyChoice == entry.key;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: GestureDetector(
                              onTap: _analogyChoice == null
                                  ? () {
                                      setState(
                                          () => _analogyChoice = entry.key);
                                      _scrollToBottom();
                                      Future.delayed(
                                          const Duration(
                                              milliseconds: 1000), () {
                                        if (mounted) _advance();
                                      });
                                    }
                                  : null,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? AppColors.accent
                                          .withValues(alpha: 0.12)
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: selected
                                        ? AppColors.accent
                                        : AppColors.divider,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  _isZh
                                      ? entry.value.textZh
                                      : entry.value.textEn,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textPrimary,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],

                    // If no analogy question, show tap hint after typing
                    if (widget.data.analogyQuestion == null &&
                        _typingDone) ...[
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: _advance,
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

                    // Bottom padding so content sits in middle-lower area
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  ],
                ),
              ),
            ),
          ],
        ),
        _buildFastForwardButton(),
      ],
    );
  }

  // ─── Legacy: centered with InsightCard ───

  Widget _buildLegacyPage() {
    return GestureDetector(
      onTap: _typingDone ? widget.onComplete : null,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          Column(
            children: [
              LinearProgressIndicator(
                value: 1.0,
                backgroundColor: AppColors.divider,
                valueColor: AlwaysStoppedAnimation(AppColors.accent),
                minHeight: 3,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _isZh ? '第二步 · 核心教学' : 'Step 2 · Core Teaching',
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
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _InsightCard(
                      displayText: _tw.displayText,
                      icon: Icons.auto_awesome,
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
                    _isZh ? '轻触进入对话' : 'tap to enter dialogue',
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

class _ContentCard extends StatelessWidget {
  final String displayText;
  final IconData icon;

  const _ContentCard({required this.displayText, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.accent, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              displayText,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textPrimary,
                height: 1.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TeachingStepCard extends StatelessWidget {
  final TeachingStep step;
  final int stepNumber;
  final bool isZh;
  final bool isExpanded;
  final String? displayText; // typewriter text for expanded card
  final bool showExtra;
  final String? extraDisplayText; // typewriter text for extra explanation

  const _TeachingStepCard({
    required this.step,
    required this.stepNumber,
    required this.isZh,
    this.isExpanded = false,
    this.displayText,
    this.showExtra = false,
    this.extraDisplayText,
  });

  @override
  Widget build(BuildContext context) {
    final fullText = isZh ? step.contentZh : step.contentEn;
    final shownText = isExpanded ? (displayText ?? fullText) : fullText;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isExpanded ? AppColors.surfaceLight : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: isExpanded
            ? Border.all(color: AppColors.accent.withValues(alpha: 0.3))
            : Border.all(color: AppColors.divider.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            shownText,
            style: TextStyle(
              fontSize: isExpanded ? 15 : 13,
              color:
                  isExpanded ? AppColors.textPrimary : AppColors.textSecondary,
              height: 1.7,
            ),
          ),
          if (showExtra && step.extraExplanationZh != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('💡 ', style: TextStyle(fontSize: 14)),
                  Expanded(
                    child: Text(
                      extraDisplayText ??
                          (isZh
                              ? step.extraExplanationZh!
                              : (step.extraExplanationEn ??
                                  step.extraExplanationZh!)),
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  final String displayText;
  final IconData? icon;

  const _InsightCard({
    required this.displayText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent.withValues(alpha: 0.15),
            AppColors.accent.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon always visible
          if (icon != null)
            Icon(icon, color: AppColors.accent, size: 22)
          else
            const Text('💡', style: TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              displayText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
                height: 1.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

