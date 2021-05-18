import 'package:flutter/material.dart';
import 'package:my_note_book/models/note.dart';
import 'package:my_note_book/screens/add_note.dart';
import 'package:my_note_book/utilities/database_helper.dart';

class Notebook extends StatefulWidget {
  @override
  _NotebookState createState() => _NotebookState();
}

class _NotebookState extends State<Notebook> {
  Future<List<Note>> _noteList;
  //final DateFormat _dateFormat = DateFormat('mmm dd, yyyy');
  //AddNote addNote = AddNote();
  DatabaseHelper _DBhelper;

  final formkey = GlobalKey<FormState>();

  refreshNoteList() {
    setState(() {
      _noteList = _DBhelper.fetchNote();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _DBhelper = DatabaseHelper.instance;
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
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                onPressed: () {
                  _DBhelper.delete(note.id);
                  refreshNoteList();
                },
              ),
              onTap: () {
                //Navigator.of(context, rootNavigator: )
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => AddNote(note: note)));
              }),
          Divider(
            height: 10,
          )
        ],
      ),
    );
  }
}
