import 'package:flutter/material.dart';
import 'package:notes_app/features/notes_home/model/note_content.dart';

class NoteModel {
   NoteModel({
    required this.noteTitle,
    required this.noteContents,
    required this.date,
     required this.lightNoteBackgroundColor,
     required this.darkNoteBackgroundColor,
  });
  String noteTitle;
  final String date;
  Color lightNoteBackgroundColor;
  Color darkNoteBackgroundColor;
   List<NoteContent> noteContents;
  // Convert NoteModel to Map
  Map<String, dynamic> toJson() {
    return {
      'noteTitle': noteTitle,
      'noteContents': noteContents.map((content) => content.toJson()).toList(),
      'date': date,
      'lightNoteBackgroundColor': lightNoteBackgroundColor.value,
      'darkNoteBackgroundColor': darkNoteBackgroundColor.value,
    };
  }

  // Convert Map to NoteModel
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      noteTitle: json['noteTitle'],
      noteContents: (json['noteContents'] as List<dynamic>).map((contentJson) => NoteContent.fromJson(Map<String,dynamic>.from(contentJson))).toList(),
      date: json['date'],
      lightNoteBackgroundColor: Color(json['lightNoteBackgroundColor']),
      darkNoteBackgroundColor: Color(json['darkNoteBackgroundColor']),
    );
  }
}