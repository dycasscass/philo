/// A philosophy "world" (世界) — a major era or school of thought.
class WorldConfig {
  final String worldId;
  final String nameZh;
  final String nameEn;

  const WorldConfig({
    required this.worldId,
    required this.nameZh,
    required this.nameEn,
  });
}

/// All worlds in the journey, ordered for display.
const allWorlds = <WorldConfig>[
  WorldConfig(worldId: 'ancient_greece', nameZh: '古希腊哲学', nameEn: 'Ancient Greek Philosophy'),
  WorldConfig(worldId: 'medieval', nameZh: '中世纪哲学', nameEn: 'Medieval Philosophy'),
  WorldConfig(worldId: 'rationalism', nameZh: '理性主义', nameEn: 'Rationalism'),
  WorldConfig(worldId: 'empiricism', nameZh: '经验主义', nameEn: 'Empiricism'),
  WorldConfig(worldId: 'utilitarianism', nameZh: '功利主义', nameEn: 'Utilitarianism'),
  WorldConfig(worldId: 'german_idealism', nameZh: '德国唯心主义', nameEn: 'German Idealism'),
  WorldConfig(worldId: 'life_philosophy', nameZh: '生命哲学', nameEn: 'Philosophy of Life'),
  WorldConfig(worldId: 'phenomenology', nameZh: '现象学', nameEn: 'Phenomenology'),
  WorldConfig(worldId: 'existentialism', nameZh: '存在主义', nameEn: 'Existentialism'),
  WorldConfig(worldId: 'analytic_philosophy', nameZh: '分析哲学', nameEn: 'Analytic Philosophy'),
  WorldConfig(worldId: 'contemporary', nameZh: '当代哲学', nameEn: 'Contemporary Philosophy'),
];

/// Directed edges defining the world graph topology.
///
/// ```
/// 古希腊 → 中世纪 → 理性主义 → 经验主义 → 德国唯心主义
///                                  ↘ 功利主义
///                    德国唯心主义 → 生命哲学 / 现象学 / 存在主义 / 分析哲学
///                                          ↘ 当代哲学 ↙
/// ```
const worldEdges = <String, List<String>>{
  'ancient_greece': ['medieval'],
  'medieval': ['rationalism'],
  'rationalism': ['empiricism'],
  'empiricism': ['utilitarianism', 'german_idealism'],
  'german_idealism': ['life_philosophy', 'phenomenology', 'existentialism', 'analytic_philosophy'],
  'life_philosophy': ['contemporary'],
  'phenomenology': ['contemporary'],
  'existentialism': ['contemporary'],
  'analytic_philosophy': ['contemporary'],
};

/// Find a world by its ID.
WorldConfig findWorld(String worldId) =>
    allWorlds.firstWhere((w) => w.worldId == worldId);

/// Get all parent world IDs (worlds that have an edge pointing to this one).
List<String> getParentWorldIds(String worldId) => worldEdges.entries
    .where((e) => e.value.contains(worldId))
    .map((e) => e.key)
    .toList();
