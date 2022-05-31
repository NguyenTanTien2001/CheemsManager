import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '/util/extension/extension.dart';
import '/constants/constants.dart';

class TitleForm extends StatelessWidget {
  const TitleForm({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66.w,
      color: AppColors.kGrayBack,
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          color: AppColors.kText,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        validator: (val) => val!.isNotEmpty
            ? null
            : StringTranslateExtension(AppStrings.pleaseEnterYourText).tr(),
        decoration: InputDecoration(
          hintText: AppStrings.title.tr(),
          hintStyle: TextStyle(
            color: AppColors.kText80,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
        ),
      ).pad(24, 24, 10, 0),
    );
  }
}
