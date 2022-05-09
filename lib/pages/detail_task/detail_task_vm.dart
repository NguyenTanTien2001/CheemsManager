import '/models/comment_model.dart';
import '/models/project_model.dart';

import '/models/meta_user_model.dart';
import '/models/task_model.dart';
import '/base/base_view_model.dart';

class DetailTaskViewModel extends BaseViewModel {
  BehaviorSubject<TaskModel?> bsTask = BehaviorSubject<TaskModel?>();
  BehaviorSubject<List<CommentModel>?> bsComment =
      BehaviorSubject<List<CommentModel>?>();
  BehaviorSubject<bool> bsShowComment = BehaviorSubject<bool>.seeded(true);

  DetailTaskViewModel(ref) : super(ref);

  void loadTask(String taskId) {
    firestoreService.taskStreamById(taskId).listen((event) {
      bsTask.add(event);
    });
  }

  void loadComment(String taskId) {
    firestoreService.commentStream(taskId).listen((event) {
      bsComment.add(event);
    });
  }

  Stream<MetaUserModel> streamUser(String id) {
    return firestoreService.userStreamById(id);
  }

  Stream<ProjectModel> getProject(String id) {
    return firestoreService.projectStreamById(id);
  }

  Future<MetaUserModel> getUser(String id) async {
    return await firestoreService.getUserById(id);
  }

  Future<List<MetaUserModel>> getAllUser(List<String> listId) async {
    List<MetaUserModel> listUser = [];
    for (int i = 0; i < listId.length; i++) {
      listUser.add(await getUser(listId[i]));
    }
    return listUser;
  }

  void completedTask(String id) async {
    startRunning();
    await firestoreService.completedTaskById(id);
    endRunning();
  }

  void setShowComment(bool value) {
    this.bsShowComment.add(value);
  }

  Future<String> newComment(String taskId, CommentModel comment) async {
    startRunning();
    // add comment to database
    String commentID = await firestoreService.addComment(comment, taskId);
    endRunning();
    return commentID;
  }

  Future<void> uploadCommentImage(
      String taskId, String commentId, String filePath) async {
    startRunning();
    await fireStorageService.uploadCommentImage(filePath, taskId, commentId);
    String url = await fireStorageService.loadCommentImage(taskId, commentId);
    firestoreService.updateDescriptionUrlCommentById(taskId, commentId, url);
    endRunning();
  }

  @override
  void dispose() {
    bsTask.close();
    bsShowComment.close();
    bsComment.close();
    super.dispose();
  }
}
