class NoteForListing{
  String noteID;
  String noteTitle;
  DateTime createDateTime;
  DateTime lastestEditDateTime;

  NoteForListing(
    {
      this.noteID,
      this.noteTitle,
      this.createDateTime,
      this.lastestEditDateTime
    }
  );

  factory NoteForListing.fromJson(Map<String,dynamic> item) {
    return NoteForListing(
      noteID : item['noteID'],
      noteTitle: item['noteTitle'],
      createDateTime: DateTime.parse(item['createDateTime']),
      lastestEditDateTime:  item['lastestEditDateTime'] != null ? DateTime.parse(item['lastestEditDateTime']) :null,
    );
  }

}