import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:notes_app/data/repositories/note_repository.dart';
import 'package:notes_app/features/notes_home/model/note_model.dart';

class NotesHomeController extends GetxController {
  static NotesHomeController get instance => Get.find();
  final NoteRepository _noteRepository = Get.put(NoteRepository());
  RxList<NoteModel> notesList = <NoteModel>[].obs;

  @override
  void onInit() {
    initNotesList();
    FlutterNativeSplash.remove();
    super.onInit();
  }

  void initNotesList() {
    final List<NoteModel> allNotes = _noteRepository.getNotes();
    notesList.assignAll(allNotes);
  }

  Future<void> deleteNote({required NoteModel note}) async{
    await _noteRepository.deleteNote(note);
    final List<NoteModel> allNotes = _noteRepository.getNotes();
    notesList.clear();
    notesList.assignAll(allNotes);
    Get.back();
  }
}