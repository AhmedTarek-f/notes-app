import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/utlis/images/notes_images.dart';
import 'package:notes_app/core/utlis/loaders/animation_loader.dart';
import 'package:notes_app/features/notes_home/presentation/views/widgets/note_item.dart';
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
              padding: EdgeInsets.only(right:16 , left: 16, bottom: MediaQuery.sizeOf(context).height*0.073),
              child: Column(
                children: [
                  const SizedBox(height: 8,),
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => NoteItem(note: controller.notesList[index]),
                        separatorBuilder: (_, __) => const SizedBox(height: 8,),
                        itemCount: controller.notesList.length,
                    ),
                  ),
                ],
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

