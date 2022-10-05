import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_constants.dart';
import 'package:to_do_list/models/quick_note_model.dart';
import 'package:to_do_list/constants/constants.dart';
import 'package:to_do_list/pages/home/tab/profiles/widgets/count_task_item.dart';
import 'package:to_do_list/pages/home/tab/profiles/widgets/statistic_item.dart';
import 'package:to_do_list/routing/app_routes.dart';

import '/base/base_state.dart';
import '/constants/app_colors.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';
import 'profile_provider.dart';
import 'profile_vm.dart';
import 'widgets/profile_info.dart';
import 'widgets/setting_card.dart';

class ProfileTab extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return ProfileTab._(watch);
    });
  }

  const ProfileTab._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends BaseState<ProfileTab, ProfileViewModel> {
  User? localUser;

  int noteLength = 0;
  int noteSuccessfulLength = 0;

  int checkListLength = 0;
  int checkListSuccessfulLength = 0;

  int taskLength = 0;
  int taskSuccessfulLength = 0;

  @override
  void initState() {
    super.initState();
    initQuickNoteState();
    initUser();
  }

  void initQuickNoteState() {
    getVm().bsListQuickNote.listen((networkListQuickNote) {
      List<QuickNoteModel> listNote = networkListQuickNote!
          .where((quickNote) => quickNote.listNote.length == 0)
          .toList();
      // update quick note length
      if (noteLength != listNote.length) {
        setState(() {
          noteLength = listNote.length;
        });
      }
      // update quick note successful
      var networkNoteSuccessfulLength = listNote
          .where((QuickNoteModel note) => note.isSuccessful == true)
          .length;
      if (noteSuccessfulLength != networkNoteSuccessfulLength) {
        setState(() {
          noteSuccessfulLength = networkNoteSuccessfulLength;
        });
      }

      List<QuickNoteModel> listCheckList = networkListQuickNote
          .where((quickNote) => quickNote.listNote.length > 0)
          .toList();

      // update check list length
      if (checkListLength != listCheckList.length) {
        setState(() {
          checkListLength = listCheckList.length;
        });
      }

      // update quick note successful
      var networkQuickNoteSuccessfulLength =
          listCheckList.where((element) => element.isSuccessful).length;
      if (checkListSuccessfulLength != networkQuickNoteSuccessfulLength) {
        setState(() {
          checkListSuccessfulLength = networkQuickNoteSuccessfulLength;
        });
      }
    });

    getVm().bsListTask.listen((value) {
      if (value != null) {
        setState(() {
          taskSuccessfulLength =
              value.where((element) => element.completed).toList().length;
          taskLength = value.length;
        });
      }
    });
  }

  void initUser() {
    getVm().getUser().listen((networkUser) {
      // init local user
      if (networkUser != null) {
        if (localUser == null) {
          setState(() {
            localUser = networkUser;
          });
        } else {
          if (localUser!.photoURL != networkUser.photoURL) {
            localUser!.updatePhotoURL(networkUser.photoURL);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: localUser == null ? 'Loading'.desc() : buildBody(),
      appBar: buildAppBar(),
    );
  }

  Widget buildBody() {
    return Container(
      child: Container(
        color: Colors.white,
        height: screenHeight,
        width: screenWidth,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.w),
              buildCardInfo(),
              SizedBox(height: 24.w),
              buildListCountTask(),
              SizedBox(height: 24.w),
              buildStatistic(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() => StringTranslateExtension('profiles')
      .tr()
      .plainAppBar(color: AppColors.kText)
      .backgroundColor(Colors.white)
      .bAppBar();

  Widget buildCardInfo() {
    return Container(
      width: screenWidth,
      height: 190.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: Colors.white,
        boxShadow: AppConstants.kBoxShadow,
      ),
      child: StreamBuilder<infoStatus>(
        stream: getVm().bsInfoStatus,
        builder: (context, snapshot) {
          if (snapshot.data == infoStatus.setting) {
            return SettingCard(
              pressToProfile: () => getVm().changeInfoStatus(infoStatus.info),
              pressSignOut: () {
                getVm().signOut();
                Get.offAndToNamed(AppRoutes.SIGN_IN);
              },
              pressUploadAvatar: getVm().uploadAvatar,
            );
          }
          return ProfileInfo(
            user: localUser!,
            press: () => getVm().changeInfoStatus(infoStatus.setting),
            createTask: noteLength + checkListLength + taskLength,
            completedTask: noteSuccessfulLength +
                checkListSuccessfulLength +
                taskSuccessfulLength,
          );
        },
      ),
    ).pad(0, 16);
  }

  Widget buildSetting() {
    return Container();
  }

  Widget buildListCountTask() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CountTaskItem(
            text: AppConstants.kStatisticTitle[0],
            task: taskLength,
          ).pad(0, 10, 0),
          CountTaskItem(
            text: AppConstants.kStatisticTitle[1],
            task: noteLength,
            color: AppColors.kSplashColor[1],
          ).pad(0, 10, 0),
          CountTaskItem(
            text: AppConstants.kStatisticTitle[2],
            task: checkListLength,
            color: AppColors.kSplashColor[2],
          ),
        ],
      ).pad(20, 20, 0),
    );
  }

  Widget buildStatistic() {
    return Container(
      width: 343.w,
      height: 205.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.r),
        boxShadow: AppConstants.kBoxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppStrings.statistic
              .plain()
              .fSize(18)
              .lHeight(21.09)
              .weight(FontWeight.bold)
              .b()
              .tr()
              .pad(0, 0, 16, 21),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatisticIcon(
                color: AppColors.kPrimaryColor,
                ratio: taskLength == 0
                    ? 0
                    : taskSuccessfulLength / taskLength * 100,
                title: AppConstants.kStatisticTitle[0],
              ),
              StatisticIcon(
                color: AppColors.kSplashColor[1],
                ratio: noteLength == 0
                    ? 0
                    : noteSuccessfulLength / noteLength * 100,
                title: AppConstants.kStatisticTitle[1],
              ),
              StatisticIcon(
                color: AppColors.kSplashColor[2],
                ratio: checkListLength == 0
                    ? 0
                    : checkListSuccessfulLength / checkListLength * 100,
                title: AppConstants.kStatisticTitle[2],
              )
            ],
          )
        ],
      ).pad(0, 24),
    ).pad(0, 16);
  }

  @override
  ProfileViewModel getVm() => widget.watch(viewModelProvider).state;
}
