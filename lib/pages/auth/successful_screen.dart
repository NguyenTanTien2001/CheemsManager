import 'dart:async';

import 'package:flutter/material.dart';
import '/base/base_state.dart';

import '/constants/constants.dart';
import '/routing/app_routes.dart';
import '/util/extension/extension.dart';

class SuccessfulScreen extends StatefulWidget {
  const SuccessfulScreen({Key? key}) : super(key: key);

  @override
  _SuccessfulScreenState createState() => _SuccessfulScreenState();
}

class _SuccessfulScreenState extends State<SuccessfulScreen> {
  @override
  void initState() {
    super.initState();
    initToSingIn();
  }

  initToSingIn() async {
    await Future.delayed(Duration(seconds: 2));
    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: screenWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.imgSuccessful,
              width: 162.w,
              height: 162.w,
            ),
            AppStrings.successful
                .bold()
                .fSize(32)
                .lHeight(41)
                .color(AppColors.kText)
                .b()
                .tr(),
            SizedBox(height: 10.w),
            AppStrings.successfulDes
                .plain()
                .fSize(16)
                .lHeight(19.7)
                .color(AppColors.grayText)
                .center()
                .b()
                .tr(),
          ],
        ),
      ),
    ));
  }
}
