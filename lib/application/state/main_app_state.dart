import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:of_will/application/strings/app_constraints.dart';
import 'package:of_will/data/database_query.dart';

class MainAppState extends ChangeNotifier {
  final _contentSettingsBox = Hive.box(AppConstraints.keyAppSettingsBox);

  final _favoritesBox = Hive.box(AppConstraints.keyContentFavorites);

  final DatabaseQuery _databaseQuery = DatabaseQuery();

  DatabaseQuery get getDatabaseQuery => _databaseQuery;

  int _paragraphId = 1;

  int get getParagraphId => _paragraphId;

  int _lastParagraph = 0;

  int get getLastParagraph => _lastParagraph;

  List<int> _favoriteParagraphs = [];

  List<int> get getFavoriteParagraphs => _favoriteParagraphs;

  MainAppState() {
    _lastParagraph = _contentSettingsBox.get(AppConstraints.keyLastHead, defaultValue: 0);
    _favoriteParagraphs = _favoritesBox.get(AppConstraints.keyContentFavorites, defaultValue: <int>[]);
  }

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

  toggleFavorite(int id) {
    final exist = _favoriteParagraphs.contains(id);
    if (exist) {
      _favoriteParagraphs.remove(id);
    } else {
      _favoriteParagraphs.add(id);
    }
    _favoritesBox.put(AppConstraints.keyContentFavorites, _favoriteParagraphs);
    notifyListeners();
  }

  bool supplicationIsFavorite(int id) {
    final exist = _favoriteParagraphs.contains(id);
    return exist;
  }
}
