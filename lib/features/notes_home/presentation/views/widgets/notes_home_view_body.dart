import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/theme/constants/app_styles.dart';
import 'package:notes_app/core/utlis/images/notes_images.dart';
import 'package:notes_app/core/utlis/loaders/animation_loader.dart';
import 'package:notes_app/features/notes_home/presentation/views/widgets/note_item.dart';
import 'package:notes_app/features/notes_home/presentation/views/widgets/search_field.dart';
import 'package:notes_app/features/notes_home/presentation/views_model/notes_home_controller.dart';

class NotesHomeViewBody extends StatelessWidget {
  const NotesHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final NotesHomeController controller = Get.put(NotesHomeController());
    return Obx(
        (){
          if(controller.notesList.isNotEmpty){
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Obx(
                ()=> Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8,),
                    if(controller.isSearchSelected.value) const SearchField() ,
                    if(controller.isSearchSelected.value && controller.searchFieldController.text.isNotEmpty && controller.searchFieldController.text.trim() != "" && controller.notesSearchList.isEmpty) Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("No Note was found with this note title.",style: AppStyles.stylesMedium14.copyWith(color: Colors.red.shade700),),
                    ),
                    if(controller.isSearchSelected.value) const SizedBox(height: 16,),
                    if(controller.notesSearchList.isEmpty)Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => NoteItem(note: controller.notesList[index]),
                          separatorBuilder: (_, __) => const SizedBox(height: 8,),
                          itemCount: controller.notesList.length,
                      ),
                    ),
                    if(controller.notesSearchList.isNotEmpty)Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => NoteItem(note: controller.notesSearchList[index]),
                        separatorBuilder: (_, __) => const SizedBox(height: 8,),
                        itemCount: controller.notesSearchList.length,
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          else {
            return const AnimationLoader(text: "You haven't add any notes yet!", animation: NotesImages.emptyNotes);
          }
        }
    );
  }
}



