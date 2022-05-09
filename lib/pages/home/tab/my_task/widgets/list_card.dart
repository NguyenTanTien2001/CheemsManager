import 'package:flutter/material.dart';
import 'package:to_do_list/models/project_model.dart';
import '../my_task_vm.dart';
import '/models/task_model.dart';

import '/constants/constants.dart';
import '/util/extension/extension.dart';
import '/util/ui/common_widget/task_card.dart';

class ListCard extends StatelessWidget {
  const ListCard(
      {Key? key, required this.data, required this.status, required this.mode})
      : super(key: key);

  final List<TaskModel> data;

  final taskDisplayStatus status;

  final ProjectModel? mode;

  @override
  Widget build(BuildContext context) {
    List<TaskModel> statusData = [];
    for (TaskModel task in data) {
      if (task.completed && status != taskDisplayStatus.incompleteTasks) {
        statusData.add(task);
      }

      if (!task.completed && status != taskDisplayStatus.completedTasks) {
        statusData.add(task);
      }
    }

    List<TaskModel> statusDataAndMode = [];

    if (mode != null) {
      for (TaskModel task in data) {
        if (task.idProject == mode!.id) {
          statusDataAndMode.add(task);
        }
      }
    } else {
      statusDataAndMode = List.from(statusData);
    }

    return Column(
      children: [
        for (int i = 0; i < statusDataAndMode.length; i++)
          if (i == 0 ||
              statusDataAndMode[i - 1].dueDate.year !=
                  statusDataAndMode[i].dueDate.year ||
              statusDataAndMode[i - 1].dueDate.month !=
                  statusDataAndMode[i].dueDate.month ||
              statusDataAndMode[i - 1].dueDate.day !=
                  statusDataAndMode[i].dueDate.day)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                toDateString(statusDataAndMode[i].dueDate)
                    .plain()
                    .color(AppColors.kGrayTextA)
                    .b()
                    .pad(20, 0, 24, 10),
                TaskCard(task: statusDataAndMode[i]),
              ],
            )
          else
            TaskCard(task: statusDataAndMode[i]),
      ],
    );
  }
}
