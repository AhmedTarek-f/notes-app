import 'package:flutter/material.dart';
import 'package:notes_app/core/theme/constants/colors.dart';
import 'package:notes_app/features/create_note/presentation/views_model/create_note_controller.dart';

class FloatingCreateNote extends StatelessWidget {
  const FloatingCreateNote({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CreateNoteController controller = CreateNoteController.instance;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: (){controller.changeNoteColor(context);}, icon: const Icon(Icons.color_lens_outlined)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: NoteColors.primaryColor,
                padding: const EdgeInsets.all(16)
            ),
            onPressed: () async{
              await controller.createNote();
            },
            child: const Text("Create note",style: TextStyle(color: Colors.white),),
          ),
        ),
        IconButton(onPressed: (){}, icon: const Icon(Icons.image_outlined)),
      ],
    );
  }
}
