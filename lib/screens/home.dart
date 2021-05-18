import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_note_book/models/note.dart';
import 'package:my_note_book/screens/add_note.dart';
import 'package:my_note_book/utilities/database_helper.dart';

class Notebook extends StatefulWidget {
  @override
  _NotebookState createState() => _NotebookState();
}

class _NotebookState extends State<Notebook> {
  Future<List<Note>> _noteList;
  DatabaseHelper dbHelper;
  final DateFormat _dateFormat = DateFormat('mmm dd, yyyy');
  AddNote addNote = AddNote();

  final formkey = GlobalKey<FormState>();

  //DatabaseHelper dbHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshNoteList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Notes"),
      ),
      body: FutureBuilder(
          future: _noteList,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, index) {
                return _buildNotes(snapshot.data[index]);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
            (context), MaterialPageRoute(builder: (_) => AddNote())),
      ),
    );
  }

  Widget _buildNotes(Note note) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          ListTile(
              title: Text(note.title),
              subtitle: Text("${note.body}"),
              trailing: Icon(Icons.delete),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AddNote(
                              note: note,
                              updateNoteList: refreshNoteList,
                            )));
              }),
          Divider(
            height: 10,
          )
        ],
      ),
    );
  }

  refreshNoteList() {
    setState(() {
      _noteList = DatabaseHelper.instance.getNoteList();
    });
  }
}
