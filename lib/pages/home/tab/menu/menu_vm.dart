import '/base/base_view_model.dart';
import '/models/project_model.dart';

class MenuViewModel extends BaseViewModel {
  BehaviorSubject<List<ProjectModel>?> bsProject = BehaviorSubject();

  MenuViewModel(ref) : super(ref) {
    if (user != null)
      firestoreService.projectStream(user!.uid).listen((event) {
        bsProject.add(event);
      });
  }

  void addProject(String name, int indexColor) {
    var temp = new ProjectModel(
      name: name,
      idAuthor: user!.uid,
      indexColor: indexColor,
      timeCreate: DateTime.now(),
      listTask: [],
    );
    firestoreService.addProject(temp);
  }

  void deleteProject(ProjectModel project) {
    firestoreService.deleteProject(project);
    for (var task in project.listTask) {
      firestoreService.deleteTask(task);
    }
  }

  @override
  void dispose() {
    bsProject.close();
    super.dispose();
  }
}
