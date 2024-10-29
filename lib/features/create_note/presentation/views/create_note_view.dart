import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/theme/constants/app_styles.dart';
import 'package:notes_app/features/create_note/presentation/views/widgets/create_note_view_body.dart';
import 'package:notes_app/features/create_note/presentation/views/widgets/floating_create_note.dart';
import 'package:notes_app/features/create_note/presentation/views_model/create_note_controller.dart';

class CreateNoteView extends StatelessWidget {
  const CreateNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateNoteController controller = Get.put(CreateNoteController());
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Obx(
      ()=> Scaffold(
        backgroundColor:isDarkMode?
        (controller.darkPickerColor.value == Color(0xFF212121) ? Colors.black :controller.darkPickerColor.value)
            :(controller.lightPickerColor.value == Color(0x1F000000)? Colors.white : controller.lightPickerColor.value),
        floatingActionButton: const FloatingCreateNote(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
        appBar: AppBar(
          backgroundColor: isDarkMode?
          (controller.darkPickerColor.value == Color(0xFF212121) ? Colors.black :controller.darkPickerColor.value)
              :(controller.lightPickerColor.value == Color(0x1F000000)? Colors.white : controller.lightPickerColor.value),
          surfaceTintColor: Colors.transparent,
          title: Text("Create Note",style: AppStyles.stylesSemiBold24,),
        ),
        body: const CreateNoteViewBody(),
      
      ),
    );
  }
}
