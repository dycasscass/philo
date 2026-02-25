import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../services/storage_service.dart';

class ProfileScreen extends StatelessWidget {
  final AppLocalizations l10n;
  final StorageService storage;
  final VoidCallback onToggleLanguage;

  const ProfileScreen({
    super.key,
    required this.l10n,
    required this.storage,
    required this.onToggleLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.get('profile_title')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Avatar
            CircleAvatar(
              radius: 48,
              backgroundColor: AppColors.accent.withValues(alpha: 0.2),
              child: const Icon(
                Icons.person,
                size: 48,
                color: AppColors.accent,
              ),
            ),
            const SizedBox(height: 32),

            // Stats cards
            Row(
              children: [
                _StatCard(
                  icon: Icons.star,
                  label: l10n.get('xp'),
                  value: '${storage.xp}',
                  color: AppColors.accent,
                ),
                const SizedBox(width: 12),
                _StatCard(
                  icon: Icons.trending_up,
                  label: l10n.get('level'),
                  value: '${storage.level}',
                  color: AppColors.success,
                ),
                const SizedBox(width: 12),
                _StatCard(
                  icon: Icons.local_fire_department,
                  label: l10n.get('streak'),
                  value: '${storage.streak} ${l10n.get('days')}',
                  color: AppColors.error,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Language switch
            Card(
              child: ListTile(
                leading: const Icon(Icons.language, color: AppColors.accent),
                title: Text(l10n.get('switch_language')),
                subtitle: Text(
                  l10n.language == AppLanguage.zh ? '中文 → English' : 'English → 中文',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: onToggleLanguage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
