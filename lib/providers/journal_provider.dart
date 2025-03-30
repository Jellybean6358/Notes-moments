// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import '../models/journal_entry.dart';
//
// class JournalProvider extends ChangeNotifier {
//
//   late Database _database;
//   List<Note> _entries = [];
//
//   List<Note> get entries => _entries;
//
//   JournalProvider() {
//     _initializeDatabase();
//   }
//
//   Future<void> _initializeDatabase() async {
//     final databasesPath = await getDatabasesPath();
//     final path = join(databasesPath, 'journal_db.db');
//     _database = await openDatabase(
//       path,
//       version: 2,
//       onCreate: (db, version) {
//         return db.execute(
//           'CREATE TABLE entries(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, date TEXT, time TEXT, imagePath TEXT, isFavorite INTEGER, isDeleted INTEGER)',
//         );
//       },
//       onUpgrade: (db,oldVersion,newVersion){
//         if(oldVersion<2){
//           return db.execute('ALTER TABLE entries ADD COLUMN imagePath TEXT');
//         }
//       }
//     );
//     _loadEntries();
//   }
//
//   Future<void> _loadEntries() async {
//     final List<Map<String, dynamic>> maps = await _database.query('entries');
//     _entries = List.generate(maps.length, (i) {
//       return Note.fromMap(maps[i]);
//     });
//     notifyListeners();
//   }
//
//   Future<void> addEntry(Note entry) async {
//     final int id = await _database.insert('entries', entry.toMap());
//     entry.id = id; // Update the entry with the generated ID
//     _entries.add(entry);
//     notifyListeners();
//   }
//
//   Future<void> updateEntry(Note entry) async {
//     await _database.update('entries', entry.toMap(), where: 'id = ?', whereArgs: [entry.id]);
//     _loadEntries(); // Reload entries to reflect the update
//   }
//
//
//   void deleteEntry(Note entry) async {
//     await _database.delete('entries', where: 'id = ?', whereArgs: [entry.id]);
//     _entries.remove(entry);
//     notifyListeners();
//   }
//
// // ... other methods for favorites, trash, etc.
// }