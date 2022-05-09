import 'package:flutter/material.dart';

import '/base/base_state.dart';
import '/constants/constants.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.indexPage,
    required this.press,
    required this.pageController,
  }) : super(key: key);

  final int indexPage;
  final Function press;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 453.h,
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (currentPage) => press(currentPage),
              itemCount: AppConstants.kLengthSplash,
              itemBuilder: (context, index) => buildContent(),
            ),
          ).pad(0, 0, 0, 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              AppConstants.kLengthSplash,
              (index) => buildDot(index: index),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    const double dotSize = 8;
    return AnimatedContainer(
      duration: AppConstants.kAnimationDuration,
      margin: EdgeInsets.only(right: dotSize.w),
      height: dotSize.w,
      width: dotSize.w,
      decoration: BoxDecoration(
        color: index != indexPage ? Colors.black26 : Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget buildContent() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 231.w,
            child: Image.asset(
              AppImages.imgSplash[indexPage],
            ),
          ).pad(0, 0, 0, 53.w),
          AppStrings.splashTitle[indexPage].text24().tr(),
          SizedBox(height: 9.w),
          AppStrings.splashDes[indexPage]
              .text18(
                fontWeight: FontWeight.w400,
              )
              .tr(),
        ],
      ),
    );
  }
}
