import 'package:flutter/material.dart';

import '/base/base_state.dart';
import '/constants/strings.dart';
import '/routing/app_routes.dart';
import '/util/extension/extension.dart';
import '/util/ui/common_widget/auth_text_field.dart';
import '/util/ui/common_widget/primary_button.dart';
import '/util/ui/common_widget/sign_in_content.dart';
import 'reset_password_provider.dart';
import 'reset_password_vm.dart';

class ResetPasswordPage extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return ResetPasswordPage._(watch);
    });
  }

  ResetPasswordPage._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return ResetPasswordState();
  }
}

class ResetPasswordState
    extends BaseState<ResetPasswordPage, ResetPasswordViewModel> {
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  String forgotPasswordStatusString = '';
  String code = '';

  final formKey = GlobalKey<FormState>();
  ResetPasswordStatus appStatus = ResetPasswordStatus.pause;

  @override
  void initState() {
    super.initState();
    codeController.text = Get.arguments;
    getVm().bsResetPasswordStatus.listen((status) {
      setState(() {
        appStatus = status;
      });
      switch (appStatus) {
        case ResetPasswordStatus.invalidActionCode:
          setState(() {
            forgotPasswordStatusString = AppStrings.invalidActionCode;
          });
          break;
        case ResetPasswordStatus.expiredActionCode:
          setState(() {
            forgotPasswordStatusString = AppStrings.expiredActionCode;
          });
          break;
        case ResetPasswordStatus.userNotFound:
          setState(() {
            forgotPasswordStatusString = AppStrings.userNotFound;
          });
          break;
        case ResetPasswordStatus.successful:
          Get.offAndToNamed(AppRoutes.SUCCESSFUL);
          break;
        case ResetPasswordStatus.weakPassword:
          setState(() {
            forgotPasswordStatusString = AppStrings.weakPassword;
          });
          break;
        default:
          setState(() {
            forgotPasswordStatusString = '';
          });
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildForm(),
    );
  }

  Widget buildForm() => SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 60.w),
                SignInContent(
                  title: StringTranslateExtension(
                    AppStrings.resetPassword,
                  ).tr(),
                  content: StringTranslateExtension(AppStrings.resetPasswordDes)
                      .tr(),
                ),
                AuthTextField(
                  controller: codeController,
                  label: AppStrings.resetCode,
                  hint: AppStrings.enterYourNumber,
                  validator: (val) => val!.isNotEmpty
                      ? null
                      : StringTranslateExtension(
                          AppStrings.usernameValid,
                        ).tr(),
                  enabled: false,
                ),
                SizedBox(height: 38.w),
                AuthTextField(
                  controller: passwordController,
                  label: AppStrings.newPassword,
                  hint: AppStrings.passwordHint,
                  validator: (val) => val!.length < 6
                      ? StringTranslateExtension(AppStrings.passwordValid).tr()
                      : null,
                  isPassword: true,
                  enabled: appStatus != ResetPasswordStatus.run,
                ),
                SizedBox(height: 38.w),
                AuthTextField(
                  controller: passwordConfirmController,
                  label: AppStrings.confirmPassword,
                  hint: AppStrings.confirmPasswordHint,
                  validator: (val) => val! != passwordController.text
                      ? StringTranslateExtension(
                              AppStrings.confirmPasswordValid)
                          .tr()
                      : null,
                  isPassword: true,
                  enabled: appStatus != ResetPasswordStatus.run,
                ),
                SizedBox(height: 38.w),
                Text(
                  '$forgotPasswordStatusString',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ).tr(),
                SizedBox(height: 20.w),
                PrimaryButton(
                  text: StringTranslateExtension(AppStrings.sendRequest).tr(),
                  press: () async {
                    if (formKey.currentState!.validate()) {
                      getVm().changePassword(
                        codeController.text,
                        passwordController.text,
                      );
                    }
                  },
                  disable: appStatus != ResetPasswordStatus.run,
                ),
              ],
            ),
          ).marg(24.w),
        ),
      );

  AppBar buildAppBar() => ''
      .plainAppBar()
      .backgroundColor(Colors.white)
      .leading(IconButton(
          onPressed: () => Get.offAndToNamed(AppRoutes.SIGN_IN),
          icon: Icon(
            Icons.login,
            color: Colors.black,
          )))
      .bAppBar();

  @override
  ResetPasswordViewModel getVm() => widget.watch(viewModelProvider).state;
}
