import 'package:Note_App/models/note.dart';
import 'package:Note_App/screens/edit_note.dart';
import 'package:Note_App/screens/view_note.dart';
import 'package:Note_App/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  Note note = Note('', '', '');
  List<Note> noteList;
  int _count = 0;
  final DatabaseHelper _helper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = <Note>[];
      updateNoteListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      backgroundColor: Colors.white,
      body: showNoteList(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Create Note",
        onPressed: () {
          goToNoteDetails();
        },
        child: const Icon(Icons.create),
      ),
    );
  }

  Future goToNoteDetails() async {
    final bool response = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => CreateNote(Note('', '', ''))));
    if (response == true) {
      updateNoteListView();
    }
  }

  Widget showNoteList() {
    final listView = ListView.builder(
      itemCount: _count,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          elevation: 12.0,
          child: ListTile(
            leading: const Icon(
              Icons.book,
              color: Colors.black,
            ),
            title: Text(
              noteList[index].title,
              style: const TextStyle(fontFamily: 'amaranth', fontSize: 20.0),
            ),
            subtitle: Text(
              noteList[index].date,
              style: const TextStyle(
                  fontFamily: 'caveat',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            trailing: GestureDetector(
              onTap: () {
                _delete(context, noteList[index]);
              },
              child: const Icon(
                Icons.delete,
                color: Colors.blueGrey,
              ),
            ),
            onTap: () {
              _viewNote(noteList[index]);
            },
          ),
        );
      },
    );
    return listView;
  }

  void updateNoteListView() {
    final Future<Database> dbFuture = _helper.initializeDatabase();
    dbFuture.then((database) {
      final Future<List<Note>> noteListFuture = _helper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          _count = noteList.length;
        });
      });
    });
  }

  Future _delete(BuildContext context, Note note) async {
    final int response = await _helper.delete(note.id);
    if (response != 0) {
      updateNoteListView();
    }
  }

  Future _viewNote(Note note) async {
    final bool response = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ViewNote(note)));
    if (response) {
      updateNoteListView();
    }
  }
}
