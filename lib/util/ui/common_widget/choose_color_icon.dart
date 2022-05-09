import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list/constants/app_colors.dart';

import '/constants/images.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';

class ChooseColorIcon extends StatelessWidget {
  const ChooseColorIcon({
    Key? key,
    this.tick = false,
    required this.index,
    required this.press,
  }) : super(key: key);
  final bool tick;
  final int index;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
          color: AppColors.kColorNote[index],
          borderRadius: BorderRadius.circular(5.r)),
      child: SvgPicture.asset(
        AppImages.tickIcon,
        color: Colors.white.withOpacity(tick ? 1 : 0),
      ).center(),
    ).inkTap(
      onTap: () => press(index),
      borderRadius: BorderRadius.circular(5.r),
    );
  }
}
