import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/features/create_note/presentation/views/create_note_view.dart';

class FloatingAddNewNotes extends StatelessWidget {
  const FloatingAddNewNotes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff6B4EFF),
          padding: const EdgeInsets.all(16)
      ),
      onPressed: (){
        Get.to(() => const CreateNoteView());
      },
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add,color: Colors.white,size: 26,),
          SizedBox(width: 8,),
          Text("Add New Notes",style: TextStyle(color: Colors.white),),
        ],
      ),
    );
  }
}
