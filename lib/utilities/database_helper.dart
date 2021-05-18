import 'dart:io';

import 'package:my_note_book/models/note.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _dbName = "Notes.db";
  static const _dbVersion = 1;
  static Database _database;

  String noteTable = "Note_Table";
  String colId = "id";
  String colTitle = "title";
  String colDate = "date";
  String colBody = "body";

  DatabaseHelper.private();
  static final DatabaseHelper instance = DatabaseHelper.private();
  Note note = Note();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, _dbName);
    return await openDatabase(dbPath, version: _dbVersion, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $noteTable(
    $colId INTEGER PRIMARY KEY AUTOINCREMENT,
    $colTitle TEXT,
    $colBody TEXT,
    )
    ''');
  }

  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database db = await this.database;
    final List<Map<String, dynamic>> result = await db.query(noteTable);
    return result;
  }

  Future<List<Note>> getNoteList() async {
    final List<Map<String, dynamic>> noteMapList = await getTaskMapList();
    final List<Note> noteList = [];
    noteMapList.forEach((noteMap) {
      noteList.add(Note.fromMap(noteMap));
    });
    return noteList;
  }

  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    final int result = await db.insert(noteTable, note.toMap());
    return result;
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await database;
    final List<Map<String, dynamic>> result = await db.query(noteTable);
    return result;
  }

  Future update(Note note) async {
    Database db = await this.database;

    final int result = await db.update(noteTable, note.toMap(),
        where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  Future delete(int id) async {
    Database db = await this.database;
    int result =
        await db.delete(noteTable, where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  Future<List<Note>> fetchNote() async {
    Database db = await database;
    List<Map> notes = await db.query(noteTable);
    return notes.length == 0 ? [] : notes.map((e) => Note.fromMap(e)).toList();
  }
}
