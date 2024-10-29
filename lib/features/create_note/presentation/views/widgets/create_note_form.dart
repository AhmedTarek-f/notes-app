
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/theme/constants/app_styles.dart';
import 'package:notes_app/core/utlis/common_widgets/note_content_section.dart';
import 'package:notes_app/core/utlis/common_widgets/note_title_field.dart';
import 'package:notes_app/features/create_note/presentation/views_model/create_note_controller.dart';

class CreateNoteForm extends StatelessWidget {
  const CreateNoteForm({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateNoteController controller = CreateNoteController.instance;
    return Obx(
      ()=> Expanded(
        child: Padding(
          padding: EdgeInsets.only(bottom:MediaQuery.sizeOf(context).height*0.073),
          child: Form(
            key: controller.createNoteFormKey,
            autovalidateMode: controller.autoValidateMode.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NoteTitleField(title: controller.title,),
                    const SizedBox(height: 8,),
                    Text(controller.date,style: AppStyles.stylesRegular14,),

                  ],
                ),
                const SizedBox(height: 16,),
                NoteContentSection(noteContents: controller.noteContents,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}