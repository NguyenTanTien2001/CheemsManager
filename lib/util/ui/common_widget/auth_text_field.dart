import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '/constants/app_colors.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    Key? key,
    required this.controller,
    this.label = '',
    this.hint = '',
    this.isPassword = false,
    this.validator,
    this.enabled,
    this.border,
    this.maxLines,
  }) : super(key: key);

  final TextEditingController controller;
  final String label, hint;
  final bool isPassword;
  final String? Function(String?)? validator;
  final bool? enabled;
  final InputBorder? border;
  final int? maxLines;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool isShow = true;

  void togglePasswordView() {
    setState(() {
      isShow = !isShow;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.isPassword == true) {
      setState(() {
        isShow = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label
            .tr()
            .plain()
            .fSize(20)
            .lHeight(24.62)
            .weight(FontWeight.w600)
            .b(),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          obscureText: !isShow,
          enabled: widget.enabled,
          obscuringCharacter: '●',
          maxLines: widget.maxLines ?? 1,
          style: TextStyle(
            fontSize: 16.t,
            height: (19.7 / 16).t,
            decorationColor: AppColors.kText10,
          ),
          decoration: InputDecoration(
            border: widget.border,
            hintText: widget.hint.tr(),
            hintStyle: TextStyle(
              color: AppColors.kLightText,
              fontSize: 16.t,
              height: 19.7 / 16,
            ),
            suffixIcon: widget.isPassword
                ? isShow
                    ? Icon(
                        Icons.visibility_outlined,
                        color: AppColors.kLightText,
                      ).inkTap(
                        onTap: togglePasswordView,
                        borderRadius: BorderRadius.circular(100),
                      )
                    : Icon(
                        Icons.visibility_off_outlined,
                        color: AppColors.kLightText,
                      ).inkTap(
                        onTap: togglePasswordView,
                        borderRadius: BorderRadius.circular(100),
                      )
                : null,
          ),
        ),
      ],
    );
  }
}
