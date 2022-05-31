import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/models/project_model.dart';
import '/util/extension/extension.dart';

import '/constants/constants.dart';

class InForm extends StatelessWidget {
  const InForm(
      {Key? key,
      required this.value,
      required this.listValue,
      required this.press})
      : super(key: key);

  final ProjectModel? value;

  final List<ProjectModel> listValue;

  final Function press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppStrings.in_.bold().fSize(18).b().tr(),
        SizedBox(width: 8.w),
        Container(
          width: 256.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: AppColors.kGrayBack,
            borderRadius: BorderRadius.circular(50.w),
          ),
          child: DropdownButtonFormField<ProjectModel>(
            value: value,
            items: listValue
                .map<DropdownMenuItem<ProjectModel>>(
                  (e) => DropdownMenuItem<ProjectModel>(
                    child: Container(
                      width: 200.w,
                      child: e.name
                          .plain()
                          .fSize(14)
                          .weight(FontWeight.w600)
                          .overflow(TextOverflow.ellipsis)
                          .b(),
                    ),
                    value: e,
                  ),
                )
                .toList(),
            onChanged: (value) => press(value),
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ).pad(16, 16, 0, 10),
        ),
      ],
    );
  }
}
