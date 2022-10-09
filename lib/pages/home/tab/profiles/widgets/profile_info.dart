import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_list/base/base_state.dart';
import 'package:to_do_list/constants/constants.dart';
import '/util/ui/common_widget/custom_avatar_loading_image.dart';

import '/constants/app_colors.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo(
      {Key? key,
      required this.user,
      required this.press,
      required this.createTask,
      required this.completedTask,
      required this.pressToProfile,
      required this.pressSignOut,
      required this.pressUploadAvatar})
      : super(key: key);

  final User user;

  final int createTask, completedTask;

  final Function press, pressToProfile, pressSignOut, pressUploadAvatar;
  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  final ImagePicker _picker = ImagePicker();

  void takePhoto(ImageSource source) async {
    final pickerFile = await _picker.pickImage(source: source);

    if (pickerFile != null) {
      widget.pressUploadAvatar(pickerFile.path);
    }
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAvatarLoadingImage(
                    url: widget.user.photoURL ?? '', imageSize: 64)
                .pad(23, 10, 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.user.displayName
                      .toString()
                      .plain()
                      .fSize(18)
                      .lHeight(21.09)
                      .weight(FontWeight.w600)
                      .lines(1)
                      .overflow(TextOverflow.ellipsis)
                      .b(),
                  widget.user.email
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
            buildSignOut().pad(0, 35, 25),
          ],
        ),
        buildChangeAvatar(),
        buildLanguage(),
      ],
    );
  }

  Widget buildLanguage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppStrings.Language.plain()
                .fSize(18)
                .weight(FontWeight.w600)
                .b()
                .tr()
                .pad(15, 0, 10),
          ],
        ),
        SizedBox(height: 5.w),
        Row(
          children: [
            'Vietnamese'
                .plain()
                .fSize(14)
                .color(AppColors.grayText)
                .weight(FontWeight.w400)
                .b()
                .pad(2, 5)
                .inkTap(
                  onTap: () async {
                    await context.setLocale(Locale('vi', 'VN'));
                    Get.updateLocale(Locale('vi', 'VN'));
                  },
                  borderRadius: BorderRadius.circular(5),
                ),
            SizedBox(width: 20.w),
            'English'
                .plain()
                .fSize(14)
                .weight(FontWeight.w500)
                .b()
                .pad(2, 5)
                .inkTap(
                  onTap: () async {
                    await context.setLocale(Locale('en', 'US'));
                    Get.updateLocale(Locale('en', 'US'));
                  },
                  borderRadius: BorderRadius.circular(5),
                ),
          ],
        ).pad(10, 0, 0),
      ],
    );
  }

  Widget buildChangeAvatar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppStrings.ChangeAvatar.plain()
            .fSize(18)
            .weight(FontWeight.w600)
            .b()
            .tr()
            .pad(15, 0, 10),
        SizedBox(height: 5.w),
        Row(
          children: [
            Row(
              children: [
                Icon(Icons.image),
                'Gallery'
                    .plain()
                    .fSize(14)
                    .weight(FontWeight.w500)
                    .b()
                    .pad(2, 5)
              ],
            ).inkTap(
              onTap: () {
                takePhoto(ImageSource.gallery);
              },
              borderRadius: BorderRadius.circular(5),
            ),
            SizedBox(width: 20.w),
            Row(
              children: [
                Icon(Icons.camera_alt),
                'Camera'.plain().fSize(14).weight(FontWeight.w500).b().pad(2, 5)
              ],
            ).inkTap(
              onTap: () {
                takePhoto(ImageSource.camera);
              },
              borderRadius: BorderRadius.circular(5),
            ),
          ],
        ).pad(15, 0, 0),
      ],
    );
  }

  Widget buildSignOut() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.logout_outlined,
          size: 30,
        ).pad(0, 0, 0),
        //'Sign Out'.plain().fSize(18).weight(FontWeight.w600).b(),
      ],
    ).pad(15, 0, 10, 10).inkTap(
          onTap: widget.pressSignOut,
          borderRadius: BorderRadius.circular(10),
        );
  }
}
