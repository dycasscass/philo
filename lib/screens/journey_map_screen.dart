import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../services/storage_service.dart';
import '../models/world.dart';

class JourneyMapScreen extends StatelessWidget {
  final AppLocalizations l10n;
  final StorageService storage;

  const JourneyMapScreen({
    super.key,
    required this.l10n,
    required this.storage,
  });

  bool get _isZh => l10n.language == AppLanguage.zh;

  String _worldStatus(String worldId) {
    if (storage.isWorldCompleted(worldId)) return 'completed';
    if (worldId == 'ancient_greece') return 'unlocked';
    // Unlocked if all parent worlds are completed
    final parents = getParentWorldIds(worldId);
    if (parents.isEmpty) return 'locked';
    if (parents.every((p) => storage.isWorldCompleted(p))) return 'unlocked';
    return 'locked';
  }

  void _onWorldTap(BuildContext context, String worldId) {
    if (worldId == 'ancient_greece') {
      Navigator.of(context).pop();
    }
    // Future: navigate to other worlds' course maps
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.get('journey_map_title')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            // ── Row 1: 古希腊哲学 ──
            _buildSingleNode(context, 'ancient_greece'),
            const _VerticalConnector(),

            // ── Row 2: 中世纪哲学 ──
            _buildSingleNode(context, 'medieval'),
            const _VerticalConnector(),

            // ── Row 3: 理性主义 ──
            _buildSingleNode(context, 'rationalism'),
            const _VerticalConnector(),

            // ── Row 4: 经验主义 + 功利主义分支 ──
            _buildEmpirismRow(context),
            const _VerticalConnector(),

            // ── Row 5: 德国唯心主义 ──
            _buildSingleNode(context, 'german_idealism'),

            // ── Split connector: 1 → 4 ──
            SizedBox(
              height: 40,
              width: double.infinity,
              child: CustomPaint(
                painter: _SplitPainter(
                  color: AppColors.divider,
                ),
              ),
            ),

            // ── Row 6: 4 parallel branches ──
            _buildFourBranchRow(context),

            // ── Merge connector: 4 → 1 ──
            SizedBox(
              height: 40,
              width: double.infinity,
              child: CustomPaint(
                painter: _MergePainter(
                  color: AppColors.divider,
                ),
              ),
            ),

            // ── Row 7: 当代哲学 ──
            _buildSingleNode(context, 'contemporary'),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleNode(BuildContext context, String worldId) {
    final world = findWorld(worldId);
    final status = _worldStatus(worldId);
    return _WorldNode(
      world: world,
      status: status,
      isZh: _isZh,
      onTap: status != 'locked' ? () => _onWorldTap(context, worldId) : null,
    );
  }

  Widget _buildEmpirismRow(BuildContext context) {
    final empiricism = findWorld('empiricism');
    final utilitarianism = findWorld('utilitarianism');
    final empStatus = _worldStatus('empiricism');
    final utilStatus = _worldStatus('utilitarianism');

    // 经验主义在主线居中，功利主义紧贴右侧作为侧枝
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _WorldNode(
          world: empiricism,
          status: empStatus,
          isZh: _isZh,
          onTap: empStatus != 'locked'
              ? () => _onWorldTap(context, 'empiricism')
              : null,
        ),
        Container(width: 16, height: 2, color: AppColors.divider),
        _WorldNode(
          world: utilitarianism,
          status: utilStatus,
          isZh: _isZh,
          onTap: utilStatus != 'locked'
              ? () => _onWorldTap(context, 'utilitarianism')
              : null,
        ),
      ],
    );
  }

  Widget _buildFourBranchRow(BuildContext context) {
    const topIds = ['life_philosophy', 'phenomenology'];
    const bottomIds = ['existentialism', 'analytic_philosophy'];

    Widget buildRow(List<String> ids) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: ids.map((id) {
          final world = findWorld(id);
          final status = _worldStatus(id);
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: _WorldNode(
                world: world,
                status: status,
                isZh: _isZh,
                onTap: status != 'locked' ? () => _onWorldTap(context, id) : null,
              ),
            ),
          );
        }).toList(),
      );
    }

    return Column(
      children: [
        buildRow(topIds),
        const SizedBox(height: 10),
        buildRow(bottomIds),
      ],
    );
  }
}

// ─── World Node Widget ───

class _WorldNode extends StatelessWidget {
  final WorldConfig world;
  final String status;
  final bool isZh;
  final VoidCallback? onTap;

  const _WorldNode({
    required this.world,
    required this.status,
    required this.isZh,
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
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: _isUnlocked ? AppColors.surfaceLight : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
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
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _isCompleted
                  ? Icons.check_circle
                  : _isUnlocked
                      ? Icons.lock_open_outlined
                      : Icons.lock_outline,
              size: 16,
              color: _isCompleted
                  ? AppColors.success
                  : _isUnlocked
                      ? AppColors.accent
                      : AppColors.textLight,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                isZh ? world.nameZh : world.nameEn,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _isUnlocked ? AppColors.textPrimary : AppColors.textLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Connectors ───

class _VerticalConnector extends StatelessWidget {
  const _VerticalConnector();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 2,
        height: 28,
        color: AppColors.divider,
      ),
    );
  }
}

/// Draws lines from a single top-center point splitting to 4 bottom points.
class _SplitPainter extends CustomPainter {
  final Color color;
  const _SplitPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final centerX = size.width / 2;
    final midY = size.height / 2;

    // Vertical line from top center to mid
    canvas.drawLine(Offset(centerX, 0), Offset(centerX, midY), paint);

    // 4 evenly spaced child positions
    const childCount = 4;
    for (int i = 0; i < childCount; i++) {
      final childX = size.width * (i + 0.5) / childCount;
      // Horizontal line from center to child x at midY
      canvas.drawLine(Offset(centerX, midY), Offset(childX, midY), paint);
      // Vertical line from midY down to bottom
      canvas.drawLine(Offset(childX, midY), Offset(childX, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Draws lines from 4 top points merging to a single bottom-center point.
class _MergePainter extends CustomPainter {
  final Color color;
  const _MergePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final centerX = size.width / 2;
    final midY = size.height / 2;

    // 4 evenly spaced child positions from top
    const childCount = 4;
    for (int i = 0; i < childCount; i++) {
      final childX = size.width * (i + 0.5) / childCount;
      // Vertical line from top to midY
      canvas.drawLine(Offset(childX, 0), Offset(childX, midY), paint);
      // Horizontal line from child x to center at midY
      canvas.drawLine(Offset(childX, midY), Offset(centerX, midY), paint);
    }

    // Vertical line from mid to bottom center
    canvas.drawLine(Offset(centerX, midY), Offset(centerX, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
