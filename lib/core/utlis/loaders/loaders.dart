import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/theme/constants/colors.dart';

abstract class Loaders {

  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
          elevation: 0,
          duration:  const Duration(seconds: 3),
          backgroundColor: Colors.transparent,
          content: Container(
            padding:  const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(Get.context!).brightness == Brightness.dark ? Colors.grey[850]!.withOpacity(0.9) : Colors.grey.withOpacity(0.9),
            ),
            child: Center(child: Text(message,style: Theme.of(Get.context!).textTheme.labelLarge,),),
          )
      ),
    );
  }

  static successSnackBar ({required title, message ="",int secondsDuration = 1})
  {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: NoteColors.primaryColor,
      snackPosition: SnackPosition.BOTTOM,
      duration:  Duration(seconds: secondsDuration),
      margin:  const EdgeInsets.all(20),
      icon: const Icon(Icons.warning_amber_outlined,color: Colors.white,),
    );
  }
  static warningSnackBar ({required title, message =""})
  {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Colors.orange,
      snackPosition: SnackPosition.BOTTOM,
      duration:  const Duration(seconds: 3),
      margin:  const EdgeInsets.all(20),
      icon: const Icon(Icons.warning_amber_outlined,color: Colors.white,),
    );
  }
  static errorSnackBar ({required title, message =""})
  {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Colors.red.shade600,
      snackPosition: SnackPosition.BOTTOM,
      duration:  const Duration(seconds: 3),
      margin:  const EdgeInsets.all(20),
      icon: const Icon(Icons.warning_amber_outlined,color: Colors.white,),
    );
  }
}