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
    this._title = title;
  }

  set content(String content) {
    this._content = content;
  }

  set date(String date) {
    this._date = date;
  }

  Map<String, dynamic> objToMap() {
    Map<String, dynamic> mapObj = Map<String, dynamic>();

    mapObj["id"] = this.id;
    mapObj["title"] = this.title;
    mapObj["content"] = this.content;
    mapObj["date"] = this.date;
    return mapObj;
  }

  Note.mapToObj(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._content = map['content'];
    this._date = map['date'];
  }
}
