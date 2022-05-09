import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/models/to_do_date_model.dart';
import '/util/extension/extension.dart';

import '/constants/constants.dart';

class Calendar extends StatelessWidget {
  const Calendar(
      {Key? key,
      this.isFullMonth = true,
      required this.press,
      required this.list})
      : super(key: key);

  final bool isFullMonth;
  final Function press;
  final List<ToDoDateModel> list;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 10,
            color: AppColors.kBoxShadowMonth,
          )
        ],
      ),
      child: Column(
        children: [
          buildTitle(),
          buildHeader(),
          SizedBox(height: 13.w),
          isFullMonth ? buildMonth() : buildWeek(),
          SizedBox(height: isFullMonth ? 22.w.w : 5.w),
        ],
      ),
    );
  }

  Widget buildTitle() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (AppStrings.kMonthHeader[DateTime.now().month - 1].tr() +
                  ' ' +
                  DateTime.now().year.toString())
              .plain()
              .weight(FontWeight.bold)
              .fSize(14)
              .b()
              .pad(16, 0),
          IconButton(
            onPressed: () => press(!isFullMonth),
            icon: Icon(
              !isFullMonth
                  ? Icons.keyboard_arrow_down_rounded
                  : Icons.keyboard_arrow_up_rounded,
            ),
          )
        ],
      );

  Widget buildHeader() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < AppConstants.kWeekHeader.length; i++)
            SizedBox(
              width: 20.w,
              child: AppConstants.kWeekHeader[i].plain().b().center(),
            )
        ],
      );

  Widget buildWeek() {
    DateTime now = DateTime.now();
    int indexNow = 0;
    for (int i = 0; i < list.length; i++) {
      if (now.day == list[i].day.day &&
          now.month == list[i].day.month &&
          now.year == list[i].day.year) {
        indexNow = i;
        break;
      }
    }

    int indexStart = indexNow ~/ 7 * 7;
    int indexEnd = (indexNow ~/ 7 + 1) * 7;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        for (int i = indexStart; i < indexEnd; i++) buildDateItem(list[i]),
      ],
    );
  }

  Widget buildMonth() {
    return Column(
      children: [
        for (int i = 0; i < list.length / 7; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int j = i * 7; j < i * 7 + 7; j++) buildDateItem(list[j]),
            ],
          )
      ],
    );
  }

  Widget buildDateItem(ToDoDateModel toDoDateModel) => SizedBox(
        width: 20.w,
        child: Column(
          children: [
            toDoDateModel.day.day
                .toString()
                .plain()
                .color(toDoDateModel.isMonth
                    ? AppColors.kText
                    : AppColors.kGrayTextC)
                .fSize(14)
                .b()
                .center(),
            SizedBox(height: 11.w),
            Container(
              width: 5.w,
              height: 5.w,
              decoration: BoxDecoration(
                color: toDoDateModel.isTask
                    ? AppColors.kPrimaryColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(5.r),
              ),
            ),
            SizedBox(height: 12.w),
          ],
        ),
      );
}
