
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app/core/theme/constants/app_styles.dart';
import 'package:notes_app/core/theme/constants/colors.dart';
import 'package:notes_app/core/utlis/common_widgets/rounded_container_image.dart';
import 'package:notes_app/core/utlis/images/notes_images.dart';
import 'package:notes_app/core/utlis/loaders/loaders.dart';
import 'package:notes_app/data/repositories/note_repository.dart';
import 'package:notes_app/features/notes_home/model/note_content.dart';
import 'package:notes_app/features/notes_home/model/note_model.dart';
import 'package:notes_app/features/notes_home/presentation/views_model/notes_home_controller.dart';

class EditNoteController extends GetxController
{
  static EditNoteController get instance => Get.find();


  final NotesHomeController notesHomeController =  NotesHomeController.instance;
  final NoteRepository _noteRepository = NoteRepository.instance;
  late final TextEditingController title;
  late final String date;
  late final NoteModel oldNote;
  final GlobalKey<FormState> editNoteFormKey = GlobalKey<FormState>();
  final Rx<AutovalidateMode> autoValidateMode = AutovalidateMode.disabled.obs;
  late final Rx<Color> lightPickerColor;
  late final Rx<Color> darkPickerColor;
  late final RxList<NoteContent> noteContents;
  final RxBool isPickingImageLoading = false.obs;

  @override
  void onInit() {
    oldNote = Get.arguments as NoteModel;
    title = TextEditingController();
    title.text= oldNote.noteTitle;
    date = oldNote.date;
    noteContents = oldNote.noteContents.obs;
    lightPickerColor = oldNote.lightNoteBackgroundColor.obs;
    darkPickerColor = oldNote .darkNoteBackgroundColor.obs;
    super.onInit();
  }
  void applyAutoValidateMode()
  {
    autoValidateMode.value = AutovalidateMode.always;
  }
  void disableAutoValidateMode()
  {
    autoValidateMode.value = AutovalidateMode.disabled;
  }
  Future<void> editNote() async{
    try{
      if(editNoteFormKey.currentState!.validate()) {
        final NoteModel editedNote = NoteModel(
            noteTitle: title.text,
            noteContents: noteContents,
            date: date,
          darkNoteBackgroundColor: darkPickerColor.value,
          lightNoteBackgroundColor: lightPickerColor.value,
        );
        notesHomeController.notesList.add(editedNote);
        await _noteRepository.editNote(oldNote: oldNote,editedNote: editedNote);
        notesHomeController.notesList.remove(oldNote);

        disableAutoValidateMode();
        Loaders.successSnackBar(title: "Note edit",message: "Note has been Edited successfully.");
        Navigator.pop(Get.overlayContext!);
      }
      else{
        applyAutoValidateMode();
      }
    }
    catch(e) {
     Loaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  void changeColors(Color color) {
    darkPickerColor.value = color;
    lightPickerColor.value = color;
  }
  void changeNoteColor(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Get.defaultDialog(
        title: "Pick note color",
        titleStyle: AppStyles.stylesSemiBold14,
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: isDarkMode? darkPickerColor.value :lightPickerColor.value,
            onColorChanged: (value) {
              changeColors(value);
            },
          ),
        ),
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: NoteColors.primaryColor,
            padding: const EdgeInsets.all(8)
        ),
        onPressed: (){
          Get.back();
        },
        child: Text("Pick",style: AppStyles.stylesRegular14.copyWith(color: Colors.white),),
      ),
    );
  }

  Future<void> openImagePicker(BuildContext context) async {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    await Get.bottomSheet(
      Padding(
        padding: EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).height*0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RoundedContainerImage(
              image: NotesImages.galleryIcon,
              onTap: ()async{
                final ImagePicker picker = ImagePicker();
                isPickingImageLoading.value = true;
                final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
                isPickingImageLoading.value = false;
                if (pickedFile != null) {
                  noteContents.add(NoteContent(imagePath: pickedFile.path));
                  noteContents.add(NoteContent(text: ''));
                  Get.back();
                }
              },
            ),
            RoundedContainerImage(
              image: NotesImages.cameraIcon,
              onTap: () async{
                final ImagePicker picker = ImagePicker();
                isPickingImageLoading.value = true;
                final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
                isPickingImageLoading.value = false;
                if (pickedFile != null) {
                  noteContents.add(NoteContent(imagePath: pickedFile.path));
                  noteContents.add(NoteContent(text: ''));
                  Get.back();
                }
              },
            ),
          ],
        ),
      ),
      backgroundColor: isDarkMode? Colors.grey[800]!: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
      isDismissible:  !isPickingImageLoading.value,
    );

  }

  @override
  void onClose() {
    title.dispose();
    super.onClose();
  }
}