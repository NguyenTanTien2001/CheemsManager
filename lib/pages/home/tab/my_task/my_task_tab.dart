import 'package:flutter/material.dart';
import 'package:to_do_list/models/project_model.dart';
import 'widgets/list_card.dart';
import '/models/to_do_date_model.dart';
import '/util/ui/common_widget/calendar.dart';
import '/constants/constants.dart';

import '/base/base_state.dart';
import '/pages/home/tab/my_task/my_task_vm.dart';
import '/util/extension/widget_extension.dart';
import '/models/task_model.dart';
import 'my_task_provider.dart';
import 'widgets/filter_button.dart';
import 'widgets/to_day_switch.dart';

class MyTaskTab extends StatefulWidget {
  final ScopedReader watch;

  final ProjectModel? mode;
  final Function closeProjectMode;

  static Widget instance(
      {ProjectModel? mode, required Function closeProjectMode}) {
    return Consumer(builder: (context, watch, _) {
      return MyTaskTab._(watch, mode, closeProjectMode);
    });
  }

  const MyTaskTab._(this.watch, this.mode, this.closeProjectMode);

  @override
  State<StatefulWidget> createState() {
    return MyTaskState();
  }
}

class MyTaskState extends BaseState<MyTaskTab, MyTaskViewModel> {
  bool isToDay = true;
  bool isFullMonth = true;
  taskDisplayStatus taskStatus = taskDisplayStatus.allTasks;

  @override
  void initState() {
    super.initState();

    getVm().bsIsToDay.listen((value) {
      setState(() {
        isToDay = value;
      });
    });

    getVm().bsFullMonth.listen((value) {
      setState(() {
        isFullMonth = value;
      });
    });

    getVm().bsTaskDisplayStatus.listen((value) {
      setState(() {
        taskStatus = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      appBar: buildAppBar(),
    );
  }

  Widget buildBody() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildToDaySwitch(),
            if (!this.isToDay) buildMonth(),
            buildListCard(),
          ],
        ),
      ),
    );
  }

  Widget buildMonth() => StreamBuilder<List<ToDoDateModel>>(
      stream: getVm().bsToDoDate,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return AppStrings.somethingWentWrong.text12().tr().center();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return AppStrings.loading.text12().tr().center();
        }

        return Calendar(
          isFullMonth: isFullMonth,
          press: getVm().setFullMonth,
          list: snapshot.data!,
        );
      });

  Widget buildToDaySwitch() => ToDaySwitch(
        isToDay: isToDay,
        press: getVm().setToDay,
        backgroundColor: widget.mode == null
            ? AppColors.kPrimaryColor
            : AppColors.kColorNote[widget.mode!.indexColor],
      );

  Widget buildListCard() => StreamBuilder<List<TaskModel>?>(
        stream: getVm().bsListTask,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return AppStrings.somethingWentWrong.text12().tr().center();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return AppStrings.loading.text12().tr().center();
          }

          List<TaskModel> data = snapshot.data!;

          return ListCard(
            data: data,
            status: taskStatus,
            mode: widget.mode,
          );
        },
      );

  AppBar appBar() => AppBar();

  AppBar buildAppBar() {
    String title = widget.mode == null
        ? StringTranslateExtension(AppStrings.workList).tr()
        : widget.mode!.name;
    return title
        .plainAppBar()
        .leading(
          widget.mode == null
              ? null
              : IconButton(
                  onPressed: () => widget.closeProjectMode(),
                  icon: Icon(Icons.arrow_back_ios),
                ),
        )
        .backgroundColor(
          widget.mode == null
              ? AppColors.kPrimaryColor
              : AppColors.kColorNote[widget.mode!.indexColor],
        )
        .actions(
      [
        FilterButton(
          appBarHeight: appBar().preferredSize.height,
          status: taskStatus,
          press: getVm().setTaskDisplay,
        ),
      ],
    ).bAppBar();
  }

  @override
  MyTaskViewModel getVm() => widget.watch(viewModelProvider).state;
}
