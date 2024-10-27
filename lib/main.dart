import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notes_app/core/theme/note_app_theme.dart';
import 'package:notes_app/features/notes_home/presentation/views/notes_home_view.dart';

void main()  {
  // final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // await GetStorage.init();
  //
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: NoteAppTheme.lightTheme,
      darkTheme: NoteAppTheme.darkTheme,
      home: const NotesHomeView(),
    );
  }
}

