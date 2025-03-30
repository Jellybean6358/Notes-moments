import 'package:flutter/material.dart';
import '../Database/database_helper.dart';
import '../models/journal_entry.dart';

class EditNotePage extends StatefulWidget {
  final Note note1;
  const EditNotePage({super.key, required this.note1});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late DatabaseHelper dbHelper;

    @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    _titleController = TextEditingController(text: widget.note1.title);
    _contentController = TextEditingController(text: widget.note1.content);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
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
                  widget.note1.title = title;
                  widget.note1.content = content;
                  await dbHelper.updateNote(widget.note1);
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
