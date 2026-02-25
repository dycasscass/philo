import 'package:flutter/material.dart';
import '../../models/lesson.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_theme.dart';
import '../../widgets/typewriter_controller.dart';
import '../../widgets/staggered_fade_in.dart';

class ReflectionStepScreen extends StatefulWidget {
  final Reflection data;
  final AppLocalizations l10n;
  final void Function(String stance, String text) onComplete;

  const ReflectionStepScreen({
    super.key,
    required this.data,
    required this.l10n,
    required this.onComplete,
  });

  @override
  State<ReflectionStepScreen> createState() => _ReflectionStepScreenState();
}

class _ReflectionStepScreenState extends State<ReflectionStepScreen> {
  int? _selectedStance;
  final TextEditingController _textController = TextEditingController();
  bool _submitted = false;
  bool _skipped = false;
  final ScrollController _scrollController = ScrollController();

  // Typewriter for question
  final _tw = TypewriterController();
  bool _questionDone = false;

  bool get _isZh => widget.l10n.language == AppLanguage.zh;

  @override
  void initState() {
    super.initState();
    _textController.addListener(() => setState(() {}));
    // Start typing the question
    final questionText =
        _isZh ? widget.data.questionZh : widget.data.questionEn;
    _tw.start(
      text: questionText,
      isZh: _isZh,
      onUpdate: () {
        if (mounted) setState(() {});
      },
      onComplete: () {
        if (mounted) setState(() => _questionDone = true);
      },
    );
  }

  @override
  void dispose() {
    _tw.dispose();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    // After submission: show result + tap to continue
    if (_submitted) return _buildSubmittedPage();

    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Step indicator
              Text(
                _isZh ? '第四步 · 开放性反思' : 'Step 4 · Open Reflection',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accent,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 24),

              // Question with typewriter
              Text(
                _tw.displayText,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      height: 1.6,
                    ),
              ),
              const SizedBox(height: 24),

              // Stance choices (staggered fade-in after question typing done)
              if (widget.data.stances != null)
                StaggeredFadeIn(
                  show: _questionDone,
                  children: widget.data.stances!.asMap().entries.map((entry) {
                    final selected = _selectedStance == entry.key;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _selectedStance = entry.key);
                          _scrollToBottom();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.accent.withValues(alpha: 0.12)
                                : Colors.transparent,
                            border: Border.all(
                              color: selected
                                  ? AppColors.accent
                                  : AppColors.divider,
                              width: selected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _isZh
                                ? entry.value.textZh
                                : entry.value.textEn,
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.textPrimary,
                              height: 1.5,
                              fontWeight: selected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

              // Text input (show after stance selected, or immediately if no stances)
              if ((_selectedStance != null ||
                  widget.data.stances == null) &&
                  _questionDone) ...[
                const SizedBox(height: 16),
                Text(
                  _isZh
                      ? '说说你的理由。（📒 将保存到你的哲学笔记本）'
                      : 'Share your reasoning. (📒 Will be saved to your Philosophy Notebook)',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _textController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: _isZh
                        ? '写下你的想法……（没有字数限制，建议2-3句话）'
                        : 'Write your thoughts... (no word limit, 2-3 sentences suggested)',
                    hintStyle: TextStyle(color: AppColors.textLight),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.divider),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.divider),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.accent),
                    ),
                    filled: true,
                    fillColor: AppColors.surfaceLight,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _textController.text.trim().isNotEmpty
                        ? _submit
                        : null,
                    child: Text(_isZh ? '保存反思' : 'Save Reflection'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => _submit(skip: true),
                    child: Text(
                      _isZh ? '跳过' : 'Skip',
                      style: TextStyle(color: AppColors.textLight),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),

        // Fast-forward for question typing
        if (_tw.isTyping)
          Positioned(
            right: 16,
            bottom: 16,
            child: GestureDetector(
              onTap: () {
                _tw.skip();
                setState(() => _questionDone = true);
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
    );
  }

  // ─── After submission: show result + tap to enter quiz ───

  Widget _buildSubmittedPage() {
    return GestureDetector(
      onTap: () {
        final stance = _selectedStance != null
            ? (_isZh
                ? widget.data.stances![_selectedStance!].textZh
                : widget.data.stances![_selectedStance!].textEn)
            : '';
        widget.onComplete(stance, _textController.text.trim());
      },
      behavior: HitTestBehavior.translucent,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step indicator
            Text(
              _isZh ? '第四步 · 开放性反思' : 'Step 4 · Open Reflection',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.accent,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 20),

            // Only show save success + XP when user actually wrote something
            if (!_skipped) ...[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.success.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(Icons.check_circle,
                        color: AppColors.success, size: 36),
                    const SizedBox(height: 12),
                    Text(
                      _isZh
                          ? '你的反思已保存到「哲学笔记本」📖'
                          : 'Your reflection has been saved to "Philosophy Notebook" 📖',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '+${widget.data.xpReward} XP',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
            ],

            // Tap to enter quiz
            Center(
              child: Column(
                children: [
                  Text(
                    _isZh ? '进入测验 ···' : 'Entering quiz ···',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _isZh ? '轻触继续' : 'tap to continue',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textLight,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit({bool skip = false}) {
    setState(() {
      _submitted = true;
      _skipped = skip;
    });
  }
}
