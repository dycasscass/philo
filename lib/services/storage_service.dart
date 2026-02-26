import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static StorageService? _instance;
  late SharedPreferences _prefs;

  StorageService._();

  static Future<StorageService> getInstance() async {
    if (_instance == null) {
      _instance = StorageService._();
      _instance!._prefs = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  // XP
  int get xp => _prefs.getInt('xp') ?? 0;
  Future<void> setXp(int value) => _prefs.setInt('xp', value);
  Future<void> addXp(int amount) => setXp(xp + amount);

  // Level
  int get level => _prefs.getInt('level') ?? 1;
  Future<void> setLevel(int value) => _prefs.setInt('level', value);

  // Streak
  int get streak => _prefs.getInt('streak') ?? 0;
  Future<void> setStreak(int value) => _prefs.setInt('streak', value);

  String? get lastStudyDate => _prefs.getString('last_study_date');
  Future<void> setLastStudyDate(String date) =>
      _prefs.setString('last_study_date', date);

  // Completed lessons
  List<String> get completedLessons =>
      _prefs.getStringList('completed_lessons') ?? [];
  Future<void> completeLesson(String lessonId) {
    final lessons = completedLessons;
    if (!lessons.contains(lessonId)) {
      lessons.add(lessonId);
    }
    return _prefs.setStringList('completed_lessons', lessons);
  }

  bool isLessonCompleted(String lessonId) =>
      completedLessons.contains(lessonId);

  // Unlocked philosophers
  List<String> get unlockedPhilosophers =>
      _prefs.getStringList('unlocked_philosophers') ?? [];
  Future<void> unlockPhilosopher(String philosopherId) {
    final philosophers = unlockedPhilosophers;
    if (!philosophers.contains(philosopherId)) {
      philosophers.add(philosopherId);
    }
    return _prefs.setStringList('unlocked_philosophers', philosophers);
  }

  // Completed worlds
  List<String> get completedWorlds =>
      _prefs.getStringList('completed_worlds') ?? [];

  Future<void> completeWorld(String worldId) {
    final worlds = completedWorlds;
    if (!worlds.contains(worldId)) {
      worlds.add(worldId);
    }
    return _prefs.setStringList('completed_worlds', worlds);
  }

  bool isWorldCompleted(String worldId) =>
      completedWorlds.contains(worldId);

  // Language preference
  String get language => _prefs.getString('language') ?? 'zh';
  Future<void> setLanguage(String lang) => _prefs.setString('language', lang);
}
