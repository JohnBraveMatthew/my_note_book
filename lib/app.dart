import 'package:flutter/material.dart';
import 'package:my_note_book/notebook.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Notebook(),
      title: "Notebook",
      debugShowCheckedModeBanner: false,
    );
  }
}
