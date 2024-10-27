import 'package:flutter/material.dart';
import 'package:notes_app/core/theme/constants/app_styles.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({super.key, this.noteBackgroundColor});
  final Color? noteBackgroundColor;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(32),
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height*0.28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: noteBackgroundColor ?? (isDarkMode? Colors.grey[850]: Colors.black12),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Flutter tips",style: AppStyles.stylesMedium24,),
              const SizedBox(height: 32,),
              Padding(
                padding: const EdgeInsets.only(right: 60),
                child: Text("Build your own carer with ahmed tarek " , style: AppStyles.stylesRegular16,maxLines: 4,),
              ),
            ],
          ),
          Positioned(
            top: 18,
            right: 0,
            child: InkWell(
              onTap: (){},
              borderRadius: BorderRadius.circular(32),
              child: const Padding(
                padding:  EdgeInsets.all(3.0),
                child: Icon(Icons.delete,size: 32,),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Text("May21, 2024",style: AppStyles.stylesRegular14,),
          )
        ],
      ),
    );
  }
}
