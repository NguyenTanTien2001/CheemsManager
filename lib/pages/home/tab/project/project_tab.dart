import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/base/base_state.dart';
import '/constants/constants.dart';
import '/models/project_model.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';
import '../../../../util/ui/common_widget/project_card.dart';
import 'project_provider.dart';
import 'project_vm.dart';
import 'widgets/add_project_button.dart';

class ProjectTab extends StatefulWidget {
  final ScopedReader watch;

  final Function pressMode;
  final ProjectModel? mode;

  static Widget instance({ProjectModel? mode, required Function pressMode}) {
    return Consumer(builder: (context, watch, _) {
      return ProjectTab._(watch, mode, pressMode);
    });
  }

  const ProjectTab._(this.watch, this.mode, this.pressMode);

  @override
  State<StatefulWidget> createState() {
    return ProjectState();
  }
}

class ProjectState extends BaseState<ProjectTab, ProjectViewModel> {
  bool isToDay = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      appBar: buildAppBar(),
      backgroundColor: AppColors.kPrimaryBackground,
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
      .plainAppBar(
          color: Colors.black)
      .backgroundColor(AppColors.kPrimaryBackground)
      .bAppBar();

  @override
  ProjectViewModel getVm() => widget.watch(viewModelProvider).state;
}
