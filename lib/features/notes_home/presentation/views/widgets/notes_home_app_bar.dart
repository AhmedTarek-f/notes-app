import 'package:flutter/material.dart';
import 'package:notes_app/core/theme/constants/app_styles.dart';

class NotesHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NotesHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 24,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Notes", style: AppStyles.stylesSemiBold24,),
          IconButton(onPressed: (){}, icon: const Icon(Icons.search,size: 28,)),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}