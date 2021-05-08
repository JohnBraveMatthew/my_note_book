class Note {
  static const tblName = "TableName";
  static const noteId = "id";
  static const noteBody = "body";
  static const noteTitle = "title";
  List notes;
  int id;
  String title, body;

  Note({this.id, this.title, this.body, this.notes});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{noteBody: body, noteTitle: title};
    if (id != null) {
      map[noteId] = id;
    }
    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    id = map[noteId];
    body = map[noteBody];
    title = map[noteTitle];
  }
}
