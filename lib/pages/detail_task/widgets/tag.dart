import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '/models/project_model.dart';
import '/util/extension/extension.dart';
import '/constants/constants.dart';

class Tag extends StatelessWidget {
  const Tag({Key? key, required this.project}) : super(key: key);

  final ProjectModel project;

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
            AppImages.tagProjectIcon,
          ),
        ),
        SizedBox(width: 23.w),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppStrings.tag
                  .plain()
                  .fSize(16)
                  .color(AppColors.kGrayTextA)
                  .b()
                  .tr(),
              SizedBox(height: 8.w),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  border: Border.all(color: AppColors.kGrayBorderColor),
                ),
                child: project.name
                    .plain()
                    .color(AppColors.kColorNote[project.indexColor])
                    .fSize(16)
                    .b()
                    .pad(8, 12),
              )
            ],
          ),
        )
      ],
    );
  }
}
