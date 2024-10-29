import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/core/theme/constants/app_styles.dart';
import 'package:notes_app/core/theme/constants/colors.dart';
import 'package:notes_app/core/utlis/common_widgets/rounded_container_image.dart';
import 'package:notes_app/core/utlis/images/notes_images.dart';
import 'package:notes_app/core/utlis/loaders/loaders.dart';
import 'package:notes_app/data/repositories/note_repository.dart';
import 'package:notes_app/features/notes_home/model/note_content.dart';
import 'package:notes_app/features/notes_home/model/note_model.dart';
import 'package:notes_app/features/notes_home/presentation/views_model/notes_home_controller.dart';

class CreateNoteController extends GetxController
{
  static CreateNoteController get instance => Get.find();
  final NotesHomeController notesHomeController =  NotesHomeController.instance;
  final NoteRepository _noteRepository = NoteRepository.instance;
  late final TextEditingController title;
  final String date = DateFormat('MMMM d \'at\' h:mm a').format(DateTime.now()).toString();
  final GlobalKey<FormState> createNoteFormKey = GlobalKey<FormState>();
  final Rx<AutovalidateMode> autoValidateMode = AutovalidateMode.disabled.obs;
  final Rx<Color> lightPickerColor = const Color(0x1F000000).obs;
  final Rx<Color> darkPickerColor = const Color(0xFF212121).obs;
  final RxList<NoteContent> noteContents = <NoteContent>[].obs;
  final RxBool isPickingImageLoading = false.obs;

  @override
  void onInit() {
    title = TextEditingController();
    addInitialTextField();
    super.onInit();
  }

  void addInitialTextField() {
    noteContents.add(NoteContent(text: ''));
  }

  void applyAutoValidateMode()
  {
    autoValidateMode.value = AutovalidateMode.always;
  }
  void disableAutoValidateMode()
  {
    autoValidateMode.value = AutovalidateMode.disabled;
  }
  Future<void> createNote() async{
    try{
      if(createNoteFormKey.currentState!.validate()) {
        final NoteModel note = NoteModel(
            noteTitle: title.text,
            noteContents: noteContents,
            date: date,
          darkNoteBackgroundColor: darkPickerColor.value,
          lightNoteBackgroundColor: lightPickerColor.value,
        );
        await _noteRepository.addNote(note);
        notesHomeController.notesList.add(note);
        disableAutoValidateMode();
        Loaders.successSnackBar(title: "Note creation",message: "Note has been created successfully.");
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
      titleStyle: AppStyles.stylesSemiBold18,
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
      isDismissible: !isPickingImageLoading.value,
    );

  }


  @override
  void onClose() {
    title.dispose();
    super.onClose();
  }
}

