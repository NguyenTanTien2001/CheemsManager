import 'package:flutter/material.dart';
import '/constants/constants.dart';

import '/base/base_state.dart';
import '/models/quick_note_model.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';
import '../../util/ui/common_widget/choose_color_icon.dart';
import '../../util/ui/common_widget/primary_button.dart';
import '/util/ui/common_widget/auth_text_field.dart';
import 'new_note_provider.dart';
import 'new_note_vm.dart';

class NewNotePage extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return NewNotePage._(watch);
    });
  }

  const NewNotePage._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return NewNoteState();
  }
}

class NewNoteState extends BaseState<NewNotePage, NewNoteViewModel> {
  int indexChooseColor = 0;
  final formKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();

  void setColor(int index) {
    setState(() {
      indexChooseColor = index;
    });
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
            child: Container(
              decoration:
                  BoxDecoration(color: AppColors.kPrimaryColor, boxShadow: [
                BoxShadow(
                  offset: Offset(3, 3),
                  blurRadius: 9,
                  color: AppColors.kBoxShadowAddFormColor,
                )
              ]),
            ),
          ),
          buildForm(),
        ],
      ),
    );
  }

  AppBar buildAppBar() =>
      StringTranslateExtension(AppStrings.addNote).tr().plainAppBar().bAppBar();

  Widget buildForm() => Positioned(
        top: 10,
        left: 0,
        width: screenWidth,
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextField(),
                  SizedBox(height: 10),
                  buildChooseColor(),
                  buildDoneButton(),
                  SizedBox(height: 30.w),
                ],
              ),
            ),
          ),
        ).pad(0, 16),
      );

  Widget buildTextField() => AuthTextField(
        label: AppStrings.description,
        controller: descriptionController,
        hint: AppStrings.pleaseEnterYourText,
        validator: (val) => val!.isNotEmpty
            ? null
            : StringTranslateExtension(AppStrings.pleaseEnterYourText).tr(),
        border: InputBorder.none,
        maxLines: 8,
      );

  Widget buildChooseColor() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppStrings.chooseColor
              .plain()
              .fSize(18)
              .lHeight(22)
              .weight(FontWeight.w600)
              .b()
              .tr(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < 5; i++)
                ChooseColorIcon(
                  index: i,
                  press: setColor,
                  tick: i == indexChooseColor,
                )
            ],
          ).pad(17, 0)
        ],
      );

  Widget buildDoneButton() => PrimaryButton(
        text: AppStrings.done,
        press: () {
          if (formKey.currentState!.validate()) {
            QuickNoteModel quickNote = new QuickNoteModel(
              content: descriptionController.text,
              indexColor: indexChooseColor,
              time: DateTime.now(),
            );
            if (Get.arguments == null)
              getVm().newQuickNote(quickNote);
            else
              getVm().newTaskNote(quickNote, Get.arguments);
            Get.back();
          }
        },
        disable: !onRunning,
      );

  @override
  NewNoteViewModel getVm() => widget.watch(viewModelProvider).state;
}
