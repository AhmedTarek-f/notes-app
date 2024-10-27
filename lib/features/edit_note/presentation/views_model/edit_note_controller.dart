import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/core/utlis/loaders/loaders.dart';
import 'package:notes_app/data/repositories/note_repository.dart';
import 'package:notes_app/features/notes_home/model/note_model.dart';
import 'package:notes_app/features/notes_home/presentation/views_model/notes_home_controller.dart';

class EditNoteController extends GetxController
{
  static EditNoteController get instance => Get.find();


  final NotesHomeController notesHomeController =  NotesHomeController.instance;
  final NoteRepository _noteRepository = NoteRepository.instance;
  late final TextEditingController title;
  late final TextEditingController content;
  late final String date;
  late final NoteModel oldNote;
  GlobalKey<FormState> editNoteFormKey = GlobalKey<FormState>();
  Rx<AutovalidateMode> autoValidateMode = AutovalidateMode.disabled.obs;
  @override
  void onInit() {
    oldNote = Get.arguments as NoteModel;
    title = TextEditingController();
    content = TextEditingController();
    title.text= oldNote.noteTitle;
    content.text = oldNote.noteBody ?? "";
    date = oldNote.date;
    super.onInit();
  }
  void applyAutoValidateMode()
  {
    autoValidateMode.value = AutovalidateMode.always;
  }
  void disableAutoValidateMode()
  {
    autoValidateMode.value = AutovalidateMode.disabled;
  }
  Future<void> editNote() async{
    try{
      if(editNoteFormKey.currentState!.validate()) {
        final NoteModel editedNote = NoteModel(
            noteTitle: title.text,
            noteBody: content.text,
            date: date
        );
        notesHomeController.notesList.remove(oldNote);
        await _noteRepository.editNote(oldNote: oldNote,editedNote: editedNote);
        notesHomeController.notesList.add(editedNote);
        disableAutoValidateMode();
        Loaders.successSnackBar(title: "Note edit",message: "Note has been Edited successfully.");
        Navigator.pop(Get.overlayContext!);
      }
      else{
        applyAutoValidateMode();
      }
    }
    catch(e) {
     Loaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  @override
  void onClose() {
    title.dispose();
    content.dispose();
    super.onClose();
  }
}