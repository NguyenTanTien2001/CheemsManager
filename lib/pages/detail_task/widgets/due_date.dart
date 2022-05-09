import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/util/extension/extension.dart';

import '/constants/constants.dart';

class DueDate extends StatelessWidget {
  const DueDate({Key? key, required this.dueDate}) : super(key: key);

  final DateTime dueDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 15.w),
        SizedBox(
          width: 18,
          height: 18,
          child: SvgPicture.asset(
            AppImages.dueDateIcon,
          ),
        ),
        SizedBox(width: 23.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppStrings.dueDate
                .plain()
                .fSize(16)
                .color(AppColors.kGrayTextA)
                .b()
                .tr(),
            toDateString(dueDate, isUpCase: false).plain().fSize(16).b(),
          ],
        )
      ],
    );
  }
}
