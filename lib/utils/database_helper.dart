import 'dart:async';
import 'dart:io';
import 'package:Note_App/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  final databaseName = "notes.db";
  final databaseVersion = 1;

  String tableName = "notes_table";
  String colId = "id";
  String colTitle = "title";
  String colContent = "content";
  String colDate = "date";

  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    return _databaseHelper ??= DatabaseHelper._createInstance();
  }

  Future<Database> get database async {
    return _database ??= await initializeDatabase();
  }

  Future<Database> initializeDatabase() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path + databaseName;

    final notesDatabase =
        openDatabase(path, version: databaseVersion, onCreate: _createDb);

    return notesDatabase;
  }

  Future _createDb(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$colTitle TEXT, $colContent TEXT, $colDate TEXT)");
  }

  Future<List<Map<String, dynamic>>> getNotesListMap() async {
    final Database db = await database;
    final response = db.query(tableName);
    return response;
  }

  Future<int> insert(Note note) async {
    final Database db = await database;
    print(note.objToMap());
    final int response = await db.insert(tableName, note.objToMap());
    return response;
  }

  Future<int> update(Note note) async {
    final Database db = await database;
    final int response = await db.update(tableName, note.objToMap(),
        where: '$colId = ?', whereArgs: [note.id]);
    return response;
  }

  Future<int> delete(int noteId) async {
    final Database db = await database;
    final int response =
        await db.rawDelete('DELETE FROM $tableName WHERE $colId == $noteId');
    return response;
  }

  Future<List<Note>> getNoteList() async {
    final noteMapList = await getNotesListMap();
    final int count = noteMapList.length;

    final List<Note> noteList = <Note>[];
    for (int i = 0; i < count; i++) {
      noteList.add(Note.mapToObj(noteMapList[i]));
    }
    return noteList;
  }

  Future<Note> getNoteById(int noteId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> noteMap =
        await db.query(tableName, where: '$colId = ?', whereArgs: [noteId]);
    final Note note = Note.mapToObj(noteMap[0]);
    return note;
  }
}
