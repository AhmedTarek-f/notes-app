import 'package:flutter/material.dart';
import 'package:notes_app/features/create_note/presentation/views/widgets/create_note_form.dart';

class CreateNoteViewBody extends StatelessWidget {
  const CreateNoteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16,),
            CreateNoteForm(),
          ],
        ),
      ),
    );
  }
}


