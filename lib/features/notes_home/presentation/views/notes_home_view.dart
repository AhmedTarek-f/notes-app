import 'package:flutter/material.dart';
import 'package:notes_app/features/notes_home/presentation/views/widgets/floating_add_new_notes.dart';
import 'package:notes_app/features/notes_home/presentation/views/widgets/notes_home_app_bar.dart';
import 'package:notes_app/features/notes_home/presentation/views/widgets/notes_home_view_body.dart';

class NotesHomeView extends StatelessWidget {
  const NotesHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      floatingActionButton: FloatingAddNewNotes(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: NotesHomeAppBar(),
      body:  NotesHomeViewBody(),
    );
  }
}


