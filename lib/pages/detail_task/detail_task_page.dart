import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '/util/ui/common_widget/back_to_login.dart';
import 'widgets/comment_button.dart';
import 'widgets/comment_form.dart';
import 'widgets/list_comment.dart';
import 'widgets/list_member.dart';
import '/models/comment_model.dart';
import 'widgets/assigned.dart';
import 'widgets/description.dart';
import 'widgets/tag.dart';
import '/models/meta_user_model.dart';
import '/models/project_model.dart';
import '/util/ui/common_widget/primary_button.dart';
import '/constants/constants.dart';
import '/util/extension/extension.dart';
import '/models/task_model.dart';
import '/base/base_state.dart';
import 'detail_task_vm.dart';
import 'detail_task_provider.dart';
import 'widgets/due_date.dart';

class DetailTaskPage extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return DetailTaskPage._(watch);
    });
  }

  const DetailTaskPage._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return DetailTaskState();
  }
}

class DetailTaskState extends BaseState<DetailTaskPage, DetailTaskViewModel> {
  bool showComment = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController commentController = TextEditingController();

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
    getVm().loadComment(Get.arguments);

    getVm().bsShowComment.listen((value) {
      setState(() {
        showComment = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (getVm().user == null) return BackToLogin();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppbar(),
      body: SingleChildScrollView(
        child: StreamBuilder<TaskModel?>(
          stream: getVm().bsTask,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return AppStrings.somethingWentWrong.text12().tr().center();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return AppStrings.loading.text12().tr().center();
            }
            TaskModel task = snapshot.data!;
            return buildBody(task);
          },
        ),
      ),
    );
  }

  Widget buildBody(TaskModel task) {
    return Column(
      children: [
        buildTitle(task.title),
        SizedBox(height: 24),
        buildAssigned(task.idAuthor),
        buildLine(),
        buildDueDate(task.dueDate),
        buildLine(),
        buildDescription(task.description, task.desUrl),
        buildLine(),
        buildListMember(task.listMember),
        buildLine(),
        buildTag(task.idProject),
        SizedBox(height: 32.w),
        showComment ? buildCommentForm() : SizedBox(),
        showComment ? buildListComment() : SizedBox(),
        buildCompletedButton(
          task.completed,
          press: () => getVm().completedTask(task.id),
        ),
        SizedBox(height: 15.w),
        buildCommentButton(),
        SizedBox(height: 35.w),
      ],
    ).pad(0, 24);
  }

  Widget buildTitle(String title) => title
      .plain()
      .fSize(18)
      .lHeight(30)
      .weight(FontWeight.bold)
      .b()
      .align(Alignment.topLeft);

  Widget buildAssigned(String id) {
    return StreamBuilder<MetaUserModel>(
      stream: getVm().streamUser(id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return AppStrings.somethingWentWrong.text12().tr().center();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return AppStrings.loading.text12().tr().center();
        }

        MetaUserModel user = snapshot.data!;
        return Assigned(user: user);
      },
    );
  }

  Widget buildLine() => Container(
        color: AppColors.kLineColor,
        width: screenWidth,
        height: 2.w,
      ).pad(16, 0);

  Widget buildDueDate(DateTime dueDate) => DueDate(dueDate: dueDate);

  Widget buildDescription(String des, String url) => Description(
        des: des,
        url: url,
      );

  Widget buildListMember(List<String> listId) => ListMember(
        futureListMember: getVm().getAllUser(listId),
        streamComment: getVm().bsComment,
        getAllUser: getVm().getUser,
      );

  Widget buildTag(String projectId) => StreamBuilder<ProjectModel>(
        stream: getVm().getProject(projectId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return AppStrings.somethingWentWrong.text12().tr().center();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return AppStrings.loading.text12().tr().center();
          }
          ProjectModel project = snapshot.data!;
          return Tag(project: project);
        },
      );

  Widget buildCompletedButton(bool isComleted, {required Function press}) {
    if (!isComleted)
      return PrimaryButton(
        text: AppStrings.completedTasks,
        backgroundColor: AppColors.kColorNote[0],
        press: press,
        disable: !onRunning,
      );
    else
      return PrimaryButton(
        text: AppStrings.completedTasks,
        backgroundColor: AppColors.kPrimaryColor,
        press: () {},
        disable: false,
      );
  }

  void sendCommentClick() async {
    if (formKey.currentState!.validate() && !onRunning) {
      var comment = new CommentModel(
        text: commentController.text,
        userId: getVm().user!.uid,
        time: DateTime.now(),
      );
      String commentId = await getVm().newComment(Get.arguments, comment);
      if (pickerFile != null)
        await getVm()
            .uploadCommentImage(Get.arguments, commentId, pickerFile!.path);
      commentController.text = '';
      pickerFile = null;
    }
  }

  Widget buildCommentForm() => Form(
        key: formKey,
        child: CommentForm(
          controller: commentController,
          pickerImage: pickerFile,
          pressLoadImage: getPhoto,
          pressRemove: removePhoto,
          pressSend: sendCommentClick,
        ),
      );

  Widget buildListComment() => StreamBuilder<List<CommentModel>?>(
        stream: getVm().bsComment,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return AppStrings.somethingWentWrong.text12().tr().center();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return AppStrings.loading.text12().tr().center();
          }
          List<CommentModel> data = snapshot.data!;
          return ListComment(
            data: data,
            getUser: getVm().getUser,
          );
        },
      );

  Widget buildCommentButton() => CommentButton(
        showComment: showComment,
        press: () => getVm().setShowComment(!showComment),
      );

  AppBar buildAppbar() => ''
          .plainAppBar()
          .backgroundColor(Colors.white)
          .leading(
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close),
              color: Colors.black,
            ),
          )
          .actions(
        [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.settings),
            color: Colors.black,
          ),
        ],
      ).bAppBar();

  @override
  DetailTaskViewModel getVm() => widget.watch(viewModelProvider).state;
}
