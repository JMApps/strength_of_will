import 'package:of_will/data/database_helper.dart';
import 'package:of_will/data/model/footnote_model.dart';
import 'package:of_will/data/model/strength_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseQuery {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<StrengthModel>> getAllParagraphs() async {
    final Database dbClient = await _databaseHelper.db;
    var res = await dbClient.query('Table_of_chapters');
    List<StrengthModel>? allParagraphs = res.isNotEmpty ? res.map((c) => StrengthModel.fromMap(c)).toList() : null;
    return allParagraphs!;
  }

  Future<List<StrengthModel>> getFavoriteParagraphs({required List<int> favorites}) async {
    final Database dbClient = await _databaseHelper.db;
    var res = await dbClient.query('Table_of_chapters', where: 'id IN (${favorites.map((id) => '?').join(', ')})', whereArgs: favorites);
    List<StrengthModel>? favoriteParagraphs = res.isNotEmpty ? res.map((c) => StrengthModel.fromMap(c)).toList() : null;
    return favoriteParagraphs!;
  }

  Future<List<StrengthModel>> getChapterContent(int paragraphId) async {
    final Database dbClient = await _databaseHelper.db;
    var res = await dbClient.query('Table_of_chapters', where: 'id == $paragraphId');
    List<StrengthModel>? chapterContent = res.isNotEmpty ? res.map((c) => StrengthModel.fromMap(c)).toList() : null;
    return chapterContent!;
  }

  Future<List<FootnoteModel>> getFootnote(int paragraphId) async {
    final Database dbClient = await _databaseHelper.db;
    var res = await dbClient.query('Table_of_footnotes', where: 'id == $paragraphId');
    List<FootnoteModel>? footnote = res.isNotEmpty ? res.map((c) => FootnoteModel.fromMap(c)).toList() : null;
    return footnote!;
  }
}
