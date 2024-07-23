class NoteModal {
  var title;
  var content;

  NoteModal({
    required this.title,
    required this.content,
  });

  factory NoteModal.fromMap(Map data) => NoteModal(
        title: data['title'],
        content: data['content'],
      );

  Map<String, dynamic> get toMap => {
        'title': title,
        'content': content,
      };
}
