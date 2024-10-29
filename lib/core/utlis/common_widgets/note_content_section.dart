import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/theme/constants/app_styles.dart';
import 'package:notes_app/features/notes_home/model/note_content.dart';

class NoteContentSection extends StatelessWidget {
  const NoteContentSection({
    super.key, required this.noteContents,
  });

  final RxList<NoteContent> noteContents;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark ;
    return Obx(
        ()=> Expanded(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: noteContents.length,
          itemBuilder: (context, index) {
            final item = noteContents[index];
            if (item.text != null && index ==0) {
              if(noteContents.length ==1){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height*0.7,
                    child: TextFormField(
                      initialValue: item.text,
                      onChanged: (value) => item.text = value,
                      decoration: InputDecoration(
                        hintText: index == 0 ? "Content" : null,
                        hintStyle: AppStyles.stylesSemiBold20.copyWith(color:isDarkMode ? Colors.grey[700] : Colors.grey),
                      ),
                      maxLines: null,
                      expands: true,
                    ),
                  ),
                );
              }
              else {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    initialValue: item.text,
                    onChanged: (value) => item.text = value,
                    maxLines: null,
                  ),
                );
              }
            }
            else if (item.text != null) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  initialValue: item.text,
                  onChanged: (value) => item.text = value,
                  maxLines: null,
                ),
              );
            } else if (item.imagePath != null) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Image.file(File(item.imagePath!)),
              );
            }
            else{
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}