import 'package:flutter/material.dart';
import 'package:my_note_book/screens/home.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.redAccent),
      home: Notebook(),
      // routes: {
      //   "/": (context) => Notebook(),
      //   "/addNote": (context) => AddNote()
      // },
      title: "Notebook",
      debugShowCheckedModeBanner: false,
    );
  }
}
