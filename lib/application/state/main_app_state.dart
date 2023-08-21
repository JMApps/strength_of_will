import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:of_will/application/strings/app_constraints.dart';
import 'package:of_will/data/database_query.dart';

class MainAppState extends ChangeNotifier {
  final _contentSettingsBox = Hive.box(AppConstraints.keyAppSettingsBox);

  final DatabaseQuery _databaseQuery = DatabaseQuery();

  DatabaseQuery get getDatabaseQuery => _databaseQuery;

  int _paragraphId = 1;

  int get getParagraphId => _paragraphId;

  int _lastParagraph = 0;

  int get getLastParagraph => _lastParagraph;

  set saveLastParagraph(int paragraphId) {
    _lastParagraph = paragraphId;
    _contentSettingsBox.put(AppConstraints.keyLastHead, paragraphId);
    notifyListeners();
  }

  set changeParagraphId(int lessonId) {
    _paragraphId = lessonId;
    notifyListeners();
  }

  int _selectedIndex = 0;

  int get getSelectedIndex => _selectedIndex;

  changeSelectedIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

  Future<void> addRemoveBookmark(int favoriteState, int lessonId) async {
    _databaseQuery.addRemoveFavorite(favoriteState, lessonId);
    notifyListeners();
  }

  MainAppState() {
    _paragraphId = _contentSettingsBox.get(AppConstraints.keyLastHead, defaultValue: 0);
  }
}
