import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/constants/constants.dart';
import '/routing/app_routes.dart';
import '/util/extension/extension.dart';

enum authCase { toSignIn, toSignUp }

class AuthSwitch extends StatelessWidget {
  const AuthSwitch({
    Key? key,
    required this.auth,
  }) : super(key: key);

  final authCase auth;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (auth == authCase.toSignIn
                ? AppStrings.alreadyHaveAnAccount
                : AppStrings.doNotHaveAnAccount)
            .plain()
            .fSize(15)
            .b()
            .tr(),
        SizedBox(width: 3.w),
        (auth == authCase.toSignIn ? AppStrings.signIn : AppStrings.signUp)
            .plain()
            .fSize(15)
            .weight(FontWeight.bold)
            .color(AppColors.kPrimaryColor)
            .b()
            .tr()
            .inkTap(
          onTap: () {
            Get.offAndToNamed(
              auth == authCase.toSignIn ? AppRoutes.SIGN_IN : AppRoutes.SIGN_UP,
            );
          },
        ),
      ],
    );
  }
}
