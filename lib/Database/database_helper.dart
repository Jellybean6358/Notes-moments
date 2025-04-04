import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/journal_entry.dart';

class DatabaseHelper {
  Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    String path = await getDatabasesPath();
    path = join(path, 'notes.db');
    return openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        content TEXT,
        date TEXT,
        isFavorite INTEGER DEFAULT 0  -- 0 for false, 1 for true
      )
    ''');
  }

  Future<List<Note>> getNotes() async {
    final db = await this.db;
    final List<Map<String, dynamic>> maps = await db.query('notes');
    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }

  Future<int> insertNote(Note note) async {
    final db = await this.db;
    return await db.insert('notes', note.toMap());
  }

  Future<int> updateNote(Note note) async {
    final db = await this.db;
    return await db.update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  Future<int> deleteNote(int id) async {
    final db = await this.db;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Note>> getFavoriteNotes() async {
    final db = await this.db;
    final List<Map<String, dynamic>> maps = await db.query('notes', where: 'isFavorite = 1');
    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }

  Future<int> makeFavorite(int noteId, bool isFavorite) async {
    final db = await this.db;
    int favoriteValue = isFavorite ? 1 : 0;
    return await db.update('notes', {'isFavorite': favoriteValue}, where: 'id = ?', whereArgs: [noteId]);
  }
}