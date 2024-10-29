class NoteContent {
  String? text;
  String? imagePath;

  NoteContent({this.text, this.imagePath});

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'imagePath': imagePath,
    };
  }

  factory NoteContent.fromJson(Map<String, dynamic> json) {
    return NoteContent(
      text: json['text'] as String?,
      imagePath: json['imagePath'] as String?,
    );
  }
}
