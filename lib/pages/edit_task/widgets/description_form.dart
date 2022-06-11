import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '/util/extension/extension.dart';
import '/constants/constants.dart';

class DescriptionForm extends StatelessWidget {
  const DescriptionForm({
    Key? key,
    required this.controller,
    this.pickerImage,
    required this.press,
    required this.pressRemove,
  }) : super(key: key);

  final TextEditingController controller;

  final XFile? pickerImage;

  final Function press, pressRemove;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppStrings.description
            .plain()
            .color(AppColors.kGrayTextC)
            .fSize(16)
            .b()
            .tr(),
        SizedBox(height: 12.w),
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
                      : StringTranslateExtension(AppStrings.pleaseEnterYourText)
                          .tr(),
                  controller: controller,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ).pad(0, 10),
              ),
              Container(
                width: screenWidth,
                color: AppColors.kGrayBack50,
                child: Row(
                  children: [
                    pickerImage == null ? buildLoadImageButton() : buildImage()
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ).pad(0, 24);
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
            onTap: () => press(),
            borderRadius: BorderRadius.circular(20.r),
          )
          .pad(16, 0, 14, 14);
}
