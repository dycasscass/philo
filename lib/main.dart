import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'services/storage_service.dart';
import 'screens/course_map_screen.dart';
import 'screens/philosopher_collection_screen.dart';
import 'screens/notebook_screen.dart';
import 'screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await StorageService.getInstance();
  runApp(PhiloQuestApp(storage: storage));
}

class PhiloQuestApp extends StatefulWidget {
  final StorageService storage;

  const PhiloQuestApp({super.key, required this.storage});

  @override
  State<PhiloQuestApp> createState() => _PhiloQuestAppState();
}

class _PhiloQuestAppState extends State<PhiloQuestApp> {
  final AppLocalizations _l10n = AppLocalizations();

  @override
  void initState() {
    super.initState();
    final savedLang = widget.storage.language;
    if (savedLang == 'en') {
      _l10n.setLanguage(AppLanguage.en);
    }
    _l10n.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _l10n.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhiloQuest',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: MainScreen(
        l10n: _l10n,
        storage: widget.storage,
        onToggleLanguage: () {
          _l10n.toggleLanguage();
          widget.storage.setLanguage(
            _l10n.language == AppLanguage.zh ? 'zh' : 'en',
          );
        },
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final AppLocalizations l10n;
  final StorageService storage;
  final VoidCallback onToggleLanguage;

  const MainScreen({
    super.key,
    required this.l10n,
    required this.storage,
    required this.onToggleLanguage,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      CourseMapScreen(l10n: widget.l10n, storage: widget.storage),
      PhilosopherCollectionScreen(l10n: widget.l10n),
      NotebookScreen(l10n: widget.l10n),
      ProfileScreen(
        l10n: widget.l10n,
        storage: widget.storage,
        onToggleLanguage: widget.onToggleLanguage,
      ),
    ];

    return Scaffold(
      backgroundColor: _currentIndex == 0 ? Colors.black : null,
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.map_outlined),
            activeIcon: const Icon(Icons.map),
            label: widget.l10n.get('tab_course_map'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.people_outline),
            activeIcon: const Icon(Icons.people),
            label: widget.l10n.get('tab_philosophers'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu_book_outlined),
            activeIcon: const Icon(Icons.menu_book),
            label: widget.l10n.get('tab_notebook'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: widget.l10n.get('tab_profile'),
          ),
        ],
      ),
    );
  }
}
