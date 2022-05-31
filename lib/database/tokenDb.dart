import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:transisi/model/tokenModel.dart';

class TokenDb {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "token.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE TokenDB("
        "token VARCHAR,"
        ")");
  }

  Future saveTokenDb(TokenModel tokenData) async {
    final Database dbClient = await db;
    await dbClient.insert(
      'TokenDB',
      tokenData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TokenModel>> getDataLogin() async {
    final Database dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query('TokenDB');
    return List.generate(maps.length, (i) {
      return TokenModel(token: maps[i]['token']);
    });
  }
}
