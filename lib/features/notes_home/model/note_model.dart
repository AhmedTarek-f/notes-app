import 'package:flutter/material.dart';

class NoteModel {
   NoteModel({
    required this.noteTitle,
    required this.noteBody,
    required this.date,
     required this.lightNoteBackgroundColor,
     required this.darkNoteBackgroundColor,
  });
  String noteTitle;
  String? noteBody;
  final String date;
  Color lightNoteBackgroundColor;
  Color darkNoteBackgroundColor;

  // Convert NoteModel to Map
  Map<String, dynamic> toJson() {
    return {
      'noteTitle': noteTitle,
      'noteBody': noteBody,
      'date': date,
      'lightNoteBackgroundColor': lightNoteBackgroundColor.value,
      'darkNoteBackgroundColor': darkNoteBackgroundColor.value,
    };
  }

  // Convert Map to NoteModel
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      noteTitle: json['noteTitle'],
      noteBody: json['noteBody'],
      date: json['date'],
      lightNoteBackgroundColor: Color(json['lightNoteBackgroundColor']),
      darkNoteBackgroundColor: Color(json['darkNoteBackgroundColor']),
    );
  }
}