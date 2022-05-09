import 'package:flutter/material.dart';

import '/base/base_state.dart';
import '/constants/constants.dart';
import '/routing/app_routes.dart';
import '/util/extension/extension.dart';
import '../../../util/ui/common_widget/primary_button.dart';

class SplashNavigator extends StatelessWidget {
  const SplashNavigator({
    Key? key,
    required this.press,
    required this.indexPage,
  }) : super(key: key);

  final Function press;
  final int indexPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.imgWalkthroughBottom),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
            AppColors.kSplashColor[indexPage],
            BlendMode.srcATop,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrimaryButton(
            text: StringTranslateExtension(AppStrings.getStarted).tr(),
            press: () => press(),
            textColor: AppColors.kText,
            backgroundColor: Colors.white,
          ),
          SizedBox(height: 22.w),
          AppStrings.logIn
              .text18(fontWeight: FontWeight.bold, color: Colors.white)
              .tr()
              .pad(10, 30)
              .inkTap(
                onTap: () => Get.toNamed(AppRoutes.SIGN_IN),
                borderRadius:
                    BorderRadius.circular(AppConstants.kDefaultBorderRadius.r),
              ),
        ],
      ),
    );
  }
}
