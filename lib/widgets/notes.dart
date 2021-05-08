import 'package:flutter/material.dart';
import 'package:my_note_book/models/note.dart';
import 'package:my_note_book/screens/home.dart';
import 'package:my_note_book/utilities/database_helper.dart';

class Notes extends StatefulWidget {
  List<Note> notes;
  final formkey;
  var _note;
  Notes(this.notes, this.formkey, this._note);
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {

  Databasehelper dbHelper;
  List<Note> notes = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      dbHelper = Databasehelper.instance;
    });
    refreshNoteList();
  }

  @override
  Widget build(BuildContext context) {
      return Expanded(
          child: Card(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.note,
                        color: Colors.black,
                      ),
                      title: Text(notes[index].title.toUpperCase()),
                      trailing: Icon(Icons.delete_forever),
                    ),
                    Divider(
                      height: 5,
                    ),
                  ],
                );
              },
              itemCount: notes.length,
            ),
          ));
    }


refreshNoteList() async {
  List<Note> x = await dbHelper.fetchNote();
  setState(() {
    notes = x;
    Note(notes: x);
  });
}

  _save() async {
    if (widget.formkey.currentState.validate()) {
      widget.formkey.currentState.save();
      await dbHelper.insertNote(widget._note);
    }
    refreshNoteList();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Notebook()));
  }


}
