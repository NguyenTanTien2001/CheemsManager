import 'package:firebase_auth/firebase_auth.dart';
import '/models/task_model.dart';
import '/base/base_view_model.dart';
import '/models/quick_note_model.dart';

class ProfileViewModel extends BaseViewModel {
  BehaviorSubject<infoStatus> bsInfoStatus =
      BehaviorSubject.seeded(infoStatus.info);

  BehaviorSubject<List<TaskModel>?> bsListTask =
      BehaviorSubject<List<TaskModel>>();

  BehaviorSubject<List<QuickNoteModel>?> bsListQuickNote =
      BehaviorSubject<List<QuickNoteModel>>();

  ProfileViewModel(ref) : super(ref) {
    if (user != null)
      firestoreService.quickNoteStream(user!.uid).listen((event) {
        bsListQuickNote.add(event);
      });

    firestoreService.taskStream().listen((event) {
      List<TaskModel> listAllData = event;
      List<TaskModel> listData = [];
      for (var task in listAllData) {
        if (task.idAuthor == user!.uid || task.listMember.contains(user!.uid)) {
          listData.add(task);
        }
      }
      listData.sort((a, b) => a.dueDate.compareTo(b.dueDate));
      bsListTask.add(listData);
    });
  }

  void uploadAvatar(String filePath) async {
    await fireStorageService.uploadAvatar(filePath, user!.uid);
    String url = await fireStorageService.loadAvatar(user!.uid);
    user!.updatePhotoURL(url);
    firestoreService.updateUserAvatar(user!.uid, url);
    bsInfoStatus.add(infoStatus.info);
  }

  Stream<User?> getUser() {
    return auth.authStateChange;
  }

  void signOut() {
    auth.signOut();
  }

  void changeInfoStatus(infoStatus status) {
    bsInfoStatus.add(status);
  }

  @override
  void dispose() {
    bsListQuickNote.close();
    bsListTask.close();
    bsInfoStatus.close();
    super.dispose();
  }
}

enum infoStatus { info, setting }
