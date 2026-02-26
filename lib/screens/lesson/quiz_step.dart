import 'package:flutter/material.dart';
import '../../models/lesson.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_theme.dart';
import '../../widgets/staggered_fade_in.dart';

class QuizStepScreen extends StatefulWidget {
  final List<QuizQuestion> questions;
  final AppLocalizations l10n;
  final void Function(int correctCount) onComplete;

  const QuizStepScreen({
    super.key,
    required this.questions,
    required this.l10n,
    required this.onComplete,
  });

  @override
  State<QuizStepScreen> createState() => _QuizStepScreenState();
}

class _QuizStepScreenState extends State<QuizStepScreen> {
  int _currentQuestion = 0;
  int? _selectedAnswer;
  bool _showResult = false;
  int _correctCount = 0;
  bool _quizDone = false;

  bool get _isZh => widget.l10n.language == AppLanguage.zh;
  QuizQuestion get _question => widget.questions[_currentQuestion];
  bool get _isCorrect => _selectedAnswer == _question.correctIndex;

  @override
  Widget build(BuildContext context) {
    if (_quizDone) return _buildSummary(context);

    return Column(
      children: [
        // Progress
        LinearProgressIndicator(
          value: (_currentQuestion + 1) / widget.questions.length,
          backgroundColor: AppColors.divider,
          valueColor: AlwaysStoppedAnimation(AppColors.accent),
          minHeight: 3,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Step indicator
                Text(
                  _isZh
                      ? '第五步 · 测验 (${_currentQuestion + 1}/${widget.questions.length})'
                      : 'Step 5 · Quiz (${_currentQuestion + 1}/${widget.questions.length})',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accent,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 24),

                // Question
                Text(
                  _isZh ? _question.questionZh : _question.questionEn,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        height: 1.5,
                      ),
                ),
                const SizedBox(height: 24),

                // Options (staggered fade-in, reset per question)
                StaggeredFadeIn(
                  key: ValueKey(_currentQuestion),
                  show: true,
                  children: _question.options.asMap().entries.map((entry) {
                    final i = entry.key;
                    final option = entry.value;
                    final isSelected = _selectedAnswer == i;
                    final isCorrectOption = i == _question.correctIndex;

                    Color borderColor = AppColors.divider;
                    Color bgColor = Colors.transparent;
                    IconData? trailingIcon;
                    Color? iconColor;

                    if (_showResult) {
                      if (isCorrectOption) {
                        borderColor = AppColors.success;
                        bgColor = AppColors.success.withValues(alpha: 0.08);
                        trailingIcon = Icons.check_circle;
                        iconColor = AppColors.success;
                      } else if (isSelected && !isCorrectOption) {
                        borderColor = AppColors.error;
                        bgColor = AppColors.error.withValues(alpha: 0.08);
                        trailingIcon = Icons.cancel;
                        iconColor = AppColors.error;
                      }
                    } else if (isSelected) {
                      borderColor = AppColors.accent;
                      bgColor = AppColors.accent.withValues(alpha: 0.08);
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        onTap: _showResult
                            ? null
                            : () => setState(() => _selectedAnswer = i),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: bgColor,
                            border: Border.all(color: borderColor, width: isSelected || (_showResult && isCorrectOption) ? 2 : 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _isZh ? option.textZh : option.textEn,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.textPrimary,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              if (trailingIcon != null)
                                Icon(trailingIcon, color: iconColor, size: 22),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                // Submit / Explanation
                if (_selectedAnswer != null && !_showResult) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _checkAnswer,
                      child: Text(_isZh ? '确认' : 'Confirm'),
                    ),
                  ),
                ],

                if (_showResult) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: (_isCorrect
                              ? AppColors.success
                              : AppColors.error)
                          .withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isCorrect
                              ? (_isZh ? '正确！' : 'Correct!')
                              : (_isZh ? '不太对' : 'Not quite'),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _isCorrect
                                ? AppColors.success
                                : AppColors.error,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _isZh
                              ? _question.explanationZh
                              : _question.explanationEn,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _nextQuestion,
                      child: Text(
                        _currentQuestion < widget.questions.length - 1
                            ? (_isZh ? '下一题' : 'Next')
                            : (_isZh ? '查看结果' : 'See Results'),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummary(BuildContext context) {
    final total = widget.questions.length;
    final percent = (_correctCount / total * 100).round();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              percent >= 75 ? Icons.emoji_events : Icons.school,
              size: 64,
              color: AppColors.accent,
            ),
            const SizedBox(height: 24),
            Text(
              _isZh ? '测验完成！' : 'Quiz Complete!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              '$_correctCount / $total',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: AppColors.accent,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _isZh ? '答对 $percent%' : '$percent% correct',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '+${_correctCount * 10} XP',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.accent,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => widget.onComplete(_correctCount),
                child: Text(_isZh ? '完成本课' : 'Complete Lesson'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _checkAnswer() {
    setState(() {
      _showResult = true;
      if (_isCorrect) _correctCount++;
    });
  }

  void _nextQuestion() {
    if (_currentQuestion < widget.questions.length - 1) {
      setState(() {
        _currentQuestion++;
        _selectedAnswer = null;
        _showResult = false;
      });
    } else {
      setState(() => _quizDone = true);
    }
  }
}
