import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/constants/constants.dart';
import '/util/ui/common_widget/custom_avatar_loading_image.dart';

import '/constants/app_colors.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key? key,
    required this.user,
    required this.press,
    required this.createTask,
    required this.completedTask,
  }) : super(key: key);

  final User user;

  final int createTask, completedTask;

  final Function press;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAvatarLoadingImage(url: user.photoURL ?? '', imageSize: 64)
                .pad(23, 10, 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  user.displayName
                      .toString()
                      .plain()
                      .fSize(18)
                      .lHeight(21.09)
                      .weight(FontWeight.w600)
                      .lines(1)
                      .overflow(TextOverflow.ellipsis)
                      .b(),
                  user.email
                      .toString()
                      .plain()
                      .fSize(16)
                      .lHeight(19.7)
                      .color(AppColors.kGrayTextB)
                      .lines(1)
                      .overflow(TextOverflow.ellipsis)
                      .b(),
                ],
              ).pad(0, 0, 35),
            ),
            Icon(Icons.settings).pad(10).inkTap(
                  onTap: press,
                  borderRadius: BorderRadius.circular(100),
                ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 120.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  '$createTask'
                      .plain()
                      .fSize(18)
                      .lHeight(21.09)
                      .weight(FontWeight.w300)
                      .b(),
                  AppStrings.createTasks
                      .plain()
                      .fSize(16)
                      .lHeight(19.7)
                      .color(AppColors.kGrayTextA)
                      .b()
                      .tr(),
                ],
              ),
            ),
            Container(
              width: 160.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  '$completedTask'
                      .plain()
                      .fSize(18)
                      .lHeight(21.09)
                      .color(AppColors.kText)
                      .weight(FontWeight.w300)
                      .b(),
                  AppStrings.completedTasks
                      .plain()
                      .fSize(16)
                      .lHeight(19.7)
                      .color(AppColors.kGrayTextA)
                      .b()
                      .tr(),
                ],
              ),
            ),
          ],
        ).pad(27, 27, 0, 29),
      ],
    );
  }
}
