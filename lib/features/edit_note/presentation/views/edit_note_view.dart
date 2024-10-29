import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/theme/constants/app_styles.dart';
import 'package:notes_app/features/edit_note/presentation/views/widgets/edit_note_view_body.dart';
import 'package:notes_app/features/edit_note/presentation/views/widgets/floating_edit_note.dart';
import 'package:notes_app/features/edit_note/presentation/views_model/edit_note_controller.dart';

class EditNoteView extends StatelessWidget {
  const EditNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    final EditNoteController controller = Get.put(EditNoteController());
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Obx(
        ()=> Scaffold(
        backgroundColor:isDarkMode?
        (controller.darkPickerColor.value == Color(0xFF212121) ? Colors.black :controller.darkPickerColor.value)
            :(controller.lightPickerColor.value == Color(0x1F000000)? Colors.white : controller.lightPickerColor.value),
        floatingActionButton: const FloatingEditNote(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
        appBar: AppBar(
          backgroundColor:isDarkMode?
          (controller.darkPickerColor.value == Color(0xFF212121) ? Colors.black :controller.darkPickerColor.value)
              :(controller.lightPickerColor.value == Color(0x1F000000)? Colors.white : controller.lightPickerColor.value),
          surfaceTintColor: Colors.transparent,
          title: Text("Edit Note",style: AppStyles.stylesSemiBold24,),
        ),
        body: const EditNoteViewBody(),

      ),
    );
  }
}
