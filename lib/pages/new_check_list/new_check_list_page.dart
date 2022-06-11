import 'package:flutter/material.dart';
import '/constants/constants.dart';
import '/models/note_model.dart';
import '/models/quick_note_model.dart';
import '/pages/new_check_list/new_check_list_vm.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';
import '../../util/ui/common_widget/choose_color_icon.dart';
import '../../util/ui/common_widget/primary_button.dart';

import '/base/base_state.dart';
import '/util/ui/common_widget/auth_text_field.dart';
import 'widgets/check_item.dart';
import 'new_check_list_provider.dart';

class NewCheckListPage extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return NewCheckListPage._(watch);
    });
  }

  const NewCheckListPage._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return NewCheckListState();
  }
}

class NewCheckListState
    extends BaseState<NewCheckListPage, NewCheckListViewModel> {
  int indexChooseColor = 0;
  int indexCheckItem = 4;
  void _setColor(int index) {
    setState(() {
      indexChooseColor = index;
    });
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();

  List<TextEditingController> _listItemController = [
    for (int i = 0; i < 10; i++) TextEditingController(),
  ];

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
            height: 44,
            child: Container(color: AppColors.kPrimaryColor),
          ),
          buildForm(),
        ],
      ),
    );
  }

  AppBar buildAppBar() => StringTranslateExtension(AppStrings.addCheckList)
      .tr()
      .plainAppBar()
      .bAppBar();

  Widget buildForm() => Positioned(
        top: 10.w,
        left: 0,
        width: screenWidth,
        child: Container(
          height: 700.w,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCheckListForm(),
                    SizedBox(height: 12),
                    buildRemoveAndAdd(),
                    SizedBox(height: 40),
                    buildChooseColor(),
                    buildDoneButton(),
                  ],
                ),
              ),
            ).pad(0, 16),
          ),
        ),
      );

  Widget buildCheckListForm() => Column(
        children: [
          AuthTextField(
            label: AppStrings.title,
            controller: _titleController,
            hint: AppStrings.pleaseEnterYourText,
            validator: (val) => val!.isNotEmpty
                ? null
                : StringTranslateExtension(AppStrings.pleaseEnterYourText).tr(),
            border: InputBorder.none,
            maxLines: 2,
          ),
          for (int i = 0; i < indexCheckItem; i++)
            CheckItem(
              index: i,
              controller: _listItemController[i],
            ),
        ],
      );

  Widget buildRemoveAndAdd() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppStrings.addNewItem
              .plain()
              .fSize(16.w)
              .lHeight(18.75)
              .weight(FontWeight.w600)
              .b()
              .tr()
              .inkTap(
            onTap: () {
              setState(() {
                if (indexCheckItem < 10) indexCheckItem++;
              });
            },
          ),
          AppStrings.removeItem
              .plain()
              .fSize(16.w)
              .lHeight(18.75)
              .weight(FontWeight.w600)
              .b()
              .tr()
              .inkTap(
            onTap: () {
              setState(() {
                if (indexCheckItem > 1) indexCheckItem--;
              });
            },
          ),
        ],
      );

  Widget buildChooseColor() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppStrings.chooseColor
              .plain()
              .fSize(18)
              .weight(FontWeight.w600)
              .b()
              .tr(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < 5; i++)
                ChooseColorIcon(
                  index: i,
                  press: _setColor,
                  tick: i == indexChooseColor,
                )
            ],
          ).pad(17, 0),
        ],
      );

  void addCheckListClick() {
    if (_formKey.currentState!.validate()) {
      List<NoteModel> _list = [];
      for (int i = 0; i < indexCheckItem; i++) {
        _list.add(new NoteModel(
            id: i, text: _listItemController[i].text, check: false));
      }
      QuickNoteModel quickNote = new QuickNoteModel(
        content: _titleController.text,
        indexColor: indexChooseColor,
        time: DateTime.now(),
        listNote: _list,
      );
      if (Get.arguments == null)
        getVm().newQuickNote(quickNote);
      else
        getVm().newTaskkNote(quickNote, Get.arguments);
      Get.back();
    }
  }

  Widget buildDoneButton() => PrimaryButton(
        text: AppStrings.done,
        disable: !onRunning,
        press: () => addCheckListClick(),
      );

  @override
  NewCheckListViewModel getVm() => widget.watch(viewModelProvider).state;
}
