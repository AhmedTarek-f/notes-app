import 'package:flutter/material.dart';
import 'package:notes_app/core/theme/constants/app_styles.dart';
import 'package:notes_app/features/notes_home/presentation/views_model/notes_home_controller.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final NotesHomeController controller = NotesHomeController.instance;
    return  TextField(
      controller: controller.searchFieldController,
      decoration: InputDecoration(
        hintText: "Search by note title",
        hintStyle: AppStyles.stylesMedium14.copyWith(color: Colors.grey[700]),
        suffixIcon: IconButton(
          onPressed: (){
            controller.clearSearchField();
          },
          icon: const Icon(Icons.clear),
        ),
        border: buildOutlineInputBorder(),
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(),
        errorBorder: buildOutlineInputBorder(),
      ),
      onChanged: (noteTitle){
        controller.noteSearch(noteTitle: noteTitle);
      },
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(16)
    );
  }
}
