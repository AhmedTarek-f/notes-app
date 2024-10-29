import 'package:flutter/material.dart';
import 'package:notes_app/core/theme/constants/app_styles.dart';

class NoteTitleField extends StatelessWidget {
  const NoteTitleField({
    super.key, required this.title,
  });

  final TextEditingController title;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark ;
    return TextFormField(
      controller: title,
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
    );
  }
}