import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../data/worlds/ancient_greece/plato_lesson1_cave.dart';
import 'lesson/lesson_screen.dart';

class CourseMapScreen extends StatelessWidget {
  final AppLocalizations l10n;

  const CourseMapScreen({super.key, required this.l10n});

  bool get _isZh => l10n.language == AppLanguage.zh;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.get('course_map_title')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // World header
            Text(
              _isZh ? '古希腊哲学' : 'Ancient Greek Philosophy',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              _isZh ? '章节一：柏拉图' : 'Chapter 1: Plato',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),

            // Lesson node
            _LessonNode(
              number: 1,
              titleZh: '洞穴寓言',
              titleEn: 'The Cave',
              subtitleZh: '你看到的是真实的吗？',
              subtitleEn: 'Is what you see real?',
              isZh: _isZh,
              isUnlocked: true,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => LessonScreen(
                      lesson: platoLesson1Cave,
                      philosopherNameZh: '柏拉图',
                      philosopherNameEn: 'Plato',
                      l10n: l10n,
                    ),
                  ),
                );
              },
            ),
            _PathConnector(),
            _LessonNode(
              number: 2,
              titleZh: '理念论',
              titleEn: 'Theory of Forms',
              subtitleZh: '完美的圆存在吗？',
              subtitleEn: 'Does a perfect circle exist?',
              isZh: _isZh,
              isUnlocked: false,
              onTap: null,
            ),
            _PathConnector(),
            _LessonNode(
              number: 3,
              titleZh: '理想国',
              titleEn: 'The Republic',
              subtitleZh: '谁应该统治？',
              subtitleEn: 'Who should rule?',
              isZh: _isZh,
              isUnlocked: false,
              onTap: null,
            ),
            _PathConnector(),
            _LessonNode(
              number: 0,
              titleZh: '章节测验',
              titleEn: 'Chapter Quiz',
              subtitleZh: '检验你对柏拉图的理解',
              subtitleEn: 'Test your understanding of Plato',
              isZh: _isZh,
              isUnlocked: false,
              isQuiz: true,
              onTap: null,
            ),
          ],
        ),
      ),
    );
  }
}

class _LessonNode extends StatelessWidget {
  final int number;
  final String titleZh;
  final String titleEn;
  final String subtitleZh;
  final String subtitleEn;
  final bool isZh;
  final bool isUnlocked;
  final bool isQuiz;
  final VoidCallback? onTap;

  const _LessonNode({
    required this.number,
    required this.titleZh,
    required this.titleEn,
    required this.subtitleZh,
    required this.subtitleEn,
    required this.isZh,
    required this.isUnlocked,
    this.isQuiz = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isUnlocked ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isUnlocked ? AppColors.surfaceLight : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isUnlocked
                ? AppColors.accent.withValues(alpha: 0.4)
                : AppColors.divider,
            width: isUnlocked ? 2 : 1,
          ),
          boxShadow: isUnlocked
              ? [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // Node circle
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isUnlocked
                    ? AppColors.accent
                    : AppColors.divider,
              ),
              child: Center(
                child: isQuiz
                    ? Icon(
                        Icons.quiz_outlined,
                        color: Colors.white,
                        size: 22,
                      )
                    : Text(
                        '$number',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 16),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isZh ? titleZh : titleEn,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: isUnlocked
                          ? AppColors.textPrimary
                          : AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isZh ? subtitleZh : subtitleEn,
                    style: TextStyle(
                      fontSize: 13,
                      color: isUnlocked
                          ? AppColors.textSecondary
                          : AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
            // Arrow or lock
            Icon(
              isUnlocked ? Icons.arrow_forward_ios : Icons.lock_outline,
              size: 18,
              color: isUnlocked ? AppColors.accent : AppColors.textLight,
            ),
          ],
        ),
      ),
    );
  }
}

class _PathConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 2,
        height: 32,
        color: AppColors.divider,
      ),
    );
  }
}
