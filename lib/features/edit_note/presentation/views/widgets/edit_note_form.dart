import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/theme/constants/app_styles.dart';
import 'package:notes_app/features/edit_note/presentation/views_model/edit_note_controller.dart';

class EditNoteForm extends StatelessWidget {
  const EditNoteForm({super.key});

  @override
  Widget build(BuildContext context) {
    final EditNoteController controller = Get.put(EditNoteController());
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark ;
    return Obx(
      ()=> Expanded(
        child: Padding(
          padding: EdgeInsets.only(bottom:MediaQuery.sizeOf(context).height*0.1),
          child: Form(
            key: controller.editNoteFormKey,
            autovalidateMode: controller.autoValidateMode.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: controller.title,
                      style: AppStyles.stylesMedium20.copyWith(color:isDarkMode ? Colors.white : Colors.black),
                      decoration: InputDecoration(
                        hintText: "Title",
                        hintStyle: AppStyles.stylesSemiBold24.copyWith(color:isDarkMode ? Colors.grey[700] : Colors.grey),
                      ),
                      validator: (value){
                        if((value?.isEmpty??true) || value?.trim() == "" || value == null){
                          return "Title can't be empty, please enter a title for the note";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8,),
                    Text(controller.date,style: AppStyles.stylesRegular14,),
        
                  ],
                ),
                const SizedBox(height: 16,),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    expands: true,
                    controller: controller.content,
                    style: AppStyles.stylesRegular18.copyWith(color:isDarkMode ? Colors.white : Colors.black),
                    decoration: InputDecoration(
                      hintText: "Content",
                      hintStyle: AppStyles.stylesSemiBold20.copyWith(color:isDarkMode ? Colors.grey[700] : Colors.grey),
                    ),
                    maxLines: null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}