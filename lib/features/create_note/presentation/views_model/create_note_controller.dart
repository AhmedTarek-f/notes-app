import 'dart:developer';
import 'dart:ffi';

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
  Rx<Color> lightPickerColor = const Color(0x1F000000).obs;
  Rx<Color> darkPickerColor = const Color(0xFF212121).obs;
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
            date: date,
          darkNoteBackgroundColor: darkPickerColor.value,
          lightNoteBackgroundColor: lightPickerColor.value,
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
  void changeColors(Color color) {
    darkPickerColor.value = color;
    lightPickerColor.value = color;
  }
  void changeNoteColor(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Get.defaultDialog(
      title: "Pick note color",
      titleStyle: AppStyles.stylesSemiBold18,
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