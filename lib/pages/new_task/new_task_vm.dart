import '/models/task_model.dart';

import '/base/base_view_model.dart';
import '/models/project_model.dart';

class NewTaskViewModel extends BaseViewModel {
  BehaviorSubject<List<ProjectModel>?> bsListProject =
      BehaviorSubject<List<ProjectModel>>();

  NewTaskViewModel(ref) : super(ref) {
    // add project data
    if (user != null) {
      firestoreService.projectStream(user!.uid).listen((event) {
        bsListProject.add(event);
      });
    }
  }

  Future<String> newTask(TaskModel task, ProjectModel project) async {
    startRunning();
    // add task to database
    String taskID = await firestoreService.addTask(task);
    // add task to project
    await firestoreService.addTaskProject(project, taskID);
    endRunning();
    return taskID;
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
    bsListProject.close();
    super.dispose();
  }
}
