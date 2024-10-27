import 'package:flutter/material.dart';
import 'package:notes_app/core/theme/constants/app_styles.dart';
import 'package:notes_app/features/notes_home/presentation/views_model/notes_home_controller.dart';

class NotesHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NotesHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final NotesHomeController controller = NotesHomeController.instance;
    return AppBar(
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 24,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Notes", style: AppStyles.stylesSemiBold24,),
          IconButton(
              onPressed: (){
                controller.isSearchSelected.value = !controller.isSearchSelected.value;
           },
           icon: const Icon(Icons.search,size: 28,),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}