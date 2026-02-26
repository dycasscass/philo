import 'package:flutter/material.dart';
import '../../models/lesson.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_theme.dart';
import '../../services/storage_service.dart';
import 'thought_experiment_step.dart';
import 'teaching_step.dart';
import 'dialogue_step.dart';
import 'reflection_step.dart';
import 'quiz_step.dart';

class LessonScreen extends StatefulWidget {
  final Lesson lesson;
  final String philosopherNameZh;
  final String philosopherNameEn;
  final AppLocalizations l10n;
  final StorageService storage;

  const LessonScreen({
    super.key,
    required this.lesson,
    required this.philosopherNameZh,
    required this.philosopherNameEn,
    required this.l10n,
    required this.storage,
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int _currentStep = 0; // 0-4 for the 5 steps
  int _maxReachedStep = 0; // highest step the user has visited

  // Intro breathing pause
  bool _showIntro = true;
  bool _introReady = false;
  double _titleOpacity = 0.0;
  double _subtitleOpacity = 0.0;

  bool get _isZh => widget.l10n.language == AppLanguage.zh;

  String get _philosopherName =>
      _isZh ? widget.philosopherNameZh : widget.philosopherNameEn;

  @override
  void initState() {
    super.initState();
    // Start intro animation
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) setState(() => _titleOpacity = 1.0);
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) setState(() => _subtitleOpacity = 1.0);
    });
    // Ready for tap after animations complete
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => _introReady = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _showIntro
          ? null
          : AppBar(
              title: Text(
                _isZh
                    ? '$_philosopherName：${widget.lesson.titleZh.split(' — ').first}'
                    : '$_philosopherName: ${widget.lesson.titleEn.split(' — ').first}',
                style: const TextStyle(fontSize: 16),
              ),
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => _confirmExit(context),
              ),
              actions: [
                // Step indicator dots
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                    children: List.generate(5, (i) {
                      final canTap =
                          i <= _maxReachedStep && i != _currentStep;
                      return GestureDetector(
                        onTap: canTap
                            ? () => setState(() => _currentStep = i)
                            : null,
                        child: Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: i == _currentStep
                                ? AppColors.accent
                                : i <= _maxReachedStep
                                    ? AppColors.success
                                    : AppColors.divider,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _showIntro ? _buildIntroPage() : _buildCurrentStep(),
      ),
    );
  }

  // ─── Intro breathing pause page ───

  Widget _buildIntroPage() {
    // Extract lesson title parts
    final titleParts = _isZh
        ? widget.lesson.titleZh.split(' — ')
        : widget.lesson.titleEn.split(' — ');
    final mainTitle = titleParts.first;
    final subtitle = titleParts.length > 1 ? titleParts.last : '';

    return GestureDetector(
      key: const ValueKey('intro'),
      onTap: _introReady ? () => setState(() => _showIntro = false) : null,
      behavior: HitTestBehavior.translucent,
      child: Container(
        color: AppColors.background,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedOpacity(
                        opacity: _titleOpacity,
                        duration: const Duration(milliseconds: 800),
                        child: Text(
                          mainTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                            height: 1.4,
                          ),
                        ),
                      ),
                      if (subtitle.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        AnimatedOpacity(
                          opacity: _subtitleOpacity,
                          duration: const Duration(milliseconds: 800),
                          child: Text(
                            subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.textSecondary,
                              height: 1.6,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            // Tap hint
            AnimatedOpacity(
              opacity: _introReady ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
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
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return ThoughtExperimentStep(
          key: const ValueKey('step0'),
          data: widget.lesson.thoughtExperiment,
          l10n: widget.l10n,
          onComplete: () => _goToStep(1),
        );
      case 1:
        return TeachingStepScreen(
          key: const ValueKey('step1'),
          data: widget.lesson.teaching,
          l10n: widget.l10n,
          onComplete: () => _goToStep(2),
        );
      case 2:
        return DialogueStepScreen(
          key: const ValueKey('step2'),
          data: widget.lesson.dialogue,
          philosopherName: _philosopherName,
          l10n: widget.l10n,
          onComplete: () => _goToStep(3),
        );
      case 3:
        return ReflectionStepScreen(
          key: const ValueKey('step3'),
          data: widget.lesson.reflection,
          l10n: widget.l10n,
          onComplete: (stance, text) {
            // TODO: Save reflection to storage
            _goToStep(4);
          },
        );
      case 4:
        return QuizStepScreen(
          key: const ValueKey('step4'),
          questions: widget.lesson.quiz,
          l10n: widget.l10n,
          onComplete: (correctCount) {
            _showLessonComplete(correctCount);
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }

  void _goToStep(int step) {
    setState(() {
      _currentStep = step;
      if (step > _maxReachedStep) _maxReachedStep = step;
    });
  }

  void _showLessonComplete(int correctCount) async {
    final xp =
        correctCount * 10 + 20; // quiz XP (10 per correct) + reflection XP (20)

    // 持久化：保存课程完成状态、XP、解锁哲学家
    await widget.storage.completeLesson(widget.lesson.id);
    await widget.storage.addXp(xp);
    await widget.storage.unlockPhilosopher(widget.lesson.philosopherId);

    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Icon(Icons.celebration, size: 48, color: AppColors.accent),
            const SizedBox(height: 16),
            Text(
              _isZh ? '课程完成！' : 'Lesson Complete!',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '+$xp XP',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.accent,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _isZh
                  ? '你已解锁哲学家：$_philosopherName'
                  : 'Philosopher unlocked: $_philosopherName',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).pop(); // Return to course map
              },
              child: Text(_isZh ? '返回课程地图' : 'Back to Course Map'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmExit(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(_isZh ? '退出课程？' : 'Leave lesson?'),
        content: Text(
          _isZh ? '你的进度不会被保存。' : 'Your progress will not be saved.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(_isZh ? '继续学习' : 'Keep Learning'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: Text(
              _isZh ? '退出' : 'Leave',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
