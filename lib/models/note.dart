class Note {
  int _id;
  String _title;
  String _content;
  String _date;

  Note(this._title, this._content, this._date);

  Note.withId(this._id, this._title, this._content, this._date);

  int get id => _id;

  String get title => _title;

  String get content => _content;

  String get date => _date;

  set title(String title) {
    _title = title;
  }

  set content(String content) {
    _content = content;
  }

  set date(String date) {
    _date = date;
  }

  Map<String, dynamic> objToMap() {
    final Map<String, dynamic> mapObj = <String, dynamic>{};

    mapObj["id"] = id;
    mapObj["title"] = title;
    mapObj["content"] = content;
    mapObj["date"] = date;
    return mapObj;
  }

  Note.mapToObj(Map<String, dynamic> map) {
    _id = map['id'] as int;
    _title = map['title'] as String;
    _content = map['content'] as String;
    _date = map['date'] as String;
  }
}
