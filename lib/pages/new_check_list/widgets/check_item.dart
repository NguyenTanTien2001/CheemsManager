import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/constants/constants.dart';
import 'package:to_do_list/util/extension/extension.dart';
import '/util/extension/dimens.dart';

class CheckItem extends StatelessWidget {
  const CheckItem({
    Key? key,
    required this.index,
    required this.controller,
  }) : super(key: key);

  final int index;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              color: AppColors.kGrayBack,
              borderRadius: BorderRadius.circular(3.r),
              border: Border.all(
                color: AppColors.kInnerBorder,
              ),
            ),
          ).pad(0, 0, 12),
          SizedBox(width: 14),
          Expanded(
            child: TextFormField(
              controller: controller,
              validator: (val) =>
                  val!.isNotEmpty ? null : AppStrings.pleaseEnterListItem.tr(),
              decoration: InputDecoration(
                hintText:
                    AppStrings.listItem.tr(args: [(index + 1).toString()]),
                hintStyle: TextStyle(
                  color: AppColors.kGrayTextA,
                ),
                border: InputBorder.none,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
