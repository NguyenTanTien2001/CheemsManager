import 'package:flutter/material.dart';

import '/base/base_state.dart';
import '/constants/constants.dart';
import '/pages/welcome/welcome_provider.dart';
import '/pages/welcome/welcome_vm.dart';
import '/routing/app_routes.dart';
import '/util/extension/extension.dart';

class WelcomePage extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return WelcomePage._(watch);
    });
  }

  const WelcomePage._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return WelcomeState();
  }
}

class WelcomeState extends BaseState<WelcomePage, WelcomeViewModel> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await Future.delayed(const Duration(seconds: 2));
    getVm().auth.authStateChange.listen((event) {
      switch (event) {
        case null:
          Get.offAndToNamed(AppRoutes.SPLASH);
          break;
        default:
          Get.offAndToNamed(AppRoutes.HOME);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      color: Colors.white,
      width: screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.imgLogo,
            width: 149.w,
            fit: BoxFit.fitWidth,
          ).pad(0, 0, 0, 12.w),
          AppStrings.CheemsTeam.bold()
              .fSize(48)
              .fShadow(AppConstants.kLogoTextShadow)
              .btr(),
        ],
      ),
    );
  }

  @override
  WelcomeViewModel getVm() => widget.watch(viewModelProvider).state;
}
