import 'package:flutter/material.dart';
import '../Database/database_helper.dart';
import '../models/journal_entry.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late DatabaseHelper dbHelper;
  List<Note> favoriteNotes = [];

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    _loadFavoriteNotes();
  }

  void _loadFavoriteNotes() async {
    favoriteNotes = await dbHelper.getFavoriteNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favoriteNotes.length,
        itemBuilder: (context, index) {
          final note = favoriteNotes[index];
          return ListTile(
            title: Text(note.title),
            subtitle: Text(note.content),
          );
        },
      ),
    );
  }
}