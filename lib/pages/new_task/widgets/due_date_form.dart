import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/util/extension/extension.dart';

import '/constants/constants.dart';

class DueDateForm extends StatelessWidget {
  DueDateForm(
      {Key? key,
      this.valueDate,
      required this.pressDate,
      this.valueTime,
      required this.pressTime})
      : super(key: key);

  final fDate = new DateFormat('dd/MM/yyyy');

  final DateTime? valueDate;

  final TimeOfDay? valueTime;

  final Function pressDate, pressTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.kGrayBack,
      width: screenWidth,
      child: Row(
        children: [
          AppStrings.dueDate.plain().fSize(16).b().tr(),
          SizedBox(width: 8.w),
          Container(
            decoration: BoxDecoration(
              color: AppColors.kSplashColor[1],
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: (valueDate == null
                    ? StringTranslateExtension(AppStrings.anytime).tr()
                    : fDate.format(valueDate!))
                .plain()
                .color(Colors.white)
                .fSize(14)
                .b()
                .pad(7, 14),
          ).inkTap(
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: valueDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2025),
              ).then((date) => pressDate(date));
            },
          ),
          SizedBox(width: 8.w),
          Container(
            decoration: BoxDecoration(
              color: AppColors.kSplashColor[1],
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: (valueTime == null
                    ? StringTranslateExtension(AppStrings.anytime).tr()
                    : timeOfDateFormat(valueTime!))
                .plain()
                .color(Colors.white)
                .fSize(14)
                .b()
                .pad(7, 14),
          ).inkTap(
            onTap: () {
              showTimePicker(
                context: context,
                initialTime: valueTime ?? TimeOfDay.now(),
              ).then((time) => pressTime(time));
            },
          ),
        ],
      ).pad(17, 24),
    );
  }

  String timeOfDateFormat(TimeOfDay timeOfDay) {
    return timeOfDay.hour.toString() + ':' + timeOfDay.minute.toString();
  }
}
