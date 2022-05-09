import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '/constants/app_colors.dart';
import '/constants/app_constants.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.text,
    required this.press,
    this.backgroundColor = AppColors.kPrimaryColor,
    this.textColor = Colors.white,
    this.disable = true,
    this.width = 327,
    this.height = 48,
  }) : super(key: key);

  final String text;
  final Function press;
  final Color backgroundColor, textColor;
  final bool disable;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.w,
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(disable ? 1 : 0.4),
        borderRadius: BorderRadius.circular(AppConstants.kDefaultBorderRadius),
      ),
      child: text
          .text18(
            fontWeight: FontWeight.bold,
            color: textColor,
          )
          .tr()
          .center(),
    ).inkTap(
      onTap: disable ? () => press() : () {},
      borderRadius: BorderRadius.circular(AppConstants.kDefaultBorderRadius),
    );
  }
}
