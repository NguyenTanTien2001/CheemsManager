
import '/base/base_view_model.dart';
import '/models/task_model.dart';

class MyTaskViewModel extends BaseViewModel {
  BehaviorSubject<bool> bsIsToDay = BehaviorSubject<bool>.seeded(true);
  BehaviorSubject bsIsSelectedDay = BehaviorSubject<DateTime?>.seeded(null);
  BehaviorSubject<taskDisplayStatus> bsTaskDisplayStatus =
      BehaviorSubject<taskDisplayStatus>.seeded(taskDisplayStatus.allTasks);
  BehaviorSubject<List<TaskModel>?> bsListTask =
      BehaviorSubject<List<TaskModel>>();

  // BehaviorSubject<List<ToDoDateModel>> bsToDoDate =
  //     BehaviorSubject<List<ToDoDateModel>>.seeded([]);

  MyTaskViewModel(ref) : super(ref) {
    //initListDate();

    if (user != null) {
      firestoreService.taskStream().listen((event) {
        List<TaskModel> listAllData = event;
        List<TaskModel> listData = [];
        for (var task in listAllData) {
          if (task.idAuthor == user!.uid ||
              task.listMember.contains(user!.uid)) {
            listData.add(task);
            //setTaskDate(task);
          }
        }
        listData.sort((a, b) => a.startDate.compareTo(b.startDate));
        bsListTask.add(listData);
      });
    }
  }

  // void initListDate() {
  //   DateTime startDate = DateTime.now();
  //   DateTime endDate = startDate;
  //
  //   while (DateTime.now().month == startDate.month || startDate.weekday != 1) {
  //     startDate = startDate.subtract(const Duration(days: 1));
  //   }
  //
  //   while (DateTime.now().month == endDate.month || endDate.weekday != 7) {
  //     endDate = endDate.add(const Duration(days: 1));
  //   }
  //
  //   List<ToDoDateModel> list = [];
  //
  //   startDate = startDate.subtract(const Duration(days: 1));
  //   while (startDate != endDate) {
  //     startDate = startDate.add(const Duration(days: 1));
  //     list.add(
  //       new ToDoDateModel(
  //           day: startDate, isMonth: DateTime.now().month == startDate.month),
  //     );
  //   }
  //   bsToDoDate.add(list);
  // }

  // void setTaskDate(TaskModel task) {
  //   List<ToDoDateModel> list = bsToDoDate.value;
  //   for (ToDoDateModel taskDate in list) {
  //     if (task.dueDate.day == taskDate.day.day &&
  //         task.dueDate.month == taskDate.day.month &&
  //         task.dueDate.year == taskDate.day.year) {
  //       taskDate.isTask = true;
  //     }
  //   }
  // }

  setToDay(bool value) {
    bsIsToDay.add(value);
  }

  setSelectedDay(var value) {
    bsIsSelectedDay.add(value);
  }

  setTaskDisplay(taskDisplayStatus status) {
    bsTaskDisplayStatus.add(status);
  }


  List<TaskModel> getTaskListBySelectedDay({DateTime? selectedDay, required List<TaskModel> data}){
    if(selectedDay == null)  return data;

    List<TaskModel> dataTemp = [];
    data.forEach((element) {
      var dayElement = element.startDate;
      if(dayElement.year == selectedDay.year && dayElement.month == selectedDay.month && dayElement.day == selectedDay.day)
        dataTemp.add(element);
    });

    return dataTemp;
  }

  void signOut() {
    auth.signOut();
  }

  @override
  void dispose() {
    bsIsToDay.close();
    bsIsSelectedDay.close();
    bsTaskDisplayStatus.close();
    bsListTask.close();
    super.dispose();
  }
}

enum taskDisplayStatus { incompleteTasks, completedTasks, allTasks }
