import '/base/base_view_model.dart';

class ResetPasswordViewModel extends BaseViewModel {
  BehaviorSubject<ResetPasswordStatus> bsResetPasswordStatus =
      BehaviorSubject.seeded(ResetPasswordStatus.pause);

  ResetPasswordViewModel(ref) : super(ref);

  void changePassword(String code, String password) async {
    bsResetPasswordStatus.add(ResetPasswordStatus.run);
    var status = await auth.changePassword(code, password);
    bsResetPasswordStatus.add(status);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

enum ResetPasswordStatus {
  run,
  loading,
  pause,
  invalidActionCode,
  userNotFound,
  userDisabled,
  expiredActionCode,
  weakPassword,
  successful
}
