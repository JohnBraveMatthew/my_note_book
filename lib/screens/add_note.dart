import 'package:flutter/material.dart';
import 'package:my_note_book/models/note.dart';
import 'package:my_note_book/screens/home.dart';
import 'package:my_note_book/utilities/database_helper.dart';

class AddNote extends StatefulWidget {
  var test = 232;
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  Note _note = Note();
  final formkey = GlobalKey<FormState>();
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Note"),
        actions: [
          TextButton.icon(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: _save,
            label: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) => (val.isEmpty
                          ? "provide a name for your document"
                          : null),
                      decoration: InputDecoration(hintText: "Document title"),
                      onSaved: (val) => _note.title = val,
                    ),
                    TextFormField(
                      onSaved: (val) => _note.body = val,
                      validator: (val) => null,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 20),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.newline,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // noteList()
          ],
        ),
      ),
    );
  }

  Widget noteList() {
    return Container(
        width: double.infinity,
        //height: MediaQuery.of(context).size.height * 0.5,
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
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      await dbHelper.insertNote(_note);
    }
    refreshNoteList();

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Notebook()));
  }
}
