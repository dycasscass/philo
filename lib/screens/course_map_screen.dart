import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../services/storage_service.dart';
import '../data/worlds/ancient_greece/plato_lesson1_cave.dart';
import '../data/worlds/ancient_greece/plato_lesson2_forms.dart';
import 'lesson/lesson_screen.dart';

/// 课程地图中每个课程节点的静态配置
class _LessonConfig {
  final String lessonId;
  final int number;
  final String titleZh;
  final String titleEn;
  final String subtitleZh;
  final String subtitleEn;
  final String philosopherNameZh;
  final String philosopherNameEn;

  const _LessonConfig({
    required this.lessonId,
    required this.number,
    required this.titleZh,
    required this.titleEn,
    required this.subtitleZh,
    required this.subtitleEn,
    required this.philosopherNameZh,
    required this.philosopherNameEn,
  });
}

/// 按顺序排列的课程列表，完成第 N 课解锁第 N+1 课
const _lessons = [
  _LessonConfig(
    lessonId: 'plato_cave',
    number: 1,
    titleZh: '洞穴寓言',
    titleEn: 'The Cave',
    subtitleZh: '你看到的是真实的吗？',
    subtitleEn: 'Is what you see real?',
    philosopherNameZh: '柏拉图',
    philosopherNameEn: 'Plato',
  ),
  _LessonConfig(
    lessonId: 'plato_forms',
    number: 2,
    titleZh: '理型论',
    titleEn: 'Theory of Forms',
    subtitleZh: '\u201c真实\u201d存在于何处？',
    subtitleEn: 'Where does the \u2018real\u2019 exist?',
    philosopherNameZh: '柏拉图',
    philosopherNameEn: 'Plato',
  ),
  _LessonConfig(
    lessonId: 'plato_republic',
    number: 3,
    titleZh: '理想国',
    titleEn: 'The Republic',
    subtitleZh: '谁应该统治？',
    subtitleEn: 'Who should rule?',
    philosopherNameZh: '柏拉图',
    philosopherNameEn: 'Plato',
  ),
  _LessonConfig(
    lessonId: 'aristotle_form_matter',
    number: 4,
    titleZh: '形式与质料',
    titleEn: 'Form and Matter',
    subtitleZh: '事物的本质在哪里？',
    subtitleEn: 'Where is the essence of things?',
    philosopherNameZh: '亚里士多德',
    philosopherNameEn: 'Aristotle',
  ),
  _LessonConfig(
    lessonId: 'aristotle_virtue',
    number: 5,
    titleZh: '德性伦理',
    titleEn: 'Virtue Ethics',
    subtitleZh: '怎样才算活得好？',
    subtitleEn: 'What does it mean to live well?',
    philosopherNameZh: '亚里士多德',
    philosopherNameEn: 'Aristotle',
  ),
  _LessonConfig(
    lessonId: 'stoic_fate_freedom',
    number: 6,
    titleZh: '命运与自由',
    titleEn: 'Fate and Freedom',
    subtitleZh: '什么是你能控制的？',
    subtitleEn: 'What is within your control?',
    philosopherNameZh: '斯多葛',
    philosopherNameEn: 'Stoics',
  ),
  _LessonConfig(
    lessonId: 'epicurus_death_pleasure',
    number: 7,
    titleZh: '死亡与快乐',
    titleEn: 'Death and Pleasure',
    subtitleZh: '你在害怕什么？',
    subtitleEn: 'What are you afraid of?',
    philosopherNameZh: '伊壁鸠鲁',
    philosopherNameEn: 'Epicurus',
  ),
  _LessonConfig(
    lessonId: 'diogenes_nature_convention',
    number: 8,
    titleZh: '自然与规范',
    titleEn: 'Nature and Convention',
    subtitleZh: '哪些规则值得遵守？',
    subtitleEn: 'Which rules are worth following?',
    philosopherNameZh: '第欧根尼',
    philosopherNameEn: 'Diogenes',
  ),
];

/// lessonId → Lesson 数据的映射（后续添加新课程时在这里注册）
final _lessonDataMap = {
  'plato_cave': platoLesson1Cave,
  'plato_forms': platoLesson2Forms,
  // 填完课程数据后取消注释：
  // 'plato_republic': platoLesson3Republic,
};

class CourseMapScreen extends StatefulWidget {
  final AppLocalizations l10n;
  final StorageService storage;

  const CourseMapScreen({super.key, required this.l10n, required this.storage});

  @override
  State<CourseMapScreen> createState() => _CourseMapScreenState();
}

