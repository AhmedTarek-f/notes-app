import 'package:flutter/material.dart';
import 'package:notes_app/core/theme/constants/app_styles.dart';
import 'package:notes_app/features/edit_note/presentation/views/widgets/edit_note_view_body.dart';
import 'package:notes_app/features/edit_note/presentation/views/widgets/floating_edit_note.dart';

class EditNoteView extends StatelessWidget {
  const EditNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const FloatingEditNote(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text("Edit Note",style: AppStyles.stylesSemiBold24,),
      ),
      body: const EditNoteViewBody(),

    );
  }
}
