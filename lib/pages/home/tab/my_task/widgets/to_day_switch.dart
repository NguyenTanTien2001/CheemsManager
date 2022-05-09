import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/constants/constants.dart';
import '/util/extension/dimens.dart';

import '/util/extension/widget_extension.dart';

class ToDaySwitch extends StatelessWidget {
  const ToDaySwitch({
    Key? key,
    this.isToDay = true,
    required this.press,
    required this.backgroundColor,
  }) : super(key: key);

  final bool isToDay;
  final Function press;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Row(
        children: [
          buildItem(text: AppStrings.today.tr(), isChoose: isToDay)
              .inkTap(onTap: () => press(true)),
          buildItem(text: AppStrings.month.tr(), isChoose: !isToDay)
              .inkTap(onTap: () => press(false)),
        ],
      ),
    );
  }

  Container buildItem({
    required String text,
    required bool isChoose,
  }) {
    return Container(
      width: screenWidth * .5,
      child: Column(
        children: [
          text
              .plain()
              .fSize(18)
              .color(Colors.white.withOpacity(isChoose ? 1 : .5))
              .weight(FontWeight.bold)
              .b()
              .pad(0, 0, 17, 14),
          Container(
            width: screenWidth * .256,
            height: 3,
            color: isChoose ? Colors.white : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
