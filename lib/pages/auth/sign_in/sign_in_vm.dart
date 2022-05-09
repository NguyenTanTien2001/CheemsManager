import '/base/base_view_model.dart';
import '/providers/auth_provider.dart';

class SignInViewModel extends BaseViewModel {
  SignInViewModel(ref) : super(ref);
  BehaviorSubject<SignInStatus> bsLoginStatus =
      BehaviorSubject.seeded(SignInStatus.pause);

  void init(var ref) async {
    auth = ref.watch(authServicesProvider);
  }

  void login(String email, String password) async {
    bsLoginStatus.add(SignInStatus.run);
    var status = await auth.signIn(email, password);
    bsLoginStatus.add(status);
  }

  @override
  void dispose() {
    bsLoginStatus.close();
    super.dispose();
  }
}

enum SignInStatus {
  pause,
  userNotFound,
  invalidEmail,
  userDisabled,
  wrongPassword,
  networkError,
  run,
  successful
}
