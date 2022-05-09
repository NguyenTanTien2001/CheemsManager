import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/constants/images.dart';
import '/constants/strings.dart';
import '/util/extension/extension.dart';

class CommentButton extends StatelessWidget {
  const CommentButton(
      {Key? key, required this.showComment, required this.press})
      : super(key: key);

  final bool showComment;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppStrings.comment.plain().weight(FontWeight.bold).fSize(17).b().tr(),
        SizedBox(width: 15.w),
        RotationTransition(
          turns: AlwaysStoppedAnimation((showComment ? 180 : 0) / 360),
          child: SizedBox(
            width: 12.w,
            height: 12.w,
            child: SvgPicture.asset(AppImages.commentIcon),
          ),
        ),
      ],
    ).inkTap(
      onTap: press,
    );
  }
}
