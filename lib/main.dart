import 'package:flutter/material.dart';
import './screens/note_list.dart';
import './screens/note_details.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Note Application",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: NoteList(),
    );
  }
}
