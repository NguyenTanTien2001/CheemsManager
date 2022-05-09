import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list/base/base_state.dart';
import 'package:to_do_list/pages/home/tab/my_task/my_task_vm.dart';
import 'package:to_do_list/util/extension/extension.dart';
import '/constants/constants.dart';

class FilterButton extends StatelessWidget {
  const FilterButton(
      {Key? key,
      required this.appBarHeight,
      required this.status,
      required this.press})
      : super(key: key);

  final double appBarHeight;

  final taskDisplayStatus status;

  final Function press;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async => await showFilterDialog(context),
      icon: SvgPicture.asset(AppImages.filterIcon),
    );
  }

  Future<void> showFilterDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        return Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 228.w,
            height: 132.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Column(
              children: [
                buildItem(taskDisplayStatus.completedTasks,
                    AppStrings.completedTasks),
                buildItem(taskDisplayStatus.incompleteTasks,
                    AppStrings.incompleteTasks),
                buildItem(taskDisplayStatus.allTasks, AppStrings.allTasks),
              ],
            ),
          ),
        ).pad(0, 14, appBarHeight, 0);
      });

  Widget buildItem(taskDisplayStatus _status, String text) => Container(
        height: 44.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: text.plain().fSize(17).lines(1).b().tr(),
            ),
            _status == status
                ? Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                : SizedBox(),
          ],
        ),
      ).pad(0, 16).inkTap(
            onTap: () {
              press(_status);
              Get.back();
            },
            borderRadius: BorderRadius.circular(5.r),
          );
}
