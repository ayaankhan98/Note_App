import 'package:Note_App/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
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
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + databaseName;

    var notesDatabase =
        openDatabase(path, version: databaseVersion, onCreate: _createDb);

    return notesDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        ("CREATE TABLE $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT, "
            "$colTitle TEXT, $colContent TEXT, $colDate TEXT)"));
  }

  Future<List<Map<String, dynamic>>> getNotesListMap() async {
    Database db = await this.database;
    var response = db.query(tableName);
    return response;
  }

  Future<int> insert(Note note) async {
    Database db = await this.database;
    print(note.objToMap());
    int response = await db.insert(tableName, note.objToMap());
    return response;
  }

  Future<int> update(Note note) async {
    Database db = await this.database;
    int response = await db.update(tableName, note.objToMap(),
        where: '$colId = ?', whereArgs: [note.id]);
    return response;
  }

  Future<int> delete(int noteId) async {
    Database db = await this.database;
    int response = await db.rawDelete('DELETE FROM $tableName WHERE $colId == $noteId');
    return response;
  }

  Future<List<Note>> getNoteList() async {
    var noteMapList = await getNotesListMap();
    int count = noteMapList.length;

    List<Note> noteList = List<Note>();
    for(int i = 0 ; i < count ; i++) {
      noteList.add(Note.mapToObj(noteMapList[i]));
    }
    return noteList;
  }

  Future<Note> getNoteById(int noteId) async {
    Database db = await this.database;
    List<Map<String, dynamic>> noteMap = await db.query(tableName, where: '$colId = ?', whereArgs: [noteId]);
    Note note = Note.mapToObj(noteMap[0]);
    return note;
  }
}
