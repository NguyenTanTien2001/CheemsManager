import 'package:flutter/material.dart';
import '/util/extension/extension.dart';

import '/models/meta_user_model.dart';
import 'custom_avatar_loading_image.dart';

class SelectUserItem extends StatelessWidget {
  const SelectUserItem({
    Key? key,
    required this.userModel,
    required this.checked,
    required this.press,
  }) : super(key: key);

  final MetaUserModel userModel;
  final bool checked;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => press(),
          icon: Icon(
            checked ? Icons.check_box : Icons.check_box_outline_blank,
          ),
          iconSize: 30,
        ),
        CustomAvatarLoadingImage(
          url: userModel.url ?? '',
          imageSize: 40,
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            userModel.displayName.text14(),
            userModel.email.text12(),
          ],
        ),
      ],
    ).pad(5, 10);
  }
}
