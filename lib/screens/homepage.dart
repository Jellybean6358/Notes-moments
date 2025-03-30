import 'package:flutter/material.dart';
import '../Database/database_helper.dart';
import '../models/journal_entry.dart';
import 'addpage.dart';
import 'editpage.dart';
import 'favpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late DatabaseHelper dbHelper;
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    _loadNotes();
  }

  void _loadNotes() async {
    notes = await dbHelper.getNotes();
    setState(() {});
  }

  void _open_favoritesPage(Note note) async{
    await dbHelper.makeFavorite(note.id!,!note.isFavorite);
    _loadNotes();
  }

  void _deleteNote(int id,bool isFavorite) async {
    if(isFavorite){
      await dbHelper.makeFavorite(id,false);
    }
    await dbHelper.deleteNote(id);
    _loadNotes();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: (){
              Navigator.pushNamed(context,'/fav');
            },
          ),
          IconButton(
            icon: const Icon(Icons.grid_view),
            onPressed:(){
              setState((){
                //_isGLay=!_isGLay;
              });
            },
            //icon: Icon(_isGLay?Icons.grid_view:Icons.list),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return Dismissible(
            key: Key(note.id.toString()),
            direction: DismissDirection.horizontal,
            background: Container(
              color:Colors.red,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Icon(Icons.delete),
            ),
            secondaryBackground: Container(
              color:Colors.blue,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Icon(Icons.favorite),
            ),
            onDismissed: (direction) {
              if(direction==DismissDirection.startToEnd) {
                _deleteNote(note.id!,note.isFavorite);
                setState(() {
                  notes.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Note deleted'),backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: ListTile(
            title: Text(note.title), // Display the title
            subtitle: Text(note.content), // Display content
            onTap: () async {
                final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditNotePage(note1: note),
                ),
              );
              if (result != null && result == true) {
                    _loadNotes();
              }
            },
              trailing:IconButton(
                icon:Icon(
                    note.isFavorite?Icons.favorite:Icons.favorite_border,
                    color:note.isFavorite?Colors.blue:Colors.grey,
              ),
              onPressed:(){
                _open_favoritesPage(note);
              },
              ),
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding:EdgeInsets.only(left:30),
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
      FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNotePage()),
          );
          if (result != null && result == true) {
            _loadNotes();
          }
        },
        child: const Icon(Icons.add),
      ),
          Expanded(child: Container()),
          FloatingActionButton(
            onPressed: (){},
            child: Icon(Icons.camera),
          )
    ],
      )
    )
    );
  }
}
