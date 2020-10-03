import 'package:Note_App/models/note.dart';
import 'package:Note_App/screens/edit_note.dart';
import 'package:Note_App/utils/database_helper.dart';
import 'package:flutter/material.dart';

class ViewNote extends StatefulWidget {
  final Note note;

  const ViewNote(this.note);

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  final DatabaseHelper _helper = DatabaseHelper();
  Note note;

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            goToLastScreen();
          }),
      title: const Text('Notes'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            setState(() {
              _editNote(context);
            });
          },
          child: const Icon(
            Icons.edit,
            color: Colors.black,
          ),
        ),
      ],
    );
    return WillPopScope(
      onWillPop: () {
        goToLastScreen();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: appBar,
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Card(
              color: Colors.white,
              elevation: 3.0,
              child: SizedBox(
                height: 75.0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 8.0),
                  child: Text(
                    widget.note.title,
                    style:
                        const TextStyle(fontFamily: 'Amaranth', fontSize: 20.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.note.content,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'redHat',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future updateNote() async {
    final Note note = await _helper.getNoteById(widget.note.id);
    setState(() {
      this.note = note;
    });
  }

  void goToLastScreen() {
    Navigator.pop(context, true);
  }

  Future _editNote(BuildContext context) async {
    final bool response = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => CreateNote(widget.note)));
    if (response) {
      print(response.toString());
      updateNote();
    }
  }
}
