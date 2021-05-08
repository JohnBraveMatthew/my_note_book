import 'package:flutter/material.dart';
import 'package:my_note_book/screens/add_note.dart';
import 'package:my_note_book/screens/home.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: Notebook(),
      routes: {
        "/": (context) => Notebook(),
        "/addNote": (context) => AddNote()
      },
      title: "Notebook",
      debugShowCheckedModeBanner: false,
    );
  }
}
