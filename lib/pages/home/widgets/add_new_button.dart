import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/constants/constants.dart';
import 'package:to_do_list/routing/app_routes.dart';

class AddNewButton extends StatelessWidget {
  const AddNewButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => showAddDialog(context),
      child: Container(
        margin: EdgeInsets.only(top: 40),
        width: size.width * .15,
        height: size.width * .15,
        decoration: BoxDecoration(
          //color: Colors.red,
          gradient: RadialGradient(
            colors: [
              Color(0xFFF68888),
              Color(0xFFF96060),
            ],
            center: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(56),
        ),
        child: Center(
          child: Text(
            "+",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void showAddDialog(BuildContext context) => showDialog(
        barrierColor: AppColors.kBarrierColor,
        context: context,
        builder: (context) => SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          contentPadding: EdgeInsets.all(0),
          children: <Widget>[
            SimpleDialogOption(
              padding: EdgeInsets.all(0),
              child: CreateItem(
                text: StringTranslateExtension(AppStrings.addTask).tr(),
                press: () {
                  Get.offAndToNamed(AppRoutes.NEW_TASK);
                },
              ),
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(0),
              child: CreateItem(
                text: StringTranslateExtension(AppStrings.addQuickNote).tr(),
                press: () {
                  Get.offAndToNamed(AppRoutes.NEW_NOTE);
                },
              ),
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(0),
              child: CreateItem(
                text: StringTranslateExtension(AppStrings.addCheckList).tr(),
                press: () {
                  Get.offAndToNamed(AppRoutes.NEW_CHECK_LIST);
                },
              ),
            ),
          ],
        ),
      );
}

class CreateItem extends StatelessWidget {
  const CreateItem({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 268,
      height: 71,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFE4E4E4).withOpacity(.4),
        ),
      ),
      // ignore: deprecated_member_use
      child: TextButton(
        onPressed: () => press(),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: AppColors.kText,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
