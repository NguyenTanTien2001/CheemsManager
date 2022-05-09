import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/util/ui/common_widget/custom_loading_image.dart';
import '/util/extension/extension.dart';

import '/constants/constants.dart';

class Description extends StatelessWidget {
  const Description({Key? key, required this.des, required this.url})
      : super(key: key);

  final String des;

  final String url;

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
            AppImages.descriptionIcon,
          ),
        ),
        SizedBox(width: 23.w),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppStrings.description
                  .plain()
                  .fSize(16)
                  .color(AppColors.kGrayTextA)
                  .b()
                  .tr(),
              des
                  .plain()
                  .fSize(16)
                  .overflow(TextOverflow.ellipsis)
                  .lines(3)
                  .b(),
              if (url != '')
                CustomLoadingImage(url: url, imageSize: screenWidth * .6)
            ],
          ),
        )
      ],
    );
  }
}
