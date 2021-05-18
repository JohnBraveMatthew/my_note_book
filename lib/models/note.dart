class Note {
  // static const tblName = "TableName";
  // static const noteId = "id";
  // static const noteBody = "body";
  // static const noteTitle = "title";
  // static const noteDate = "date";
  int id;
  String title, body;
  //DateTime date;

  Note({
    this.id,
    this.title,
    this.body,
  });

  Note.withId({
    this.id,
    this.title,
    this.body,
  });

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map["id"] = id;
    }

    map["title"] = title;
    map["body"] = body;
    //map["date"] = date.toIso8601String();
    return map;
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note.withId(
      id: map["id"],
      title: map["title"],
      body: map["body"],
    );
  }

  // Map<String, dynamic> toMap() {
  //   var map = <String, dynamic>{
  //     noteBody: body,
  //     noteTitle: title,
  //     //noteDate: date.toIso8601String(),
  //   };
  //   if (id != null) {
  //     map[noteId] = id;
  //   }
  //   return map;
  // }

  // Note.fromMap(Map<String, dynamic> map) {
  //   id = map[noteId];
  //   body = map[noteBody];
  //   title = map[noteTitle];
  //   //date = map[noteDate];
  // }
}
