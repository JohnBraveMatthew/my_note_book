class Note {
  static const tblName = "TableName";
  static const noteId = "id";
  static const noteBody = "body";
  static const noteTitle = "title";
  static const noteDate = "date";

  int id;
  String title;
  String body;
  DateTime date;
  Note({this.title, this.body, this.date});
  Note.withId({this.id, this.title, this.body, this.date});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      noteTitle: title,
      noteBody: body,
      noteDate: date.toIso8601String()
    };
    if (id != null) {
      map[noteId] = id;
    }
    return map;
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note.withId(
        id: map[noteId],
        title: map[noteTitle],
        body: map[noteBody],
        date: DateTime.parse(map[noteDate]));
  }
}
