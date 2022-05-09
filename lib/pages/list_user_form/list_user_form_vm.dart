import '/models/meta_user_model.dart';
import '/base/base_view_model.dart';

class ListUserFormViewModel extends BaseViewModel {
  // ignore: close_sinks
  BehaviorSubject<List<MetaUserModel>?> bsListUser =
      BehaviorSubject<List<MetaUserModel>>();
  BehaviorSubject<List<MetaUserModel>> bsSelectListUser =
      BehaviorSubject<List<MetaUserModel>>.seeded([]);

  ListUserFormViewModel(ref) : super(ref) {
    bsSelectListUser.add([]);
    if (user != null)
      firestoreService.userStream(user!.email!).listen((event) {
        bsListUser.add(event);
      });
  }

  void checkClick(MetaUserModel value) {
    List<MetaUserModel> list = List.from(bsSelectListUser.value);

    if (list.contains(value)) {
      list.remove(value);
    } else {
      list.add(value);
    }
    bsSelectListUser.add(list);
  }

  void initSelect(List<MetaUserModel> list) {
    bsSelectListUser.add(list);
  }

  @override
  void dispose() {
    bsListUser.close();
    bsSelectListUser.close();
    super.dispose();
  }
}
