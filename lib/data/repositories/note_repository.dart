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
      return jsonNotes.map((json) => NoteModel.fromJson(Map<String, dynamic>.from(json))).toList();
    }
    else{
      return [];
    }
  }

  Future<void> addNote(NoteModel note) async{
    // Retrieve the current list of notes from GetStorage
    List<dynamic>? jsonNotes = _storage.read<List<dynamic>>('notes');

    // Convert to List<NoteModel> if it exists, or initialize an empty list
    List<NoteModel> notes = jsonNotes != null
        ? jsonNotes.map((json) => NoteModel.fromJson(Map<String, dynamic>.from(json))).toList()
        : [];

    // Add the new note to the list
    notes.add(note);

    // Save the updated list back to GetStorage
   await saveNotes(notes);
  }

  Future<void> deleteNote(NoteModel note) async {
    List<dynamic>? jsonNotes = _storage.read<List<dynamic>>("notes");

    if (jsonNotes != null) {
      // Convert jsonNotes to List<Map<String, dynamic>>
      List<Map<String, dynamic>> notesList = jsonNotes.map((e) => Map<String, dynamic>.from(e)).toList();

      // Find the index of the note to delete
      notesList.removeWhere((targetedNote) => targetedNote["noteTitle"] == note.noteTitle && targetedNote["date"] == note.date && targetedNote["noteBody"] == note.noteBody);

      // Save the updated list back to GetStorage
      await _storage.write("notes", notesList);
    }
  }
}