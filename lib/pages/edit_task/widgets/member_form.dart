import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import '/models/meta_user_model.dart';
import '/util/ui/common_widget/custom_avatar_loading_image.dart';
import '/util/extension/extension.dart';

import '/constants/constants.dart';

class MemberForm extends StatelessWidget {
  const MemberForm({
    Key? key,
    required this.listUser,
    required this.press,
  }) : super(key: key);

  final List<MetaUserModel> listUser;

  final Function press;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppStrings.addMember
                .plain()
                .weight(FontWeight.w600)
                .fSize(16)
                .b()
                .tr(),
            IconButton(
              onPressed: () => press(),
              icon: Icon(Icons.arrow_forward_ios),
            )
          ],
        ),
        if (listUser.length == 0)
          Container(
            decoration: BoxDecoration(
              color: AppColors.kGrayBack,
              borderRadius: BorderRadius.circular(50),
            ),
            child: AppStrings.anyone.text14().pad(14, 20),
          ),
        Wrap(
          children: [
            for (int i = 0; i < listUser.length; i++)
              if (listUser[i].url != null)
                CustomAvatarLoadingImage(
                  url: listUser[i].url ?? '',
                  imageSize: 32,
                ).pad(0, 5, 0),
          ],
        ),
      ],
    ).pad(0, 16);
  }
}
