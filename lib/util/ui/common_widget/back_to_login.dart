import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/constants.dart';
import '/util/extension/extension.dart';
import '/routing/app_routes.dart';

class BackToLogin extends StatefulWidget {
  const BackToLogin({Key? key}) : super(key: key);

  @override
  State<BackToLogin> createState() => _BackToLoginState();
}

class _BackToLoginState extends State<BackToLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        child: Column(
          children: [
            AppStrings.backToLogin.plain().b().tr(),
            IconButton(
              onPressed: () {
                Get.offAndToNamed(AppRoutes.SIGN_IN);
              },
              icon: Icon(Icons.login),
            )
          ],
        ),
      ),
    );
  }
}
