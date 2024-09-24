import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/note_model.dart';

class NoteRepository {
  static final NoteRepository instance = NoteRepository._init();
  static Database? _database;

  NoteRepository._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT
          )
        ''');
      },
    );
  }

  Future<List<NoteModel>> getAllNotes() async {
    final database = await instance.database;
    final List<Map<String, dynamic>> notes = await database.query('notes');

    return notes.map((note) {
      return NoteModel(
        id: note['id'],
        title: note['title'],
        content: note['content'],
      );
    }).toList();
  }

  Future<int> addNote(NoteModel note) async {
    final database = await instance.database;
    final id = await database.insert('notes', note.toMap());

    return id;
  }

  Future<void> updateNote(NoteModel note) async {
    final database = await instance.database;
    await database
        .update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  Future<void> deleteNote(int id) async {
    final database = await instance.database;
    await database.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
