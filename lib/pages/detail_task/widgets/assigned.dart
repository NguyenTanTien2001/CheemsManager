import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/models/meta_user_model.dart';
import '/util/extension/extension.dart';

import '/constants/constants.dart';
import '/util/ui/common_widget/custom_avatar_loading_image.dart';

class Assigned extends StatelessWidget {
  const Assigned({Key? key, required this.user}) : super(key: key);

  final MetaUserModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomAvatarLoadingImage(url: user.url ?? '', imageSize: 44.w),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppStrings.assignedTo
                .plain()
                .fSize(16)
                .color(AppColors.kGrayTextA)
                .b()
                .tr(),
            user.displayName.plain().fSize(16).color(AppColors.kText).b(),
          ],
        )
      ],
    );
  }
}
