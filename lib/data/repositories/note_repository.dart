import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notes_app/features/notes_home/model/note_model.dart';

class NoteRepository extends GetxController {
  static NoteRepository get instance => Get.find();
  late final GetStorage _storage;

  @override
  void onInit() {
    _storage = GetStorage();
    super.onInit();
  }

  Future<void> saveNotes(List<NoteModel> notes) async{
    List<Map<String, dynamic>> jsonNotes = notes.map((note) => note.toJson()).toList();
    await _storage.write('notes', jsonNotes);
  }

  List<NoteModel> getNotes() {
    List<dynamic>? jsonNotes = _storage.read<List<dynamic>>('notes');
    if (jsonNotes != null) {
      final List<NoteModel> notesList = jsonNotes.map((json) => NoteModel.fromJson(Map<String, dynamic>.from(json))).toList();
      return notesList;
    }
    else{
      return [];
    }
  }

  Future<void> addNote(NoteModel note) async{
    List<NoteModel> notes = getNotes();
    notes.add(note);
    await saveNotes(notes);
  }

  Future<void> deleteNote(NoteModel note) async {
    List<dynamic>? jsonNotes = _storage.read<List<dynamic>>("notes");

    if (jsonNotes != null) {
      // Convert jsonNotes to List<Map<String, dynamic>>
      List<Map<String, dynamic>> notesList = jsonNotes.map((e) => Map<String, dynamic>.from(e)).toList();

      // Find the index of the note to delete
      notesList.removeWhere((targetedNote) => targetedNote["noteTitle"].toString() == note.noteTitle && targetedNote["date"].toString() == note.date && targetedNote["noteContents"][0]["text"].toString() == note.noteContents[0].text);

      // Save the updated list back to GetStorage
      await _storage.write("notes", notesList);
    }
  }

  Future<void> editNote({required NoteModel oldNote,required NoteModel editedNote}) async {
    List<dynamic>? jsonNotes = _storage.read<List<dynamic>>("notes");

    if (jsonNotes != null) {
      // Convert jsonNotes to List<Map<String, dynamic>>
      List<Map<String, dynamic>> notesList = jsonNotes.map((e) => Map<String, dynamic>.from(e)).toList();

      // Find the note to edit
       Map<String,dynamic> editableNote = notesList.firstWhere((targetedNote) => targetedNote["noteTitle"] == oldNote.noteTitle && targetedNote["date"] == oldNote.date);
       editableNote["noteTitle"] = editedNote.noteTitle;
       editableNote["noteContents"] = editedNote.noteContents;
       editableNote["lightNoteBackgroundColor"] = editedNote.lightNoteBackgroundColor.value;
       editableNote["darkNoteBackgroundColor"] = editedNote.darkNoteBackgroundColor.value;
      // Save the updated list back to GetStorage
      await _storage.write("notes", notesList);
    }
  }
}