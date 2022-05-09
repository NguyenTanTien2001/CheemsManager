import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '/util/extension/extension.dart';

import '/constants/constants.dart';

class CommentForm extends StatelessWidget {
  const CommentForm({
    Key? key,
    required this.controller,
    required this.pickerImage,
    required this.pressLoadImage,
    required this.pressRemove,
    required this.pressSend,
  }) : super(key: key);

  final TextEditingController controller;

  final XFile? pickerImage;

  final Function pressLoadImage, pressRemove, pressSend;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(
              color: AppColors.kInnerBorderForm,
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 75.w,
                child: TextFormField(
                  validator: (val) => val!.isNotEmpty
                      ? null
                      : AppStrings.pleaseEnterYourText.tr(),
                  // controller: controller,
                  maxLines: 3,
                  controller: controller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppStrings.commentHint.tr()),
                ).pad(0, 10),
              ),
              Container(
                width: screenWidth,
                color: AppColors.kGrayBack50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    pickerImage == null ? buildLoadImageButton() : buildImage(),
                    AppStrings.send
                        .plain()
                        .color(AppColors.kColorNote[0])
                        .fSize(17)
                        .weight(FontWeight.bold)
                        .b()
                        .tr()
                        .inkTap(
                          onTap: () => pressSend(),
                        )
                        .pad(0, 20, 13)
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 36.w),
      ],
    );
  }

  Widget buildImage() => Stack(
        children: [
          Image.file(
            File(pickerImage!.path),
            width: screenWidth * .6,
          ).pad(8),
          Positioned(
            child: IconButton(
              icon: Icon(Icons.close),
              color: Colors.red,
              onPressed: () => pressRemove(),
            ),
          ),
        ],
      );

  Widget buildLoadImageButton() => SizedBox(
        height: 20.w,
        width: 19.w,
        child: SvgPicture.asset(
          AppImages.attachIcon,
          width: 19.w,
          height: 20.w,
        ),
      )
          .inkTap(
            onTap: () => pressLoadImage(),
            borderRadius: BorderRadius.circular(20.r),
          )
          .pad(16, 0, 14, 14);
}
