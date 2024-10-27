import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/theme/constants/colors.dart';
import 'package:notes_app/features/create_note/presentation/views_model/create_note_controller.dart';

class FloatingCreateDeleteNote extends StatelessWidget {
  const FloatingCreateDeleteNote({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CreateNoteController controller = CreateNoteController.instance;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
                padding: const EdgeInsets.all(16)
            ),
            onPressed: (){
              Get.back();
            },
            child: const Text("Cancel",style: TextStyle(color: Colors.white),),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: NoteColors.primaryColor,
                padding: const EdgeInsets.all(16)
            ),
            onPressed: () async{
              await controller.createNote();
            },
            child: const Text("Create",style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
