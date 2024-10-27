import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/theme/constants/colors.dart';
import 'package:notes_app/features/create_note/presentation/views_model/create_note_controller.dart';
import 'package:notes_app/features/edit_note/presentation/views_model/edit_note_controller.dart';

class FloatingEditNote extends StatelessWidget {
  const FloatingEditNote({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final EditNoteController controller = EditNoteController.instance;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: NoteColors.primaryColor,
          padding: const EdgeInsets.all(16)
      ),
      onPressed: () async{
        await controller.editNote();
      },
      child: const Text("Edit note",style: TextStyle(color: Colors.white),),
    );
  }
}
