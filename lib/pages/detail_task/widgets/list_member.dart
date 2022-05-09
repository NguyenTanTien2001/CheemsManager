import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_list/models/comment_model.dart';
import '/models/meta_user_model.dart';
import '/util/extension/extension.dart';

import '/constants/constants.dart';
import '/util/ui/common_widget/custom_avatar_loading_image.dart';

class ListMember extends StatelessWidget {
  const ListMember({
    Key? key,
    required this.futureListMember,
    required this.streamComment,
    required this.getAllUser,
  }) : super(key: key);

  final Future<List<MetaUserModel>> futureListMember;
  final Stream<List<CommentModel>?> streamComment;
  final Future<MetaUserModel> Function(String) getAllUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<List<MetaUserModel>>(
          future: futureListMember,
          builder: (context, snapshot) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 15.w),
                SizedBox(
                  width: 18,
                  height: 18,
                  child: SvgPicture.asset(
                    AppImages.memberIcon,
                  ),
                ),
                SizedBox(width: 23.w),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppStrings.members
                          .plain()
                          .fSize(16)
                          .color(AppColors.kGrayTextA)
                          .b()
                          .tr(),
                      SizedBox(height: 18.w),
                      if (snapshot.hasError)
                        AppStrings.somethingWentWrong.text12().tr()
                      else if (snapshot.connectionState ==
                          ConnectionState.waiting)
                        AppStrings.loading.text12().tr()
                      else
                        buildListUser(snapshot.data!)
                    ],
                  ),
                )
              ],
            );
          },
        ),
        StreamBuilder<List<CommentModel>?>(
          stream: streamComment,
          builder: (context, snapshotComment) {
            if (snapshotComment.hasError)
              return AppStrings.somethingWentWrong.text12().tr().center();
            if (snapshotComment.connectionState == ConnectionState.waiting)
              return AppStrings.loading.text12().tr().center();
            List<CommentModel> data = snapshotComment.data!;
            return Container();
          },
        ),
      ],
    );
  }

  Widget buildListUser(List<MetaUserModel> list) {
    return Row(
      children: [
        for (int i = 0; i < (list.length > 4 ? 4 : list.length); i++)
          CustomAvatarLoadingImage(
            url: list[i].url ?? '',
            imageSize: 32,
          ).pad(0, 5, 0),
        if (list.length > 4)
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(100),
            ),
            child: '...'
                .plain()
                .color(Colors.white)
                .weight(FontWeight.bold)
                .b()
                .pad(0, 0, 0, 6)
                .center(),
          )
      ],
    );
  }
}
