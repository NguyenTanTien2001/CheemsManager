import '/base/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(ref) : super(ref);

  void logOut() {
    auth.signOut();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
