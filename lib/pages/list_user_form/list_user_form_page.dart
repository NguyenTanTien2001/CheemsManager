import 'package:flutter/material.dart';

import '/util/ui/common_widget/select_user_item.dart';
import '/models/meta_user_model.dart';
import '/constants/strings.dart';
import 'list_user_form_vm.dart';
import '/util/extension/extension.dart';
import '/base/base_state.dart';
import 'list_user_form_provider.dart';

class ListUserFormPage extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return ListUserFormPage._(watch);
    });
  }

  const ListUserFormPage._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return ListUserFormState();
  }
}

class ListUserFormState
    extends BaseState<ListUserFormPage, ListUserFormViewModel> {
  List<MetaUserModel> list = [];

  @override
  void didChangeDependencies() {
    getVm().initSelect(Get.arguments as List<MetaUserModel>);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      height: screenHeight,
      width: screenWidth,
      child: SingleChildScrollView(
        child: StreamBuilder<List<MetaUserModel>?>(
          stream: getVm().bsListUser,
          builder: (context, fullSnapshot) {
            if (fullSnapshot.hasError) {
              return AppStrings.somethingWentWrong.text12().tr().center();
            }

            if (fullSnapshot.connectionState == ConnectionState.waiting) {
              return AppStrings.loading.text12().tr().center();
            }

            List<MetaUserModel> fullData = fullSnapshot.data!;

            return StreamBuilder<List<MetaUserModel>>(
              stream: getVm().bsSelectListUser,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return AppStrings.somethingWentWrong.text12().tr().center();
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return AppStrings.loading.text12().tr().center();
                }

                List<MetaUserModel> data = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < fullData.length; i++)
                      SelectUserItem(
                        userModel: fullData[i],
                        checked: data.contains(fullData[i]),
                        press: () => getVm().checkClick(fullData[i]),
                      )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  AppBar buildAppBar() => StringTranslateExtension(AppStrings.selectUser)
          .tr()
          .plainAppBar()
          .actions(
        [
          IconButton(
              onPressed: () {
                Get.back(
                  result: getVm().bsSelectListUser.value,
                );
              },
              icon: Icon(Icons.check))
        ],
      ).bAppBar();

  @override
  ListUserFormViewModel getVm() => widget.watch(viewModelProvider).state;
}
