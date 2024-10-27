import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/core/theme/constants/app_styles.dart';
import 'package:notes_app/core/theme/constants/colors.dart';
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
  late Rx<Color> lightPickerColor;
  late Rx<Color> darkPickerColor;

  @override
  void onInit() {
    oldNote = Get.arguments as NoteModel;
    title = TextEditingController();
    content = TextEditingController();
    title.text= oldNote.noteTitle;
    content.text = oldNote.noteBody ?? "";
    date = oldNote.date;
    lightPickerColor = oldNote.lightNoteBackgroundColor.obs;
    darkPickerColor = oldNote .darkNoteBackgroundColor.obs;
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
            date: date,
          darkNoteBackgroundColor: darkPickerColor.value,
          lightNoteBackgroundColor: lightPickerColor.value,
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

  void changeColors(Color color) {
    darkPickerColor.value = color;
    lightPickerColor.value = color;
  }
  void changeNoteColor(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Get.defaultDialog(
        title: "Pick note color",
        titleStyle: AppStyles.stylesSemiBold14,
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: isDarkMode? darkPickerColor.value :lightPickerColor.value,
            onColorChanged: (value) {
              changeColors(value);
            },
          ),
        ),
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: NoteColors.primaryColor,
            padding: const EdgeInsets.all(8)
        ),
        onPressed: (){
          Get.back();
        },
        child: Text("Pick",style: AppStyles.stylesRegular14.copyWith(color: Colors.white),),
      ),
    );
  }

  @override
  void onClose() {
    title.dispose();
    content.dispose();
    super.onClose();
  }
}