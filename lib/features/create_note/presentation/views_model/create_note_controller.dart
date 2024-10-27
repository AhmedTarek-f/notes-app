import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/core/utlis/loaders/loaders.dart';
import 'package:notes_app/data/repositories/note_repository.dart';
import 'package:notes_app/features/notes_home/model/note_model.dart';
import 'package:notes_app/features/notes_home/presentation/views_model/notes_home_controller.dart';

class CreateNoteController extends GetxController
{
  static CreateNoteController get instance => Get.find();
  final NotesHomeController notesHomeController =  NotesHomeController.instance;
  final NoteRepository _noteRepository = NoteRepository.instance;
  late final TextEditingController title;
  late final TextEditingController content;
  final String date = DateFormat('MMMM d \'at\' h:mm a').format(DateTime.now()).toString();
  GlobalKey<FormState> createNoteFormKey = GlobalKey<FormState>();
  Rx<AutovalidateMode> autoValidateMode = AutovalidateMode.disabled.obs;
  @override
  void onInit() {
    title = TextEditingController();
    content = TextEditingController();
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
  Future<void> createNote() async{
    try{
      if(createNoteFormKey.currentState!.validate()) {
        final NoteModel note = NoteModel(
            noteTitle: title.text,
            noteBody: content.text,
            date: date
        );
        notesHomeController.notesList.add(note);
        await _noteRepository.addNote(note);
        disableAutoValidateMode();
        Loaders.successSnackBar(title: "Note creation",message: "Note has been created successfully.");
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