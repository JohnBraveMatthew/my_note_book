import 'package:flutter/material.dart';
import 'package:my_note_book/models/note.dart';
import 'package:my_note_book/utilities/database_helper.dart';

class Notebook extends StatefulWidget {
  @override
  _NotebookState createState() => _NotebookState();
}

class _NotebookState extends State<Notebook> {
  Note _note = Note();
  final formkey = GlobalKey<FormState>();
  Databasehelper dbHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      dbHelper = Databasehelper.instance;
    });
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
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: TextFormField(
              onSaved: (val) => _note.body = val,
              validator: (val) =>
                  (val.isEmpty ? "cannot save empty note" : null),
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              textInputAction: TextInputAction.newline,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ),
    );
  }

  _save() async {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      await dbHelper.insertNote(_note);
    }
  }
}
