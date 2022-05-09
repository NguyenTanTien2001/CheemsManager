import 'package:flutter/material.dart';

import '/base/base_state.dart';
import '/constants/strings.dart';
import '/util/extension/extension.dart';
import '/util/ui/common_widget/auth_text_field.dart';
import '../../../util/ui/common_widget/primary_button.dart';
import '../../../util/ui/common_widget/sign_in_content.dart';
import '../../../routing/app_routes.dart';
import 'forgot_password_provider.dart';
import 'forgot_password_vm.dart';

class ForgotPasswordPage extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return ForgotPasswordPage._(watch);
    });
  }

  const ForgotPasswordPage._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return ForgotPasswordState();
  }
}

class ForgotPasswordState
    extends BaseState<ForgotPasswordPage, ForgotPasswordViewModel> {
  TextEditingController usernameController = TextEditingController();
  String forgotPasswordStatusString = '';

  final formKey = GlobalKey<FormState>();
  ForgotPasswordStatus appStatus = ForgotPasswordStatus.pause;

  @override
  void initState() {
    super.initState();
    getVm().bsForgotPasswordStatus.listen((status) {
      setState(() {
        appStatus = status;
      });
      switch (appStatus) {
        case ForgotPasswordStatus.invalidEmail:
          setState(() {
            forgotPasswordStatusString = AppStrings.invalidEmail;
          });
          break;
        case ForgotPasswordStatus.userNotFound:
          setState(() {
            forgotPasswordStatusString = AppStrings.userNotFound;
          });
          break;
        case ForgotPasswordStatus.successful:
          Get.offAndToNamed(AppRoutes.SIGN_IN);
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
                    AppStrings.forgotPassword,
                  ).tr(),
                  content:
                      StringTranslateExtension(AppStrings.forgotPasswordDes)
                          .tr(),
                ),
                AuthTextField(
                  controller: usernameController,
                  label: AppStrings.username,
                  hint: AppStrings.usernameHint,
                  validator: (val) => val!.isNotEmpty
                      ? null
                      : StringTranslateExtension(
                          AppStrings.usernameValid,
                        ).tr(),
                  enabled: appStatus != ForgotPasswordStatus.run,
                ),
                SizedBox(height: 32.w),
                Text(
                  '$forgotPasswordStatusString',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 20.w),
                PrimaryButton(
                  text: StringTranslateExtension(AppStrings.sendRequest).tr(),
                  press: () {
                    if (formKey.currentState!.validate()) {
                      getVm().sendRequest(usernameController.text);
                    }
                  },
                  disable: appStatus != ForgotPasswordStatus.run,
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
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          )))
      .bAppBar();

  @override
  ForgotPasswordViewModel getVm() => widget.watch(viewModelProvider).state;
}
