import 'package:flutter/material.dart';
import 'package:Note_App/screens/note_list.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
//        primaryColor: Colors.cyan,
        primarySwatch: Colors.teal,
      ),
      home: NoteList(),
    );
  }
}
