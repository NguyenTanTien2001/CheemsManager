import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '/models/task_model.dart';
import 'widgets/due_date_form.dart';
import 'widgets/member_form.dart';
import 'widgets/description_form.dart';
import 'widgets/title_form.dart';
import '/routing/app_routes.dart';
import '/models/meta_user_model.dart';
import '/models/project_model.dart';
import '/base/base_state.dart';
import '/constants/constants.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';
import '/util/ui/common_widget/primary_button.dart';
import 'edit_task_provider.dart';
import 'edit_task_vm.dart';
import 'widgets/in_form.dart';

class EditTaskPage extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return EditTaskPage._(watch);
    });
  }

  const EditTaskPage._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return EditTaskState();
  }
}

class EditTaskState extends BaseState<EditTaskPage, EditTaskViewModel> {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<MetaUserModel>? selectUsers = null;

  ProjectModel? oldProject = null;
  List<String>? oldMemberList;
  ProjectModel? dropValue;
  DateTime? dueDateValue;
  TimeOfDay? dueTimeValue;
  final f = new DateFormat('dd/MM/yyyy');

  final ImagePicker _picker = ImagePicker();

  XFile? pickerFile;

  void getPhoto() async {
    pickerFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  void removePhoto() {
    pickerFile = null;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getVm().loadTask(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            width: screenWidth,
            height: 44.w,
            child: Container(color: AppColors.kPrimaryColor_yellow),
          ),
          buildForm(),
        ],
      ),
    );
  }

  Widget buildForm() => Positioned(
        top: 10,
        left: 0,
        width: screenWidth,
        height: screenHeight - buildAppBar().preferredSize.height - 100,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.r),
            boxShadow: AppConstants.kFormShadow,
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: StreamBuilder<TaskModel?>(
                  stream: getVm().bsTask,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return AppStrings.somethingWentWrong
                          .text12()
                          .tr()
                          .center();
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return AppStrings.loading.text12().tr().center();
                    }
                    TaskModel task = snapshot.data!;
                    titleController.text = task.title;
                    descriptionController.text = task.description;
                    dueDateValue = task.dueDate;
                    dueTimeValue = TimeOfDay.fromDateTime(task.dueDate);
                    oldMemberList = task.listMember;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 32.w),
                        buildInForm(task),
                        SizedBox(height: 24.w),
                        buildTitleForm(task),
                        SizedBox(height: 16.w),
                        buildDesForm(task),
                        SizedBox(height: 24.w),
                        buildDueDateForm(task),
                        SizedBox(height: 24.w),
                        buildMemberForm(task),
                        SizedBox(height: 24.w),
                        buildDoneButton(task),
                        SizedBox(height: 30.w),
                      ],
                    );
                  }),
            ),
          ),
        ).pad(0, 16),
      );

  void setValueInForm(ProjectModel? value) {
    setState(() {
      dropValue = value;
    });
  }

  Widget buildInForm(TaskModel task) {
    return StreamBuilder<List<ProjectModel>?>(
      stream: getVm().bsListProject,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return AppStrings.somethingWentWrong.text12().tr().center();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return AppStrings.loading.text12().tr().center();
        }

        List<ProjectModel> data = snapshot.data!;
        if (this.oldProject == null) {
          var taskdropValue =
              data.where((element) => element.id == task.idProject);
          if (taskdropValue.length > 0) {
            this.dropValue = taskdropValue.first;
            this.oldProject = taskdropValue.first;
          }
        }
        return InForm(
          value: dropValue,
          listValue: data,
          press: setValueInForm,
        );
      },
    );
  }

  Widget buildTitleForm(TaskModel task) {
    return TitleForm(controller: titleController);
  }

  Widget buildDesForm(TaskModel task) {
    return DescriptionForm(
      controller: descriptionController,
      pickerImage: pickerFile,
      press: getPhoto,
      pressRemove: removePhoto,
    );
  }

  void setValueDate(DateTime? date) {
    setState(() {
      dueDateValue = date;
    });
  }

  void setValueTime(TimeOfDay? time) {
    setState(() {
      dueTimeValue = time;
    });
  }

  Widget buildDueDateForm(TaskModel task) {
    return DueDateForm(
      valueDate: dueDateValue,
      valueTime: dueTimeValue,
      pressDate: setValueDate,
      pressTime: setValueTime,
    );
  }

  void selectListUser() {
    Get.toNamed(
      AppRoutes.LIST_USER_FORM,
      arguments: selectUsers,
    )?.then((value) {
      setState(() {
        this.selectUsers = value;
      });
    });
  }

  Widget buildMemberForm(TaskModel task) {
    return StreamBuilder<List<MetaUserModel>?>(
      stream: getVm().bsListMember,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return AppStrings.somethingWentWrong.text12().tr().center();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return AppStrings.loading.text12().tr().center();
        }

        List<MetaUserModel> data = snapshot.data!;
        if (selectUsers == null) selectUsers = data;
        return MemberForm(listUser: selectUsers!, press: selectListUser);
      },
    );
  }

  void editTaskClick(TaskModel oldtask) async {
    List<String> list = [];

    for (var user in selectUsers!) {
      list.add(user.uid);
    }

    if (formKey.currentState!.validate() &&
        dropValue != null &&
        dueDateValue != null &&
        dueTimeValue != null) {
      dueDateValue = new DateTime(dueDateValue!.year, dueDateValue!.month,
          dueDateValue!.day, dueTimeValue!.hour, dueTimeValue!.minute);
      TaskModel task = new TaskModel(
        id: oldtask.id,
        idProject: dropValue!.id,
        idAuthor: getVm().user!.uid,
        title: titleController.text,
        description: descriptionController.text,
        startDate: DateTime.now(),
        dueDate: dueDateValue!,
        listMember: list,
      );
      String taskId =
          await getVm().editTask(task, oldProject!, dropValue!, oldMemberList!);
      if (pickerFile != null) getVm().uploadDesTask(taskId, pickerFile!.path);
      Get.back();
    }
  }

  Widget buildDoneButton(TaskModel task) => PrimaryButton(
        text: StringTranslateExtension(AppStrings.editTask).tr(),
        press: () => editTaskClick(task),
        backgroundColor: AppColors.kPrimaryColor_yellow,
        disable: !onRunning,
      ).pad(0, 24);

  AppBar buildAppBar() => StringTranslateExtension(AppStrings.editTask)
      .tr()
      .plainAppBar()
      .backgroundColor(AppColors.kPrimaryColor_yellow)
      .bAppBar();

  @override
  EditTaskViewModel getVm() => widget.watch(viewModelProvider).state;
}
