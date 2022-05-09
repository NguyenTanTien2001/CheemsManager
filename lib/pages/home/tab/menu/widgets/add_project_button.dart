import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/constants.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';
import '../../../../../util/ui/common_widget/choose_color_icon.dart';
import '../../../../../util/ui/common_widget/primary_button.dart';
import 'package:easy_localization/easy_localization.dart';

class AddProjectButton extends StatelessWidget {
  const AddProjectButton({Key? key, required this.press}) : super(key: key);

  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 80.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: AppColors.kColorNote[0],
      ),
      child: "+"
          .plain()
          .fSize(24)
          .color(Colors.white)
          .weight(FontWeight.bold)
          .b()
          .center(),
    )
        .inkTap(
          onTap: () => showAddProjectDialog(context),
          borderRadius: BorderRadius.circular(5.r),
        )
        .pad(20, 0, 12);
  }

  Future<void> showAddProjectDialog(BuildContext context) async {
    int indexChooseColor = 0;
    final _formKey = GlobalKey<FormState>();
    TextEditingController _projectController = TextEditingController();
    return await showDialog(
      barrierColor: AppColors.kBarrierColor,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          void _setColor(int index) {
            setState(() {
              indexChooseColor = index;
            });
          }

          return AlertDialog(
            contentPadding: EdgeInsets.all(24),
            content: Container(
              width: screenWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppStrings.title
                        .plain()
                        .fSize(18)
                        .weight(FontWeight.bold)
                        .b(),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(border: InputBorder.none),
                      validator: (val) => val!.isNotEmpty
                          ? null
                          : StringTranslateExtension(
                                  AppStrings.pleaseEnterYourText)
                              .tr(),
                      controller: _projectController,
                    ),
                    SizedBox(height: 16),
                    AppStrings.chooseColor
                        .plain()
                        .fSize(18)
                        .weight(FontWeight.bold)
                        .b()
                        .tr(),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        for (int i = 0; i < 5; i++)
                          ChooseColorIcon(
                            index: i,
                            press: _setColor,
                            tick: i == indexChooseColor,
                          ),
                      ],
                    ),
                    SizedBox(height: 20),
                    PrimaryButton(
                      text: StringTranslateExtension(AppStrings.done).tr(),
                      press: () async {
                        if (_formKey.currentState!.validate()) {
                          press(_projectController.text, indexChooseColor);
                          Get.back();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
