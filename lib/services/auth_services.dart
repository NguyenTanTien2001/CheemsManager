import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/constants/app_colors.dart';
import '/pages/auth/forgot_password/forgot_password_vm.dart';
import '/pages/auth/sign_in/sign_in_vm.dart';
import '/pages/auth/sign_up/sign_up_vm.dart';
import '../pages/auth/reset_password/reset_password_vm.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<SignInStatus> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      servicesResultPrint('Sign In Successful');
      return SignInStatus.successful;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          servicesResultPrint('Invalid email');
          return SignInStatus.invalidEmail;
        case 'user-disabled':
          servicesResultPrint('User disabled');
          return SignInStatus.userDisabled;
        case 'user-not-found':
          servicesResultPrint('User not found');
          return SignInStatus.userNotFound;
        case 'wrong-password':
          servicesResultPrint('Wrong password');
          return SignInStatus.wrongPassword;
        default:
          return SignInStatus.wrongPassword;
      }
    }
  }

  Future<SignUpStatus> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      servicesResultPrint('Sign up successful');
      return SignUpStatus.successfulEmail;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          servicesResultPrint('Email already in user');
          return SignUpStatus.emailAlreadyInUse;
        case 'operation-not-allowed':
          servicesResultPrint('Operation not allowed');
          return SignUpStatus.operationNotAllowed;
        case 'invalid-email':
          servicesResultPrint('Invalid email');
          return SignUpStatus.invalidEmail;
        case 'weak-password':
          servicesResultPrint('Weak password');
          return SignUpStatus.weakPassword;
        default:
          return SignUpStatus.weakPassword;
      }
    }
  }

  Future<ForgotPasswordStatus> sendRequest(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(
        email: email,
        actionCodeSettings: ActionCodeSettings(
          url: 'https://CheemsTeams.page.link/ResetPass',
          androidPackageName: 'com.example.to_do_list',
          androidInstallApp: true,
          handleCodeInApp: true,
        ),
      );
      servicesResultPrint('Password reset email sent');
      return ForgotPasswordStatus.successful;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
      switch (e.code) {
        case 'invalid-email':
          servicesResultPrint('Invalid email');
          return ForgotPasswordStatus.invalidEmail;
        case 'user-disabled':
          servicesResultPrint('User disabled');
          return ForgotPasswordStatus.userDisabled;
        case 'user-not-found':
          servicesResultPrint('User not found');
          return ForgotPasswordStatus.userNotFound;
        case 'too-many-requests':
          servicesResultPrint('Too many requests');
          return ForgotPasswordStatus.tooManyRequest;

        default:
          return ForgotPasswordStatus.pause;
      }
    }
  }

  Future<ResetPasswordStatus> changePassword(
      String code, String password) async {
    try {
      await _firebaseAuth.confirmPasswordReset(
          code: code, newPassword: password);
      servicesResultPrint('Reset password successful', isToast: false);
      return ResetPasswordStatus.successful;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case 'invalid-action-code':
          return ResetPasswordStatus.invalidActionCode;
        case 'user-disabled':
          return ResetPasswordStatus.userDisabled;
        case 'user-not-found':
          return ResetPasswordStatus.userNotFound;
        case 'expired-action-code':
          return ResetPasswordStatus.expiredActionCode;
        case 'weak-password':
          return ResetPasswordStatus.weakPassword;
        default:
          return ResetPasswordStatus.pause;
      }
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    servicesResultPrint('Sign out');
  }

  User? currentUser() {
    if (_firebaseAuth.currentUser == null) {
      servicesResultPrint('Current user not found', isToast: false);
      return null;
    }
    servicesResultPrint("Current user: ${_firebaseAuth.currentUser!.uid}",
        isToast: false);
    return _firebaseAuth.currentUser;
  }

  void servicesResultPrint(String result, {bool isToast = true}) async {
    print("FirebaseAuthentication services result: $result");
    if (isToast)
      await Fluttertoast.showToast(
        msg: result,
        timeInSecForIosWeb: 2,
        backgroundColor: AppColors.kWhiteBackground,
        textColor: AppColors.kText,
      );
  }
}
