import 'package:flutter/cupertino.dart';
import 'package:to_do_list/constants/app_colors.dart';

class AppConstants {
  static const List<BoxShadow> kLogoTextShadow = [
    BoxShadow(
      offset: Offset(0, 4),
      color: AppColors.shadowColor,
      blurRadius: 8,
    ),
    BoxShadow(
      offset: Offset(4, 0),
      color: AppColors.shadowColor,
      blurRadius: 8,
    )
  ];

  static const List<BoxShadow> kFormShadow = [
    BoxShadow(
      offset: Offset(3, 3),
      blurRadius: 9.0,
      color: AppColors.kBoxShadowAddFormColor,
    )
  ];

  static const kAnimationDuration = Duration(milliseconds: 200);
  static const double kDefaultBorderRadius = 5;
  static const kLengthSplash = 3;
  static const kWeekHeader = <String>["M", "T", "W", "T", "F", "S", "S"];
  static const kMonthHeader = <String>[
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  static const List<String> kSplashTitle = [
    'welcome_to_aking',
    'work_happens',
    'tasks_and_assign',
  ];

  static const List<String> kStatisticTitle = [
    'To do Tasks',
    'Quick Notes',
    'Check Lists',
  ];

  static const List<String> kSplashDescription = [
    'whats_going_to_happen_tomorrow?',
    'get_notified_when_work_happens',
    'task_and_assign_them_to_colleagues',
  ];

  static const kBoxShadow = [
    BoxShadow(
      offset: Offset(2, 10),
      color: AppColors.kBoxShadowColor,
      blurRadius: 8.0,
    )
  ];
}