class _CourseMapScreenState extends State<CourseMapScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: 测试用，测完删掉
    widget.storage.completeLesson('plato_cave');
  }

  bool get _isZh => widget.l10n.language == AppLanguage.zh;

  /// 判断课程状态：completed / unlocked / locked
  String _lessonStatus(int index) {
    final config = _lessons[index];
    if (widget.storage.isLessonCompleted(config.lessonId)) {
      print('[DEBUG] Lesson ${config.lessonId}: completed');
      return 'completed';
    }
    // 第一课始终解锁；其余课程在前一课完成后解锁
    if (index == 0) {
      print('[DEBUG] Lesson ${config.lessonId}: unlocked (first)');
      return 'unlocked';
    }
    final prevId = _lessons[index - 1].lessonId;
    final prevDone = widget.storage.isLessonCompleted(prevId);
    print('[DEBUG] Lesson ${config.lessonId}: prev=$prevId done=$prevDone');
    if (prevDone) return 'unlocked';
    return 'locked';
  }

  /// 章节测验：所有课程完成后解锁
  String get _quizStatus {
    final allDone = _lessons.every(
      (c) => widget.storage.isLessonCompleted(c.lessonId),
    );
    return allDone ? 'unlocked' : 'locked';
  }

  void _openLesson(int index) async {
    final config = _lessons[index];
    final lessonData = _lessonDataMap[config.lessonId];
    print('[DEBUG] _openLesson: ${config.lessonId}, hasData=${lessonData != null}');
    if (lessonData == null) return; // 课程数据还没添加

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LessonScreen(
          lesson: lessonData,
          philosopherNameZh: config.philosopherNameZh,
          philosopherNameEn: config.philosopherNameEn,
          l10n: widget.l10n,
          storage: widget.storage,
        ),
      ),
    );
    // 返回后刷新状态
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('[DEBUG] completedLessons: ${widget.storage.completedLessons}');
    print('[DEBUG] _lessonDataMap keys: ${_lessonDataMap.keys.toList()}');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.l10n.get('course_map_title')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _isZh ? '古希腊哲学' : 'Ancient Greek Philosophy',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 32),

            // 课程节点
            for (int i = 0; i < _lessons.length; i++) ...[
              if (i > 0) _PathConnector(status: _lessonStatus(i)),
              _LessonNode(
                number: _lessons[i].number,
                titleZh: '${_lessons[i].philosopherNameZh}：${_lessons[i].titleZh}',
                titleEn: '${_lessons[i].philosopherNameEn}: ${_lessons[i].titleEn}',
                subtitleZh: _lessons[i].subtitleZh,
                subtitleEn: _lessons[i].subtitleEn,
                isZh: _isZh,
                status: _lessonStatus(i),
                onTap: () => _openLesson(i),
              ),
            ],

            // 章节测验
            _PathConnector(status: _quizStatus),
            _LessonNode(
              number: 0,
              titleZh: '章节测验',
              titleEn: 'Chapter Quiz',
              subtitleZh: '检验你对古希腊哲学的理解',
              subtitleEn: 'Test your understanding of Ancient Greek Philosophy',
              isZh: _isZh,
              status: _quizStatus,
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
  final String status; // 'completed' | 'unlocked' | 'locked'
  final bool isQuiz;
  final VoidCallback? onTap;

  const _LessonNode({
    required this.number,
    required this.titleZh,
    required this.titleEn,
    required this.subtitleZh,
    required this.subtitleEn,
    required this.isZh,
    required this.status,
    this.isQuiz = false,
    this.onTap,
  });

  bool get _isLocked => status == 'locked';
  bool get _isCompleted => status == 'completed';
  bool get _isUnlocked => status == 'unlocked' || _isCompleted;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isUnlocked ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _isUnlocked ? AppColors.surfaceLight : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isCompleted
                ? AppColors.success.withValues(alpha: 0.5)
                : _isUnlocked
                    ? AppColors.accent.withValues(alpha: 0.4)
                    : AppColors.divider,
            width: _isUnlocked ? 2 : 1,
          ),
          boxShadow: _isUnlocked
              ? [
                  BoxShadow(
                    color: (_isCompleted ? AppColors.success : AppColors.accent)
                        .withValues(alpha: 0.1),
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
                color: _isCompleted
                    ? AppColors.success
                    : _isUnlocked
                        ? AppColors.accent
                        : AppColors.divider,
              ),
              child: Center(
                child: _isCompleted
                    ? const Icon(Icons.check, color: Colors.white, size: 24)
                    : isQuiz
                        ? const Icon(Icons.quiz_outlined,
                            color: Colors.white, size: 22)
                        : Text(
                            '$number',
                            style: const TextStyle(
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
                      color: _isUnlocked
                          ? AppColors.textPrimary
                          : AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isZh ? subtitleZh : subtitleEn,
                    style: TextStyle(
                      fontSize: 13,
                      color: _isUnlocked
                          ? AppColors.textSecondary
                          : AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
            // Trailing icon
            Icon(
              _isCompleted
                  ? Icons.check_circle
                  : _isUnlocked
                      ? Icons.arrow_forward_ios
                      : Icons.lock_outline,
              size: 18,
              color: _isCompleted
                  ? AppColors.success
                  : _isUnlocked
                      ? AppColors.accent
                      : AppColors.textLight,
            ),
          ],
        ),
      ),
    );
  }
}

class _PathConnector extends StatelessWidget {
  final String status;

  const _PathConnector({this.status = 'locked'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 2,
        height: 32,
        color: status == 'completed' ? AppColors.success : AppColors.divider,
      ),
    );
  }
}
