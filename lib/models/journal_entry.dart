class Note {
  int? id;
  String title;
  String content;
  DateTime date;
  bool isFavorite;

  Note({this.id, required this.title, required this.content, required this.date, this.isFavorite = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date.toIso8601String(), // Store date as ISO string
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      date: DateTime.parse(map['date']), // Parse the ISO string
      isFavorite: map['isFavorite'] == 1,
    );
  }
}
