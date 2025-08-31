import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

import '../Model/translation.dart';

class DatabaseHelper {
  static Database? _database;
  final String translation = 'Translation';
  final String conversation = 'Conversation';
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // Create your tables here
        await db.execute('''
          CREATE TABLE IF NOT EXISTS $translation (
            id INTEGER PRIMARY KEY,
        textImage TEXT,
        answerImage TEXT,
        text TEXT,
        answer TEXT
             )    
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS $conversation (
        id INTEGER PRIMARY KEY,
        textImage TEXT,
        answerImage TEXT,
        text TEXT,
        answer TEXT
             )    
        ''');
      },
    );
  }

  Future<int> insertTranslation(TranslationModel data) async {
    final db = await database;
    return await db.insert(translation, data.toMap());
  }

  Future<int> insertConversation(TranslationModel data) async {
    final db = await database;
    return await db.insert(conversation, data.toMap());
  }


  Future<List<TranslationModel>> getTranslation() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(translation);

    return List.generate(maps.length, (i) {
      return TranslationModel.fromMap(maps[i]);
    });
  }

  Future<List<TranslationModel>> getConversation() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(conversation);

    return List.generate(maps.length, (i) {
      return TranslationModel.fromMap(maps[i]);
    });
  }

  Future<void> updateTranslation(TranslationModel data) async {
    final db = await database;
    await db.update(translation, data.toMap(),
        where: 'id = ?', whereArgs: [data.id]);
  }

  Future<void> deleteTranslation(int id) async {
    final db = await database;
    await db.delete(translation, where: 'id = ?', whereArgs: [id]);
    // return result.isNotEmpty ? result.first : null;
  }
  Future<void> deleteConversation(int id) async {
    final db = await database;
    await db.delete(conversation, where: 'id = ?', whereArgs: [id]);
    // return result.isNotEmpty ? result.first : null;
  }
  Future<void> deleteAll() async
  {
    final db = await database;
    await db.delete(translation);
    await db.delete(conversation);
  }
}
