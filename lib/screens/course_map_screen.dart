import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../services/storage_service.dart';
import '../models/world.dart';
import '../data/worlds/ancient_greece/plato_lesson1_cave.dart';
import '../data/worlds/ancient_greece/plato_lesson2_forms.dart';
import '../data/worlds/ancient_greece/plato_lesson3_republic.dart';
import 'lesson/lesson_screen.dart';

/// Each world node's calibrated positions on the map (percentage-based).
class _WorldNode {
  final String worldId;
  final double glowX, glowY;
  final double lockX, lockY;
  final double labelX, labelY;

  const _WorldNode({
    required this.worldId,
    required this.glowX, required this.glowY,
    required this.lockX, required this.lockY,
    required this.labelX, required this.labelY,
  });
}

const _worldNodes = <_WorldNode>[
  _WorldNode(worldId: 'ancient_greece',    glowX: 0.2308, glowY: 0.1204, lockX: 0.2300, lockY: 0.0900, labelX: 0.1698, labelY: 0.0516),
  _WorldNode(worldId: 'medieval',          glowX: 0.7200, glowY: 0.0900, lockX: 0.7089, lockY: 0.1337, labelX: 0.6434, labelY: 0.0661),
  _WorldNode(worldId: 'rationalism',       glowX: 0.5200, glowY: 0.2400, lockX: 0.6412, lockY: 0.3086, labelX: 0.5895, labelY: 0.2425),
  _WorldNode(worldId: 'empiricism',        glowX: 0.2500, glowY: 0.3400, lockX: 0.2489, lockY: 0.4154, labelX: 0.2005, labelY: 0.3520),
  _WorldNode(worldId: 'utilitarianism',    glowX: 0.7200, glowY: 0.3700, lockX: 0.7989, lockY: 0.4518, labelX: 0.7468, labelY: 0.3867),
  _WorldNode(worldId: 'german_idealism',   glowX: 0.4800, glowY: 0.4900, lockX: 0.5014, lockY: 0.5600, labelX: 0.4285, labelY: 0.4960),
  _WorldNode(worldId: 'life_philosophy',   glowX: 0.1400, glowY: 0.6600, lockX: 0.1449, lockY: 0.7231, labelX: 0.0968, labelY: 0.6583),
  _WorldNode(worldId: 'phenomenology',     glowX: 0.3800, glowY: 0.7000, lockX: 0.3803, lockY: 0.7230, labelX: 0.3379, labelY: 0.6577),
  _WorldNode(worldId: 'existentialism',    glowX: 0.6200, glowY: 0.6600, lockX: 0.6221, lockY: 0.7245, labelX: 0.5701, labelY: 0.6591),
  _WorldNode(worldId: 'analytic_philosophy', glowX: 0.8500, glowY: 0.6200, lockX: 0.8544, lockY: 0.7248, labelX: 0.7991, labelY: 0.6604),
  _WorldNode(worldId: 'contemporary',      glowX: 0.5000, glowY: 0.8500, lockX: 0.5003, lockY: 0.8949, labelX: 0.4486, labelY: 0.8303),
];

class CourseMapScreen extends StatefulWidget {
  final AppLocalizations l10n;
  final StorageService storage;
  final int restoreTrigger;

  const CourseMapScreen({super.key, required this.l10n, required this.storage, this.restoreTrigger = 0});

  @override
  State<CourseMapScreen> createState() => _CourseMapScreenState();
}

