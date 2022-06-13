import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/constants/constants.dart';
import '/base/base_state.dart';
import '/models/project_model.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';
import 'widgets/add_project_button.dart';
import '../../../../util/ui/common_widget/project_card.dart';
import 'menu_provider.dart';
import 'menu_vm.dart';

class MenuTab extends StatefulWidget {
  final ScopedReader watch;

  final Function pressMode;

  static Widget instance({required Function pressMode}) {
    return Consumer(builder: (context, watch, _) {
      return MenuTab._(watch, pressMode);
    });
  }

  const MenuTab._(this.watch, this.pressMode);

  @override
  State<StatefulWidget> createState() {
    return MenuState();
  }
}

class MenuState extends BaseState<MenuTab, MenuViewModel> {
  bool isToDay = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: StreamBuilder<List<ProjectModel>?>(
        stream: getVm().bsProject,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return AppStrings.somethingWentWrong.text12().tr().center();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return AppStrings.loading.text12().tr().center();
          }

          List<ProjectModel> data = snapshot.data!;

          return Wrap(
            spacing: 12.w,
            runSpacing: 24.w,
            children: [
              SizedBox(
                height: 27.w,
                width: screenWidth,
              ),
              for (int i = 0; i < data.length; i++)
                ProjectCard(
                    project: data[i],
                    press: widget.pressMode,
                    deletePress: (project) async => await showDialog(
                        context: this.context,
                        builder: (_) => CupertinoAlertDialog(
                              title: Text(AppStrings.confirmDelete).tr(),
                              actions: [
                                CupertinoDialogAction(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(AppStrings.no).tr()),
                                CupertinoDialogAction(
                                    onPressed: () => {
                                          getVm().deleteProject(project),
                                          Get.back()
                                        },
                                    child: Text(AppStrings.yes).tr())
                              ],
                            ))),
              AddProjectButton(
                press: getVm().addProject,
              )
            ],
          ).pad(0, 16);
        },
      ),
    );
  }

  AppBar buildAppBar() => StringTranslateExtension(AppStrings.projects)
      .tr()
      .plainAppBar(color: AppColors.kText)
      .backgroundColor(Colors.white)
      .bAppBar();

  @override
  MenuViewModel getVm() => widget.watch(viewModelProvider).state;
}
