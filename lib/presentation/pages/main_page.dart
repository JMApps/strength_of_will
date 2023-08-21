import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:of_will/application/state/main_app_state.dart';
import 'package:of_will/application/strings/app_strings.dart';
import 'package:of_will/presentation/pages/settings_page.dart';
import 'package:of_will/presentation/pages/strength_chapters.dart';
import 'package:of_will/presentation/pages/strength_favorites.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _listWidgets = [
    const StrengthChapters(),
    const StrengthFavorites(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final MainAppState mainAppState = Provider.of<MainAppState>(context);
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        switchInCurve: Curves.easeInToLinear,
        switchOutCurve: Curves.easeInToLinear,
        child: _listWidgets[mainAppState.getSelectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        useLegacyColorScheme: false,
        items: const [
          BottomNavigationBarItem(
            label: AppStrings.heads,
            icon: Icon(CupertinoIcons.collections),
          ),
          BottomNavigationBarItem(
            label: AppStrings.bookmarks,
            icon: Icon(CupertinoIcons.bookmark),
          ),
          BottomNavigationBarItem(
            label: AppStrings.settings,
            icon: Icon(CupertinoIcons.settings),
          ),
        ],
        currentIndex: mainAppState.getSelectedIndex,
        onTap: mainAppState.changeSelectedIndex,
      ),
    );
  }
}
