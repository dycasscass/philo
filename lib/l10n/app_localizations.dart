import 'package:flutter/material.dart';

enum AppLanguage { zh, en }

class AppLocalizations extends ChangeNotifier {
  AppLanguage _language = AppLanguage.zh;

  AppLanguage get language => _language;

  void setLanguage(AppLanguage lang) {
    _language = lang;
    notifyListeners();
  }

  void toggleLanguage() {
    _language = _language == AppLanguage.zh ? AppLanguage.en : AppLanguage.zh;
    notifyListeners();
  }

  String get(String key) {
    final map = _language == AppLanguage.zh ? _zh : _en;
    return map[key] ?? key;
  }

  static final Map<String, String> _zh = {
    'app_name': 'PhiloQuest',
    'tab_course_map': '课程',
    'tab_philosophers': '图鉴',
    'tab_notebook': '笔记本',
    'tab_profile': '我的',
    'course_map_title': '课程地图',
    'philosophers_title': '哲学家图鉴',
    'notebook_title': '哲学笔记本',
    'profile_title': '我的',
    'level': '等级',
    'xp': '经验值',
    'streak': '连续学习',
    'days': '天',
    'language': '语言',
    'switch_language': '切换语言',
    'no_content_yet': '内容开发中…',
  };

  static final Map<String, String> _en = {
    'app_name': 'PhiloQuest',
    'tab_course_map': 'Learn',
    'tab_philosophers': 'Gallery',
    'tab_notebook': 'Notes',
    'tab_profile': 'Profile',
    'course_map_title': 'Course Map',
    'philosophers_title': 'Philosopher Gallery',
    'notebook_title': 'Philosophy Notebook',
    'profile_title': 'Profile',
    'level': 'Level',
    'xp': 'XP',
    'streak': 'Streak',
    'days': 'days',
    'language': 'Language',
    'switch_language': 'Switch Language',
    'no_content_yet': 'Coming soon...',
  };
}
