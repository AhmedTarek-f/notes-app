import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/core/theme/constants/app_styles.dart';

class CreateNoteForm extends StatelessWidget {
  const CreateNoteForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark ;
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                style: AppStyles.stylesSemiBold24.copyWith(color:isDarkMode ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: AppStyles.stylesSemiBold24.copyWith(color:isDarkMode ? Colors.grey[700] : Colors.grey),
                ),
              ),
              const SizedBox(height: 8,),
              Text(DateFormat('MMMM d \'at\' h:mm a').format(DateTime.now()).toString(),style: AppStyles.stylesRegular14,),

            ],
          ),
          const SizedBox(height: 16,),
          TextFormField(
            style: AppStyles.stylesSemiBold20.copyWith(color:isDarkMode ? Colors.white : Colors.black),
            decoration: InputDecoration(
              hintText: "Content",
              hintStyle: AppStyles.stylesMedium20.copyWith(color:isDarkMode ? Colors.grey[700] : Colors.grey),
            ),
            maxLines: null,
          ),
        ],
      ),
    );
  }
}