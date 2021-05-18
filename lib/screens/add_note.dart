import 'package:flutter/material.dart';
import 'package:my_note_book/models/note.dart';
import 'package:my_note_book/screens/home.dart';
import 'package:my_note_book/utilities/database_helper.dart';

class AddNote extends StatefulWidget {
  final Note note;
  final Function updateNoteList;
  AddNote({this.note, this.updateNoteList});
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  //final DateFormat _dateFormat = DateFormat('mmm dd, yyyy');

  String _title;
  String _body;
  //DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_dateController.text = _dateFormat.format(_date);
    if (widget.note != null) {
      _title = widget.note.title;
      _body = widget.note.body;
      //_date = widget.note.date;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                TextFormField(
                  validator: (val) =>
                      (val.isEmpty ? "provide a name for your document" : null),
                  decoration: InputDecoration(hintText: "Document title"),
                  onSaved: (val) => _title = val,
                  initialValue: _title,
                ),
                TextFormField(
                  onSaved: (val) => _body = val,
                  initialValue: _body,
                  validator: (val) => null,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 20),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Add note here",
                    border: InputBorder.none,
                  ),
                  textInputAction: TextInputAction.newline,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _save() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();

      Note _note = Note(
        title: _title,
        body: _body,
      );
      if (widget.note == null) {
        DatabaseHelper.instance.insertNote(_note);
      } else {
        DatabaseHelper.instance.update(_note);
      }
      //widget.updateNoteList();
      //refreshNoteList();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Notebook()));
    }
  }
}
