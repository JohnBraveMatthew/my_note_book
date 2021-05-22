import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_note_book/models/note.dart';
import 'package:my_note_book/screens/home.dart';
import 'package:my_note_book/utilities/database_helper.dart';

class AddNote extends StatefulWidget {
  final Note note;
  final Function refreshNoteList;
  AddNote({this.note, this.refreshNoteList});
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  //final DateFormat _dateFormat = DateFormat('mmm dd, yyyy');
  // String _title;
  // String _body;
  DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('MMM dd, yyyy');

  Note _note = Note();
  DatabaseHelper _DBhelper;
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _DBhelper = DatabaseHelper.instance;

    if (widget.note != null) {
      _note.title = widget.note.title;
      _note.body = widget.note.body;
      _note.date = widget.note.date;
    }

    _dateController.text = _dateFormat.format(_date);
  }

  @override
  void dispose() {
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
              widget.note == null ? "Save" : "update",
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
                  onSaved: (val) => _note.title = val,
                  initialValue: _note.title,
                ),
                TextFormField(
                  onSaved: (val) => _note.body = val,
                  initialValue: _note.body,
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

  setTime() {
    setState(() {
      _note.date = _date;
    });
  }

  _save() async {
    setTime();

    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      if (widget.note != null) {
        _note.id = widget.note.id;
        await _DBhelper.update(_note);
      } else {
        await _DBhelper.insertNote(_note);
      }
      setState(() {
        _DBhelper.fetchNote();
      });
      widget.refreshNoteList();
      Navigator.pop(
          context, MaterialPageRoute(builder: (context) => Notebook()));
    }
  }
}
