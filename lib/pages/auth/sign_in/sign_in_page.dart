import 'package:flutter/material.dart';

import '/base/base_state.dart';
import '/constants/strings.dart';
import '/routing/app_routes.dart';
import '/util/extension/extension.dart';
import '/util/ui/common_widget/auth_text_field.dart';
import '/util/ui/common_widget/link_forgot_password.dart';
import '/util/ui/common_widget/auth_switch.dart';
import '/util/ui/common_widget/primary_button.dart';
import '/util/ui/common_widget/sign_in_content.dart';
import 'sign_in_provider.dart';
import 'sign_in_vm.dart';

class SignInPage extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return SignInPage._(watch);
    });
  }

  const SignInPage._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return SignInState();
  }
}

class SignInState extends BaseState<SignInPage, SignInViewModel> {
  bool isHidden = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String signInStatusString = '';
  SignInStatus appStatus = SignInStatus.pause;

  final formKey = GlobalKey<FormState>();

  void togglePasswordView() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  Future<void> signInClick() async {
    print(passwordController.text);
    if (formKey.currentState!.validate()) {
      getVm().login(emailController.text, passwordController.text);
    }
  }

  @override
  void initState() {
    super.initState();
    getVm().bsLoginStatus.listen((status) {
      setState(() {
        appStatus = status;
      });
      switch (status) {
        case SignInStatus.networkError:
          setState(() {
            signInStatusString = AppStrings.networkError;
          });
          break;
        case SignInStatus.successful:
          Get.offAndToNamed(AppRoutes.HOME);
          break;
        case SignInStatus.userDisabled:
          setState(() {
            signInStatusString = AppStrings.userDisabled;
          });
          break;
        case SignInStatus.invalidEmail:
          setState(() {
            signInStatusString = AppStrings.invalidEmail;
          });
          break;
        case SignInStatus.userNotFound:
          setState(() {
            signInStatusString = AppStrings.userNotFound;
          });
          break;
        case SignInStatus.wrongPassword:
          setState(() {
            signInStatusString = AppStrings.wrongPassword;
          });
          break;
        default:
          setState(() {
            signInStatusString = '';
          });
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildForm(),
    );
  }

  Widget buildForm() => SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 86.w),
              SignInContent(
                title: StringTranslateExtension(
                  AppStrings.welcomeBack,
                ).tr(),
                content: StringTranslateExtension(AppStrings.signInDes).tr(),
              ),
              AuthTextField(
                controller: emailController,
                label: AppStrings.username,
                hint: AppStrings.usernameHint,
                validator: (val) => val!.isNotEmpty
                    ? null
                    : StringTranslateExtension(
                        AppStrings.usernameValid,
                      ).tr(),
                enabled: !(appStatus == SignInStatus.run),
              ),
              SizedBox(height: 32.w),
              AuthTextField(
                controller: passwordController,
                label: AppStrings.password,
                hint: AppStrings.passwordHint,
                validator: (val) => val!.length < 6
                    ? StringTranslateExtension(AppStrings.passwordValid).tr()
                    : null,
                isPassword: true,
                enabled: !(appStatus == SignInStatus.run),
              ),
              LinkForgotPassword(),
              '$signInStatusString'.text14(color: Colors.red).tr(),
              SizedBox(height: 20.w),
              PrimaryButton(
                text: StringTranslateExtension(AppStrings.logIn).tr(),
                press: signInClick,
                disable: appStatus != SignInStatus.run,
              ),
              AuthSwitch(
                auth: authCase.toSignUp,
              ).pad(20.w, 0),
            ],
          ),
        ),
      ).marg(24.w);

  @override
  SignInViewModel getVm() => widget.watch(viewModelProvider).state;
}
