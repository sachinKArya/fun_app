import 'package:flutter/material.dart';
import 'package:fun_app/core/util/local_db_service.dart';
import 'package:fun_app/features/data/models/home/jokes_model.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class HomePageLocalDataSource {
  Future insertJoke(JokesModel model);
  Future<List<JokesModel>?> getJokes();
  Future deleteJoke(int id);
}

class HomePageLocalDataSourceImpl implements HomePageLocalDataSource {
  final SqliteService sqliteService;

  HomePageLocalDataSourceImpl(this.sqliteService);

  @override
  Future insertJoke(JokesModel model) async {
    try {
      final Database db = await sqliteService.initializeDB();
      final id = await db.insert(
        'jokes',
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      debugPrint("Insert Item ID: $id");
      return id;
    } catch (e) {
      debugPrint("insertJoke: $e");
      return null;
    }
  }

  @override
  Future<List<JokesModel>?> getJokes() async {
    try {
      final db = await sqliteService.initializeDB();
      final List<Map<String, Object?>> queryResult = await db.query('jokes');
      final List<JokesModel> list = queryResult.map((e) => JokesModel.fromJson(e)).toList();
      debugPrint("getJokes: ${list.length}");
      return list;
    } catch (e) {
      debugPrint("getJokes: $e");
      return null;
    }
  }

  @override
  Future deleteJoke(int id) async {
    try {
      final Database db = await sqliteService.initializeDB();
      int count = await db.delete('jokes', where: 'id = ?', whereArgs: [id]);
      debugPrint("Deleted Item id: $id");
      return count;
    } catch (e) {
      debugPrint("deleteJoke: $e");
      return null;
    }
  }
}
