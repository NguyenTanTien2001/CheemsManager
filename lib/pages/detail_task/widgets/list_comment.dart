import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import '/constants/constants.dart';
import '/models/meta_user_model.dart';
import '/models/comment_model.dart';
import '/util/extension/extension.dart';

import '/util/ui/common_widget/custom_avatar_loading_image.dart';
import '/util/ui/common_widget/custom_loading_image.dart';

class ListComment extends StatelessWidget {
  const ListComment({
    Key? key,
    required this.data,
    required this.getUser,
  }) : super(key: key);

  final List<CommentModel> data;
  final Future<MetaUserModel> Function(String) getUser;

  @override
  Widget build(BuildContext context) {
    print(DateTime.now());
    return Column(
      children: [
        for (int i = 0; i < data.length; i++)
          buildComment(data[i]).pad(0, 0, 0, 24),
      ],
    ).pad(0, 0, 0, 38);
  }

  Widget buildComment(CommentModel comment) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<MetaUserModel>(
              future: getUser(comment.userId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return AppStrings.somethingWentWrong.text12().tr().center();
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return AppStrings.loading.text12().tr().center();
                }

                MetaUserModel user = snapshot.data!;
                return Row(
                  children: [
                    CustomAvatarLoadingImage(
                      url: user.url ?? '',
                      imageSize: 32,
                    ),
                    SizedBox(width: 11.w),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          user.displayName
                              .plain()
                              .fSize(18)
                              .weight(FontWeight.w500)
                              .lines(1)
                              .overflow(TextOverflow.ellipsis)
                              .b(),
                          Jiffy(DateTime.now())
                              .from(comment.time)
                              .plain()
                              .fSize(14)
                              .b(),
                        ],
                      ),
                    ),
                  ],
                );
              }),
          SizedBox(height: 9.w),
          comment.text
              .plain()
              .fSize(16)
              .lHeight(24)
              .weight(FontWeight.w500)
              .b(),
          if (comment.url != '') SizedBox(height: 9.w),
          if (comment.url != '')
            CustomLoadingImage(
                url: comment.url ?? '', imageSize: screenWidth - 50.w)
        ],
      );
}