class _CourseMapScreenState extends State<CourseMapScreen>
    with TickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  // World lessons transition
  WorldConfig? _selectedWorld;
  late AnimationController _enterController;
  double _enterAlignX = 0;
  double _enterAlignY = 0;

  bool get _isZh => widget.l10n.language == AppLanguage.zh;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
    _enterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      reverseDuration: const Duration(milliseconds: 400),
    );
    _enterController.addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(covariant CourseMapScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.restoreTrigger != oldWidget.restoreTrigger && _selectedWorld == null) {
      final lastId = widget.storage.lastWorldId;
      if (lastId != null) {
        setState(() => _selectedWorld = findWorld(lastId));
        _enterController.forward(from: 0);
      }
    }
  }

  @override
  void dispose() {
    _glowController.dispose();
    _enterController.dispose();
    super.dispose();
  }

  String _worldStatus(String worldId) {
    if (widget.storage.isWorldCompleted(worldId)) return 'completed';
    final parents = getParentWorldIds(worldId);
    final allParentsDone =
        parents.isEmpty || parents.every((p) => widget.storage.isWorldCompleted(p));
    if (allParentsDone) return 'current';
    return 'locked';
  }

  void _onWorldTap(String worldId) {
    final status = _worldStatus(worldId);
    if (status == 'locked') return;

    final world = findWorld(worldId);
    if (worldId == 'ancient_greece') {
      final node = _worldNodes.firstWhere((n) => n.worldId == worldId);
      _enterAlignX = (node.glowX * 2) - 1;
      _enterAlignY = (node.glowY * 2) - 1;
      setState(() => _selectedWorld = world);
      widget.storage.setLastWorldId(worldId);
      _enterController.forward(from: 0);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isZh
                ? '${world.nameZh} — 即将推出'
                : '${world.nameEn} — Coming Soon',
          ),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void _goBackToMap() {
    _enterController.reverse().then((_) {
      if (mounted) setState(() => _selectedWorld = null);
    });
  }

  @override
  Widget build(BuildContext context) {
    final animValue = _enterController.value;
    final showLessons = _selectedWorld != null;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Map is always present
          _buildMapContent(context),

          // Lessons overlay (AppBar + body together, fade as one unit)
          if (showLessons)
            Opacity(
              opacity: animValue.clamp(0.0, 1.0),
              child: Container(
                color: AppColors.background,
                child: Column(
                  children: [
                    // Custom AppBar inside the overlay
                    AppBar(
                      automaticallyImplyLeading: false,
                      title: Text(_isZh ? _selectedWorld!.nameZh : _selectedWorld!.nameEn),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.map_outlined),
                          onPressed: _goBackToMap,
                        ),
                      ],
                    ),
                    Expanded(
                      child: _WorldLessonsBody(
                        world: _selectedWorld!,
                        l10n: widget.l10n,
                        storage: widget.storage,
                        isZh: _isZh,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMapContent(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const mapAspect = 768.0 / 1376.0; // width / height
        final screenHeight = constraints.maxHeight;
        final screenWidth = constraints.maxWidth;
        // Stretch map to fill available height, calculate width from aspect ratio
        final mapHeight = screenHeight;
        final mapWidth = mapHeight * mapAspect;
        final circleSize = mapWidth * 0.09;
        final lockSize = circleSize * 0.4;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: mapWidth,
            height: mapHeight,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Background map
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/map3.jpg',
                    fit: BoxFit.fill,
                  ),
                ),

                for (final node in _worldNodes) ...[
                  // 1. Glow (current world only)
                  if (_worldStatus(node.worldId) == 'current')
                    Positioned(
                      left: node.glowX * mapWidth - circleSize / 2,
                      top: node.glowY * mapHeight - circleSize / 2,
                      child: GestureDetector(
                        onTap: () => _onWorldTap(node.worldId),
                        child: AnimatedBuilder(
                          animation: _glowAnimation,
                          builder: (context, child) {
                            return Container(
                              width: circleSize,
                              height: circleSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFFFD700)
                                        .withValues(alpha: _glowAnimation.value),
                                    blurRadius: 20,
                                    spreadRadius: 8,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                  // 2. Lock (locked worlds only)
                  if (_worldStatus(node.worldId) == 'locked')
                    Positioned(
                      left: node.lockX * mapWidth - lockSize / 2,
                      top: node.lockY * mapHeight - lockSize / 2,
                      child: Icon(
                        Icons.lock,
                        color: const Color(0xFF332321),
                        size: lockSize,
                        shadows: const [
                          Shadow(color: Color(0xFFFFBF00), offset: Offset(2.5, 0), blurRadius: 0),
                          Shadow(color: Color(0xFFFFBF00), offset: Offset(-2.5, 0), blurRadius: 0),
                          Shadow(color: Color(0xFFFFBF00), offset: Offset(0, 2.5), blurRadius: 0),
                          Shadow(color: Color(0xFFFFBF00), offset: Offset(0, -2.5), blurRadius: 0),
                          Shadow(color: Color(0xFFFFBF00), offset: Offset(1.8, 1.8), blurRadius: 0),
                          Shadow(color: Color(0xFFFFBF00), offset: Offset(-1.8, 1.8), blurRadius: 0),
                          Shadow(color: Color(0xFFFFBF00), offset: Offset(1.8, -1.8), blurRadius: 0),
                          Shadow(color: Color(0xFFFFBF00), offset: Offset(-1.8, -1.8), blurRadius: 0),
                        ],
                      ),
                    ),

                  // 3. Label (always, centered on lockX)
                  Positioned(
                    left: node.lockX * mapWidth,
                    top: node.labelY * mapHeight - 3,
                    child: FractionalTranslation(
                      translation: const Offset(-0.5, 0.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1.5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5E6C8),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _isZh ? findWorld(node.worldId).nameZh : findWorld(node.worldId).nameEn,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: _worldStatus(node.worldId) == 'locked'
                                ? const Color(0xFF5D4037)
                                : const Color(0xFF3E2723),
                          ),
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ),
                    ),
                  ),

                  // 4. Tap target circle (transparent, on top)
                  Builder(builder: (context) {
                    final status = _worldStatus(node.worldId);
                    final double tapCenterX;
                    final double tapCenterY;
                    final double tapDiameter;

                    if (status == 'locked') {
                      final badgeBottom = node.labelY * mapHeight + 26;
                      final lockCenterY = node.lockY * mapHeight;
                      final radius = (lockCenterY - badgeBottom).abs().clamp(lockSize, circleSize);
                      tapCenterX = node.lockX * mapWidth;
                      tapCenterY = lockCenterY;
                      tapDiameter = radius * 2;
                    } else {
                      tapCenterX = node.glowX * mapWidth;
                      tapCenterY = node.glowY * mapHeight;
                      tapDiameter = circleSize;
                    }

                    return Positioned(
                      left: tapCenterX - tapDiameter / 2,
                      top: tapCenterY - tapDiameter / 2,
                      child: GestureDetector(
                        onTap: () => _onWorldTap(node.worldId),
                        child: Container(
                          width: tapDiameter,
                          height: tapDiameter,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

// ============================================================
// World Lessons Body (content without Scaffold)
// ============================================================

/// Per-lesson config inside a world.
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

final _lessonDataMap = {
  'plato_cave': platoLesson1Cave,
  'plato_forms': platoLesson2Forms,
  'plato_republic': platoLesson3Republic,
};

class _WorldLessonsBody extends StatefulWidget {
  final WorldConfig world;
  final AppLocalizations l10n;
  final StorageService storage;
  final bool isZh;

  const _WorldLessonsBody({
    required this.world,
    required this.l10n,
    required this.storage,
    required this.isZh,
  });

  @override
  State<_WorldLessonsBody> createState() => _WorldLessonsBodyState();
}

class _WorldLessonsBodyState extends State<_WorldLessonsBody> {
  String _lessonStatus(int index) {
    final config = _lessons[index];
    if (widget.storage.isLessonCompleted(config.lessonId)) return 'completed';
    // TODO: 开发阶段全部解锁，上线前改回来
    return 'unlocked';
  }

  String get _quizStatus {
    final allDone = _lessons.every(
      (c) => widget.storage.isLessonCompleted(c.lessonId),
    );
    return allDone ? 'unlocked' : 'locked';
  }

  void _openLesson(int index) async {
    final config = _lessons[index];
    final lessonData = _lessonDataMap[config.lessonId];
    if (lessonData == null) return;

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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          for (int i = 0; i < _lessons.length; i++) ...[
            if (i > 0) _PathConnector(status: _lessonStatus(i)),
            _LessonNode(
              number: _lessons[i].number,
              titleZh: '${_lessons[i].philosopherNameZh}：${_lessons[i].titleZh}',
              titleEn: '${_lessons[i].philosopherNameEn}: ${_lessons[i].titleEn}',
              subtitleZh: _lessons[i].subtitleZh,
              subtitleEn: _lessons[i].subtitleEn,
              isZh: widget.isZh,
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
            isZh: widget.isZh,
            status: _quizStatus,
            isQuiz: true,
            onTap: null,
          ),
        ],
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
  final String status;
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
                ? AppColors.success.withValues(alpha:0.5)
                : _isUnlocked
                    ? AppColors.accent.withValues(alpha:0.4)
                    : AppColors.divider,
            width: _isUnlocked ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
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
                        ? const Icon(Icons.quiz_outlined, color: Colors.white, size: 22)
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
