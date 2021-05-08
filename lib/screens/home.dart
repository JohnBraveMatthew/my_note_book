import 'package:flutter/material.dart';
import 'package:my_note_book/models/note.dart';
import 'package:my_note_book/screens/add_note.dart';
import 'package:my_note_book/utilities/database_helper.dart';

class Notebook extends StatefulWidget {
  @override
  _NotebookState createState() => _NotebookState();
}

class _NotebookState extends State<Notebook> {
  Note _note = Note();
  AddNote addNote = AddNote();

  final formkey = GlobalKey<FormState>();

  Databasehelper dbHelper;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   refreshContactList();
  // }
  Map noteList = {};

  @override
  Widget build(BuildContext context) {
    // noteList = ModalRoute.of(context).settings.arguments;
    //
    // print(noteList);

    return Scaffold(
      appBar: AppBar(
        title: Text("My Notes"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: addNote.createState().noteList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed((context), "/addNote"),
      ),
    );
  }
}
