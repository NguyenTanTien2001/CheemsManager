import 'package:flutter/material.dart';
import 'package:to_do_list/models/quick_note_model.dart';

import '/constants/app_colors.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';

class QuickNoteCard extends StatelessWidget {
  const QuickNoteCard({
    Key? key,
    required this.note,
    required this.color,
    required this.successfulPress,
    required this.checkedPress,
    required this.deletePress,
  }) : super(key: key);

  final QuickNoteModel note;
  final Color color;
  final Function successfulPress, checkedPress, deletePress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      padding: EdgeInsets.only(
        left: 32.w,
        right: 16.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.kBoxShadowColor,
            offset: Offset(5, 9),
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.circular(3.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 121.w,
            height: 3.w,
            color: color,
          ),
          SizedBox(height: 12.w),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    note.content
                        .plain()
                        .fSize(16)
                        .lHeight(30)
                        .weight(FontWeight.w600)
                        .color(
                          note.isSuccessful
                              ? AppColors.kColorNote[2]
                              : AppColors.kText,
                        )
                        .b()
                        .pad(0, 0, 4, 16),
                    for (int i = 0; i < note.listNote.length; i++)
                      buildNote(
                        text: note.listNote[i].text,
                        check: note.listNote[i].check,
                      )
                          .inkTap(
                            onTap: () => checkedPress(note, i),
                            borderRadius: BorderRadius.circular(5.w),
                          )
                          .pad(0, 0, 0, 16),
                    SizedBox(height: 18.w)
                  ],
                ),
              ),
              note.isSuccessful
                  ? Icon(
                      Icons.delete,
                      color: AppColors.kPrimaryColor,
                    ).pad(5).inkTap(
                        onTap: deletePress,
                        borderRadius: BorderRadius.circular(100),
                      )
                  : Icon(
                      Icons.check,
                      color: AppColors.kPrimaryColor,
                    ).pad(5).inkTap(
                        onTap: successfulPress,
                        borderRadius: BorderRadius.circular(100),
                      )
            ],
          ),
        ],
      ),
    ).pad(16, 16, 0, 16);
  }

  Widget buildNote({
    required String text,
    required bool check,
  }) {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.w),
            color: check ? AppColors.kInnerBorder : Colors.white,
            border: Border.all(
              color: AppColors.kInnerBorder,
            ),
          ),
        ).pad(0, 11, 0),
        text
            .plain()
            .fSize(16)
            .lHeight(19.7)
            .decoration(
                check ? TextDecoration.lineThrough : TextDecoration.none)
            .b(),
      ],
    );
  }
}
