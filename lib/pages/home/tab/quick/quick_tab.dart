import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '/base/base_state.dart';
import '/constants/app_colors.dart';
import '/routing/app_routes.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';
import 'quick_provider.dart';
import 'quick_vm.dart';

class QuickTab extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return QuickTab._(watch);
    });
  }

  const QuickTab._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return QuickState();
  }
}

class QuickState extends BaseState<QuickTab, QuickViewModel> {
  bool isFullQuickNote = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      appBar: buildAppBar(),
    );
  }

  Widget buildBody() {
    return Container(
      color: AppColors.kWhiteBackground,
      height: screenHeight,
      width: screenWidth,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 32.w),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() => 'Quick Notes'
      .plainAppBar(color: AppColors.kText)
      .backgroundColor(Colors.white)
      .bAppBar();

  @override
  QuickViewModel getVm() => widget.watch(viewModelProvider).state;
}
