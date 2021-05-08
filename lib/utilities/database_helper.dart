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

  Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.toString(), _dbName);
    return await openDatabase(dbPath,
        version: _dbVersion, onCreate: _onCreateDb);
  }

  _onCreateDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE ${Note.tblName}(
    ${Note.noteId} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${Note.noteTitle} TEXT NOT NULL,
    ${Note.noteBody} TEXT NOT NULL
    )
    ''');
  }

  Future<int> insertNote(Note note) async {
    Database db = await database;
    return await db.insert(Note.tblName, note.toMap());
  }

  Future<List<Note>> fetchNote() async {
    Database db = await database;
    List<Map> notes = await db.query(Note.tblName);
    return notes.length == 0 ? [] : notes.map((e) => Note.fromMap(e)).toList();
  }
}
