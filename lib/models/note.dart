class Note {
  int _id;
  int _priority;
  String _title;
  String _noteContent;
  String _date;

  Note(this._title, this._date, this._priority, [this._noteContent]);

  Note.withId(this._id, this._title, this._date, this._priority, [this._noteContent]);


  int get id => _id;

  int get priority => _priority;

  String get title => _title;

  String get noteContent => _noteContent;

  String get date => _date;

  set title(String title) {
    this._title = title;
  }

  set noteContent(String noteContent) {
    this._noteContent = _noteContent;
  }

  set date(String date) {
    this._date = date;
  }

  set priority(int priority) {
    this._priority = priority;
  }

  Map<String, dynamic> objToMap(){
    Map<String, dynamic> map = new Map<String, dynamic>();

    map["id"] = this._id;
    map["priority"] = this._priority;
    map["title"] = this._title;
    map["noteContent"] = this._noteContent;
    map["date"] = this._date;

    return map;
  }

  Note.mapToObj(Map<String, dynamic> map) {
    this._id = map["id"];
    this._priority = map["priority"];
    this._title = map["title"];
    this._noteContent = map["noteContent"];
    this._date = map["date"];
  }
}
