import 'package:flutter/material.dart';
import '../Database/database_helper.dart';
import '../models/journal_entry.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  late DatabaseHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
            ElevatedButton(
              onPressed: () async {
                final title = _titleController.text;
                final content = _contentController.text;
                if (title.isNotEmpty && content.isNotEmpty) {
                  await dbHelper.insertNote(Note(title: title, content: content, date: DateTime.now()));
                  Navigator.pop(context, true); // Return true to indicate success
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}