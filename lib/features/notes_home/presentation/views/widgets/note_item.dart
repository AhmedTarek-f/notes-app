import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/theme/constants/app_styles.dart';
import 'package:notes_app/core/theme/constants/colors.dart';
import 'package:notes_app/features/notes_home/model/note_model.dart';
import 'package:notes_app/features/notes_home/presentation/views_model/notes_home_controller.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({super.key, this.noteBackgroundColor, required this.note});
  final Color? noteBackgroundColor;
  final NoteModel note;
  @override
  Widget build(BuildContext context) {
    final NotesHomeController controller = NotesHomeController.instance;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: noteBackgroundColor ?? (isDarkMode? Colors.grey[850]: Colors.black12),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(note.noteTitle,style: AppStyles.stylesMedium24,),
              const SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.only(right: 60),
                child: Text((note.noteBody?.isEmpty??true)|| (note.noteBody?.trim() == "")? "Empty content..." : note.noteBody!, style: AppStyles.stylesRegular16,maxLines: 4,),
              ),
              const SizedBox(height: 32,),
            ],
          ),
          Positioned(
            top: 18,
            right: 0,
            child: InkWell(
              onTap: () async {
               await buildDeleteNoteDialog(controller);
              },
              borderRadius: BorderRadius.circular(32),
              child: const Padding(
                padding:  EdgeInsets.all(3.0),
                child: Icon(Icons.delete,size: 28,),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Text(note.date ,style: AppStyles.stylesRegular14,),
          )
        ],
      ),
    );
  }

  Future<dynamic> buildDeleteNoteDialog(NotesHomeController controller) {
    return Get.defaultDialog(
     titleStyle: AppStyles.stylesSemiBold18,
     titlePadding: const EdgeInsets.only(top: 16),
     title: "Delete note",
     content: Text("Do you want to delete this note?",style: AppStyles.stylesMedium14,),
     textCancel: "Cancel",
     contentPadding: const EdgeInsets.all(16),
     confirm: ElevatedButton(
       style: ElevatedButton.styleFrom(
           backgroundColor: NoteColors.primaryColor,
           padding: const EdgeInsets.all(8)
       ),
       onPressed: ()async{
         await controller.deleteNote(note: note);
       },
       child: Text("Delete",style: AppStyles.stylesRegular14.copyWith(color: Colors.white),),
     ),
      cancel: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.withOpacity(0.7),
            padding: const EdgeInsets.all(8)
        ),
        onPressed: ()async{
          Get.back();
        },
        child: Text("Cancel",style: AppStyles.stylesRegular14.copyWith(color: Colors.white),),
      ),
   );
  }
}
