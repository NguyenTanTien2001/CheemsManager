import '/base/base_view_model.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  BehaviorSubject<ForgotPasswordStatus> bsForgotPasswordStatus =
      BehaviorSubject.seeded(ForgotPasswordStatus.pause);

  ForgotPasswordViewModel(ref) : super(ref);

  void sendRequest(String email) async {
    bsForgotPasswordStatus.add(ForgotPasswordStatus.run);
    var status = await auth.sendRequest(email);
    bsForgotPasswordStatus.add(status);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

enum ForgotPasswordStatus {
  run,
  loading,
  pause,
  invalidEmail,
  userNotFound,
  userDisabled,
  tooManyRequest,
  successful
}
