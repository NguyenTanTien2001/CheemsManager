import 'package:to_do_list/models/meta_user_model.dart';

import '/models/task_model.dart';

import '/base/base_view_model.dart';
import '/models/project_model.dart';

class EditTaskViewModel extends BaseViewModel {
  BehaviorSubject<TaskModel?> bsTask = BehaviorSubject<TaskModel?>();
  BehaviorSubject<List<ProjectModel>?> bsListProject =
      BehaviorSubject<List<ProjectModel>>();
  BehaviorSubject<List<MetaUserModel>?> bsListMember =
      BehaviorSubject<List<MetaUserModel>>();

  EditTaskViewModel(ref) : super(ref) {
    // add project data
    if (user != null) {
      firestoreService.projectStream(user!.uid).listen((event) {
        bsListProject.add(event);
      });
    }
  }

  void loadTask(String taskId) {
    firestoreService.taskStreamById(taskId).listen((event) {
      bsTask.add(event);
      List<MetaUserModel> listMem =
          bsListMember.hasValue ? bsListMember.value! : [];
      if (bsTask.value!.listMember.length > 0) {
        for (var mem in bsTask.value!.listMember) {
          firestoreService.userStreamById(mem).listen((event) {
            listMem.add(event);
            print("list mem: $listMem");
            bsListMember.add(listMem);
          });
        }
      } else {
        bsListMember.add(listMem);
      }
    });
  }

  void loadMember(List<String> members) async {
    List<MetaUserModel> listMem = bsListMember.value!;
    for (var mem in members) {
      firestoreService.userStreamById(mem).listen((event) {
        listMem.add(event);
        print(listMem.last);
        bsListMember.add(listMem);
      });
    }
  }

  Future<String> editTask(TaskModel task, ProjectModel oldproject,
      ProjectModel newproject, List<String> oldMemberList) async {
    startRunning();
    // add task to database
    String result = 'failed';
    bool hasUpdateTask = await firestoreService.updateTask(task);
    if (hasUpdateTask) result = 'success';
    // print('old project ' + oldproject.id);
    // print('new project ' + newproject.id);
    if (oldproject.id != newproject.id) {
      await firestoreService.deleteTaskProject(oldproject, task.id);
      await firestoreService.addTaskProject(newproject, task.id);
    }
    await sendNotification(task, oldMemberList, task.listMember);
    endRunning();
    return result;
  }

  Future<bool> sendNotification(
      TaskModel task, List<String> oldMemList, List<String> newMemList) async {
    try {
      if (oldMemList.isEmpty && newMemList.isEmpty) {
        print("no member was add or remove");
        return false;
      }

      List<String> deletedMem = new List.from(oldMemList);
      deletedMem.removeWhere((element) => newMemList.contains(element));

      List<String> addedMem = new List.from(newMemList);
      addedMem.removeWhere((element) => oldMemList.contains(element));

      List<String> remainMem = new List.from(oldMemList);
      remainMem.removeWhere((element) => !newMemList.contains(element));
      print("old members: ${oldMemList}");
      print("new members: ${newMemList}");
      print("delete members: ${deletedMem}");
      print("added members: ${addedMem}");
      print("remain members: ${remainMem}");
      for (var mem in deletedMem) {
        firestoreService.getUserById(mem).then((user) async => {
              if (user.token != null)
                await firestoreMessagingService.sendPushMessaging(
                    user.token!,
                    "YOU HAS BEEN KICK",
                    "you has been remove from task ${task.title}")
            });
      }
      for (var mem in addedMem) {
        firestoreService.getUserById(mem).then((user) async => {
              if (user.token != null)
                await firestoreMessagingService.sendPushMessaging(user.token!,
                    "JOIN TASK", "you has been add to task ${task.title}")
            });
      }
      for (var mem in remainMem) {
        firestoreService.getUserById(mem).then((user) async => {
              if (user.token != null)
                await firestoreMessagingService.sendPushMessaging(
                    user.token!,
                    "TASK MEMBER CHANGE",
                    "members of task ${task.title} has been change")
            });
      }
      print("notification has been sended to all member");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> uploadDesTask(String taskId, String filePath) async {
    startRunning();
    await fireStorageService.uploadTaskImage(filePath, taskId);
    String url = await fireStorageService.loadTaskImage(taskId);
    firestoreService.updateDescriptionUrlTaskById(taskId, url);
    endRunning();
  }

  @override
  void dispose() {
    bsTask.close();
    bsListProject.close();
    bsListMember.close();
    super.dispose();
  }
}
