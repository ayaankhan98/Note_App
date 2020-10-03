import 'package:Note_App/models/note.dart';
import 'package:Note_App/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateNote extends StatefulWidget {
  final Note note;

  const CreateNote(this.note);

  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final DatabaseHelper _helper = DatabaseHelper();
  Note note;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _titleController.text = widget.note.title;
    _noteController.text = widget.note.content;

    return WillPopScope(
      onWillPop: () {
        goToLastScreen();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Note'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                setState(() {
                  if (widget.note.id == null) {
                    _saveToDatabase();
                  } else {
                    _updateNoteToDatabase();
                  }
                });
              },
              child: const Icon(
                Icons.done,
                color: Colors.black,
              ),
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
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Put Note Title',
                ),
                onChanged: (value) {
                  updateTitle(value);
                },
              ),
              const SizedBox(
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
                    decoration: const InputDecoration(
                      hintText: "Write a Note...",
                    ),
                    onChanged: (value) {
                      updateContent(value);
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(String title, String message) {
    final AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }

  void goToLastScreen() {
    Navigator.pop(context, true);
  }

  Future _saveToDatabase() async {
    goToLastScreen();
    widget.note.date = DateFormat.yMMMd().format(DateTime.now());
    int response;
    if (widget.note.id != null) {
    } else {
      response = await _helper.insert(widget.note);
    }
    if (response != 0) {
//      _showAlertDialog('Status', 'Note Saved');
    } else {
      _showAlertDialog('Status', 'Unable to Save');
    }
  }

  void _updateNoteToDatabase() {
    goToLastScreen();
    _helper.update(widget.note);
  }

  void updateTitle(String value) {
    setState(() {
      widget.note.title = value;
    });
  }

  void updateContent(String value) {
    setState(() {
      widget.note.content = value;
    });
  }
}
