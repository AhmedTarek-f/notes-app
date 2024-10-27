import 'package:flutter/material.dart';
import 'package:notes_app/features/notes_home/presentation/views/widgets/note_item.dart';

class NotesHomeViewBody extends StatelessWidget {
  const NotesHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 16,),
            NoteItem(),
          ],
        ),
      ),
    );
  }
}

