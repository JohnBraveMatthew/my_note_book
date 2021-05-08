import 'dart:io';

import 'package:my_note_book/models/note.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Databasehelper {
  static const _dbName = "Notes.db";
  static const _dbVersion = 1;

  Databasehelper.private();
  static final Databasehelper instance = Databasehelper.private();
  Note note = Note();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, _dbName);
    return await openDatabase(dbPath, version: _dbVersion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE ${Note.tblName}(
    ${Note.noteId} INTEGER PRIMARY KEY,
    ${Note.noteTitle} TEXT NOT NULL,
    ${Note.noteBody} TEXT NOT NULL
    )
    ''');
  }

  Future<int> insertNote(Note note) async {
    Database db = await database;
    return await db.insert(Note.tblName, note.toMap());
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await database;
    return await db.query(Note.tblName);
  }

  Future update(Note note) async {
    Database db = await database;

    return await db.update(Note.tblName, note.toMap(),
        where: '${Note.noteId} = ?', whereArgs: [note.id]);
  }

  Future delete(int id) async {
    Database db = await database;
    return await db.delete(Note.tblName,
        where: '${Note.noteId} = ?', whereArgs: [note.id]);
  }

  Future<List<Note>> fetchNote() async {
    Database db = await database;
    List<Map> notes = await db.query(Note.tblName);
    return notes.length == 0 ? [] : notes.map((e) => Note.fromMap(e)).toList();
  }
}
