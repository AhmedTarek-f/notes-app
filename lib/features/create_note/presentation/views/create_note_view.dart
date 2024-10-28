import 'package:flutter/material.dart';
import 'package:notes_app/core/theme/constants/app_styles.dart';
import 'package:notes_app/features/create_note/presentation/views/widgets/create_note_view_body.dart';
import 'package:notes_app/features/create_note/presentation/views/widgets/floating_create_note.dart';

class CreateNoteView extends StatelessWidget {
  const CreateNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const FloatingCreateNote(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text("Create Note",style: AppStyles.stylesSemiBold24,),
      ),
      body: const CreateNoteViewBody(),

    );
  }
}
