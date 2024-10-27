import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/features/create_note/presentation/views/create_note_view.dart';

class FloatingCreateDeleteNote extends StatelessWidget {
  const FloatingCreateDeleteNote({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              Get.to(() => const CreateNoteView());
            },
            child: const Text("Cancel",style: TextStyle(color: Colors.white),),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff6B4EFF),
                padding: const EdgeInsets.all(16)
            ),
            onPressed: (){
              Get.to(() => const CreateNoteView());
            },
            child: const Text("Create",style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
