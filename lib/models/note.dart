class Note{
  String noteID;
  String noteTitle;
  String noteContent;
  DateTime createDateTime;
  DateTime lastestEditDateTime;

  Note(
    {
      this.noteID,
      this.noteTitle,
      this.noteContent,
      this.createDateTime,
      this.lastestEditDateTime
    }
  );
  factory Note.fromJson(Map<String,dynamic> item) {
    return Note(
      noteID : item['noteID'],
      noteTitle: item['noteTitle'],
      noteContent: item['noteContent'],
      createDateTime: DateTime.parse(item['createDateTime']),
      lastestEditDateTime:  item['lastestEditDateTime'] != null ? DateTime.parse(item['lastestEditDateTime']) :null,
    );
  }

}