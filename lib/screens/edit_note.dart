import 'package:Note_App/models/note.dart';
import 'package:Note_App/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateNote extends StatefulWidget {
  final Note note;

  CreateNote(this.note);

  @override
  _CreateNoteState createState() => _CreateNoteState(note);
}

class _CreateNoteState extends State<CreateNote> {
  DatabaseHelper _helper = DatabaseHelper();
  Note note;

  _CreateNoteState(this.note);

  TextEditingController _titleController = new TextEditingController();
  TextEditingController _noteController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    _titleController.text = this.note.title;
    _noteController.text = this.note.content;

    return WillPopScope(
      onWillPop: () {
        goToLastScreen();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Note'),
          actions: <Widget>[
            FlatButton(
              child: Icon(
                Icons.done,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  if (note.id == null) {
                    _saveToDatabase();
                  } else {
                    _updateNoteToDatabase();
                  }
                });
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              TextField(
                controller: _titleController,
                maxLength: 256,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Put Note Title',
                ),
                onChanged: (value) {
                  updateTitle(value);
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Card(
                elevation: 5.0,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: TextField(

                    controller: _noteController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Write a Note...",
                    ),
                    onChanged: (value) {
                      updateContent(value);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }

  void goToLastScreen() {
    Navigator.pop(context, true);
  }

  _saveToDatabase() async {
    goToLastScreen();
    note.date = DateFormat.yMMMd().format(DateTime.now());
    int response;
    if (note.id != null) {
    } else {
      response = await _helper.insert(note);
    }
    if (response != 0) {
//      _showAlertDialog('Status', 'Note Saved');
    } else {
      _showAlertDialog('Status', 'Unable to Save');
    }
  }

  _updateNoteToDatabase() {
    goToLastScreen();
    _helper.update(note);
  }

  updateTitle(String value) {
    note.title = value;
  }

  updateContent(String value) {
    note.content = value;
  }
}
