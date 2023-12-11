class Note {
  String? title;
  String? content;
  DateTime? createAt;
  DateTime? updateAt;


  Note(
      {
       this.title,
       this.content,
       this.createAt,
       this.updateAt});

  @override
  String toString() {
    return 'Note{title: $title, content: $content, createAt: $createAt, updateAt: $updateAt}';
  }
}
