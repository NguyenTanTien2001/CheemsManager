import 'package:flutter/material.dart';
import 'package:to_do_list/constants/constants.dart';
import 'package:to_do_list/routing/app_routes.dart';
import 'package:to_do_list/util/extension/dimens.dart';
import 'package:to_do_list/util/ui/common_widget/auth_switch.dart';
import 'package:to_do_list/util/ui/common_widget/primary_button.dart';
import 'package:to_do_list/util/ui/common_widget/sign_in_content.dart';

import '/base/base_state.dart';
import '/util/ui/common_widget/auth_text_field.dart';
import 'sign_up_provider.dart';
import 'sign_up_vm.dart';

class SignUpPage extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return SignUpPage._(watch);
    });
  }

  const SignUpPage._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return SignUpState();
  }
}

class SignUpState extends BaseState<SignUpPage, SignUpViewModel> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String signUpStatusString = '';

  Future<void> _checkSignUp() async {
    if (_formKey.currentState!.validate()) {
      getVm().signUp(_emailController.text, _passwordController.text);
    }
  }

  @override
  void initState() {
    super.initState();
    getVm().bsSignUpStatus.listen((value) {
      switch (value) {
        case SignUpStatus.successfulEmail:
          getVm().createData(_emailController.text, _fullNameController.text);
          break;
        case SignUpStatus.successfulData:
          Get.offAndToNamed(AppRoutes.HOME);
          break;
        case SignUpStatus.emailAlreadyInUse:
          setState(() {
            signUpStatusString = '';
          });
          break;
        case SignUpStatus.invalidEmail:
          setState(() {
            // signUpStatusString = AppStrings.i
          });
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: buildForm(),
        ),
      ),
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: StreamBuilder<SignUpStatus>(
        stream: getVm().bsSignUpStatus,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 86.w),
              SignInContent(
                title: StringTranslateExtension(AppStrings.createAccount).tr(),
                content: StringTranslateExtension(AppStrings.signUpDes).tr(),
              ),
              AuthTextField(
                controller: _fullNameController,
                label: StringTranslateExtension(AppStrings.fullName).tr(),
                hint: StringTranslateExtension(AppStrings.fullNameHint).tr(),
                validator: (val) => val!.length < 6
                    ? StringTranslateExtension(AppStrings.fullNameValid).tr()
                    : null,
                enabled: !onRunning,
              ),
              SizedBox(height: 32.w),
              AuthTextField(
                controller: _emailController,
                label: StringTranslateExtension(AppStrings.username).tr(),
                hint: StringTranslateExtension(AppStrings.usernameHint).tr(),
                validator: (val) => val!.isNotEmpty
                    ? null
                    : StringTranslateExtension(AppStrings.usernameValid).tr(),
                enabled: !onRunning,
              ),
              SizedBox(height: 32.w),
              AuthTextField(
                controller: _passwordController,
                label: StringTranslateExtension(AppStrings.password).tr(),
                hint: StringTranslateExtension(AppStrings.passwordHint).tr(),
                validator: (val) => val!.length < 6
                    ? StringTranslateExtension(AppStrings.passwordValid).tr()
                    : null,
                isPassword: true,
                enabled: !onRunning,
              ),
              SizedBox(height: 60),
              Text(
                "$signUpStatusString",
                style: TextStyle(
                  color: Colors.red,
                ),
              ).tr(),
              SizedBox(height: 20),
              PrimaryButton(
                text: StringTranslateExtension(AppStrings.signUp).tr(),
                press: _checkSignUp,
                disable: !onRunning,
              ),
              SizedBox(height: 20),
              AuthSwitch(
                auth: authCase.toSignIn,
              ),
              SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }

  @override
  SignUpViewModel getVm() => widget.watch(viewModelProvider).state;
}
