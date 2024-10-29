import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/theme/constants/app_styles.dart';
import 'package:notes_app/data/repositories/note_repository.dart';
import 'package:notes_app/features/notes_home/model/note_content.dart';
import 'package:notes_app/features/notes_home/model/note_model.dart';

class NotesHomeController extends GetxController {
  static NotesHomeController get instance => Get.find();
  final NoteRepository _noteRepository = Get.put(NoteRepository());
  late final TextEditingController searchFieldController;
  RxList<NoteModel> notesList = <NoteModel>[].obs;
  RxList<NoteModel> notesSearchList = <NoteModel>[].obs;
  RxBool isSearchSelected = false.obs;


  @override
  void onInit() {
    initNotesList();
    searchFieldController = TextEditingController();
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

  Text displayNoteTextContent({required List<NoteContent> noteContents}) {
    String noteContent = "";
    for(var item in noteContents){
      if(item.text != null && (item.text?.isNotEmpty?? false)){
        noteContent += "${item.text} ";
      }
    }
    return Text(noteContent,style: AppStyles.stylesRegular16,maxLines: 4,);
  }

  void noteSearch({required String noteTitle}) {
    if(notesList.isNotEmpty){
      notesSearchList.clear();
      List<NoteModel> notesSearch = notesList.where((note)=> note.noteTitle.toLowerCase().contains(noteTitle.toLowerCase())).toList();
      notesSearchList.assignAll(notesSearch);
    }
  }

  void clearSearchField(){
    searchFieldController.clear();
    notesSearchList.clear();
  }

  @override
  void onClose() {
    searchFieldController.dispose();
    super.onClose();
  }
}