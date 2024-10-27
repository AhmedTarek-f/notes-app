class NoteModel {
   NoteModel({
    required this.noteTitle,
    required this.noteBody,
    required this.date
  });
  String noteTitle;
  String? noteBody;
  final String date;

  // Convert NoteModel to Map
  Map<String, dynamic> toJson() {
    return {
      'noteTitle': noteTitle,
      'noteBody': noteBody,
      'date': date,
    };
  }

  // Convert Map to NoteModel
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      noteTitle: json['noteTitle'],
      noteBody: json['noteBody'],
      date: json['date'],
    );
  }
}