 // import 'package:flutter/material.dart';
 // import 'package:provider/provider.dart';
 // import '../providers/journal_provider.dart';
 // //import '../widgets/journal_entry_grid_tile.dart';
 // import '../models/journal_entry.dart';
 //
 // class TrashScreen extends StatelessWidget {
 //   const TrashScreen({super.key});
 //
 //   @override
 //   Widget build(BuildContext context) {
 //     final journalProvider = Provider.of<JournalProvider>(context);
 //     final deletedEntries =
 //     journalProvider.entries.where((entry) => entry.isDeleted).toList();
 //
 //     return Scaffold(
 //       appBar: AppBar(
 //         title: const Text('Trash'),
 //       ),
 //       body: GridView.builder(
 //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
 //           crossAxisCount: 2,
 //           mainAxisSpacing: 10,
 //           crossAxisSpacing: 10,
 //         ),
 //         itemCount: deletedEntries.length,
 //         itemBuilder: (context, index) {
 //           final entry = deletedEntries[index];
 //           return JournalEntryGridTile(entry: entry);
 //         },
 //       ),
 //     );
 //   }
 // }