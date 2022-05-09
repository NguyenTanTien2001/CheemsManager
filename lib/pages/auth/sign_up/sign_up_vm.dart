import '/base/base_view_model.dart';

class SignUpViewModel extends BaseViewModel {
  SignUpViewModel(ref) : super(ref);

  BehaviorSubject<SignUpStatus> bsSignUpStatus =
      BehaviorSubject.seeded(SignUpStatus.pause);

  void signUp(String email, String password) async {
    startRunning();
    bsSignUpStatus.add(SignUpStatus.runEmail);
    var status = await auth.signUp(email, password);
    bsSignUpStatus.add(status);
    endRunning();
  }

  void createData(String email, String name) async {
    startRunning();
    user = auth.currentUser();
    await firestoreService.createUserData(user!.uid, name, email);
    user!.updateDisplayName(name);
    bsSignUpStatus.add(SignUpStatus.successfulData);
    endRunning();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

enum SignUpStatus {
  pause,
  emailAlreadyInUse,
  weakPassword,
  operationNotAllowed,
  invalidEmail,
  runEmail,
  successfulEmail,
  runData,
  successfulData
}
