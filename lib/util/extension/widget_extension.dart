import 'package:flutter/material.dart';
import 'package:to_do_list/util/extension/dimens.dart';
import 'package:easy_localization/easy_localization.dart';
import '/constants/constants.dart';

extension WidgetExtension on Widget {
  Widget square(double size) {
    return rectangle(size, size);
  }

  Widget rectangle(double width, double height) {
    return SizedBox(child: this, width: width, height: height);
  }

  Widget height(double size) {
    return SizedBox(
      height: size,
      child: this,
    );
  }

  Widget width(double size) {
    return SizedBox(
      width: size,
      child: this,
    );
  }

  Widget center() {
    return Center(
      child: this,
    );
  }

  Widget inkTap({
    required Function onTap,
    BorderRadiusGeometry borderRadius = BorderRadius.zero,
    Color? color,
    Color? splashColor,
  }) {
    return Container(
      color: color,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: splashColor,
          onTap: () => onTap.call(),
          customBorder: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
          child: this,
        ),
      ),
    );
  }

  Widget marg([double? a, double? b, double? c, double? d]) {
    EdgeInsets mPad;

    if (d != null) {
      mPad = EdgeInsets.only(left: a!, right: b!, top: c!, bottom: d);
    } else if (c != null) {
      mPad = EdgeInsets.only(left: a!, right: b!, top: c);
    } else if (b != null) {
      mPad = EdgeInsets.symmetric(vertical: a!, horizontal: b);
    } else if (a != null) {
      mPad = EdgeInsets.all(a);
    } else {
      mPad = EdgeInsets.zero;
    }

    return Container(
      margin: mPad,
      child: this,
    );
  }

  Widget pad([double? a, double? b, double? c, double? d]) {
    EdgeInsets mPad;

    if (d != null) {
      mPad = EdgeInsets.only(left: a!.w, right: b!.w, top: c!.w, bottom: d.w);
    } else if (c != null) {
      mPad = EdgeInsets.only(left: a!.w, right: b!.w, top: c.w);
    } else if (b != null) {
      mPad = EdgeInsets.symmetric(vertical: a!.w, horizontal: b.w);
    } else if (a != null) {
      mPad = EdgeInsets.all(a.w);
    } else {
      mPad = EdgeInsets.zero;
    }

    return Padding(
      padding: mPad,
      child: this,
    );
  }

  Widget align(AlignmentGeometry alignment) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }

  Widget centerLeft() {
    return Align(
      alignment: Alignment.centerLeft,
      child: this,
    );
  }

  Widget rectAll(double radius,
      {Color? color, Color? borderColor, double? borderWidth}) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: Container(
        child: this,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            border: Border.all(
                color: borderColor ?? Colors.white, width: borderWidth ?? 0)),
      ),
    );
  }
}

class _TextWidgetBuilder {
  late String text;
  TextOverflow? _overflow;
  FontWeight _fontWeight = FontWeight.w500;
  TextAlign _textAlign = TextAlign.start;
  Color _color = Colors.black;
  Color _fillColor = Colors.transparent;
  FontStyle? _fontStyle;
  double? _fontSize;

  // ignore: unused_field
  double? _height;
  int? _maxLines;

  // ignore: unused_field
  int? _maxLength;

  List<Shadow>? _shadow;

  TextDecoration? _decoration;

  _TextWidgetBuilder(this.text);

  _TextWidgetBuilder weight(FontWeight value) {
    _fontWeight = value;
    return this;
  }

  _TextWidgetBuilder align(TextAlign value) {
    _textAlign = value;
    return this;
  }

  _TextWidgetBuilder color(Color value) {
    _color = value;
    return this;
  }

  _TextWidgetBuilder fillColor(Color value) {
    _fillColor = value;
    return this;
  }

  _TextWidgetBuilder fStl(FontStyle value) {
    _fontStyle = value;
    return this;
  }

  _TextWidgetBuilder fShadow(List<Shadow>? value) {
    _shadow = value;
    return this;
  }

  _TextWidgetBuilder fSize(double value) {
    _fontSize = value;
    return this;
  }

  _TextWidgetBuilder lines(int? value) {
    _maxLines = value;
    return this;
  }

  _TextWidgetBuilder overflow(TextOverflow? value) {
    _overflow = value;
    return this;
  }

  _TextWidgetBuilder multipleLines() {
    _maxLines = null;
    return this;
  }

  _TextWidgetBuilder center() {
    _textAlign = TextAlign.center;
    return this;
  }

  _TextWidgetBuilder lHeight(double lineHeight) {
    _height = lineHeight;
    return this;
  }

  _TextWidgetBuilder decoration(TextDecoration value) {
    _decoration = value;
    return this;
  }

  Text build() {
    return Text(
      text,
      style: TextStyle(
        color: _color,
        backgroundColor: _fillColor,
        fontSize: (_fontSize ?? 12).t,
        fontWeight: _fontWeight,
        fontStyle: _fontStyle ?? FontStyle.normal,
        height: _height != null ? _height! / (_fontSize ?? 12) : (16 / 12),
        shadows: _shadow,
        decoration: _decoration,
      ),
      textAlign: _textAlign,
      maxLines: _maxLines,
      overflow: _overflow,
    );
  }
}

extension TextBuilderExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  _TextWidgetBuilder plain() {
    return _TextWidgetBuilder(this).color(AppColors.kText);
  }

  _TextWidgetBuilder bold() {
    return _TextWidgetBuilder(this)
        .color(AppColors.kText)
        .weight(FontWeight.w700);
  }

  _TextWidgetBuilder lite() {
    return _TextWidgetBuilder(this).weight(FontWeight.w300);
  }

  _TextWidgetBuilder plainErr() {
    return plain().color(Colors.red);
  }

  _TextWidgetBuilder boldErr() {
    return bold().color(Colors.red);
  }

  _TextWidgetBuilder liteErr() {
    return bold().color(Colors.red);
  }

  _TextWidgetBuilder plainW() {
    return plain().color(Colors.white);
  }

  _TextWidgetBuilder boldW() {
    return bold().color(Colors.white);
  }

  _TextWidgetBuilder liteW() {
    return bold().color(Colors.white);
  }

  Text mainTitle() {
    return bold().fSize(16).lines(1).align(TextAlign.center).b();
  }

  Text secondaryTitle() {
    return bold()
        .fSize(16)
        .lines(1)
        .color(Colors.black)
        .align(TextAlign.center)
        .b();
  }

  Text title() {
    return plain().fSize(14).lines(1).b();
  }

  Text mainDesc() {
    return plain().fSize(14).multipleLines().b();
  }

  Text desc() {
    return plain().fSize(14).multipleLines().color(Colors.black).b();
  }

  Text text12() {
    return plain()
        .fSize(12)
        .lHeight(16)
        .multipleLines()
        .weight(FontWeight.w500)
        .center()
        .overflow(TextOverflow.ellipsis)
        .b();
  }

  Text text14(
      {FontWeight fontWeight = FontWeight.w400,
      Color color = AppColors.kText}) {
    return plain().fSize(14).lHeight(16).color(color).weight(fontWeight).b();
  }

  Text text18(
      {FontWeight fontWeight = FontWeight.w400,
      Color color = AppColors.kText}) {
    return plain().fSize(18).lHeight(22).color(color).weight(fontWeight).b();
  }

  Text text24() {
    return plain()
        .fSize(24)
        .lHeight(28)
        .color(AppColors.kText)
        .weight(FontWeight.w500)
        .b();
  }

  Text descColor({Color? color, FontWeight? fontWeight}) {
    return plain()
        .fSize(12)
        .lHeight(16)
        .multipleLines()
        .weight(fontWeight ?? FontWeight.w500)
        .center()
        .color(color ?? Colors.white)
        .b();
  }

  Text secondaryDescColor({Color? color, FontWeight? fontWeight}) {
    return plain()
        .fSize(14)
        .lHeight(20)
        .multipleLines()
        .weight(fontWeight ?? FontWeight.w500)
        .center()
        .b();
  }

  Text buttonTitle() {
    return bold().fSize(14).lines(1).color(Colors.white).b();
  }

  Text disableButtonTitle() {
    return bold().fSize(14).lines(1).color(Colors.grey).b();
  }

  Text appBarTitle() {
    return plain().weight(FontWeight.w500).fSize(16).lHeight(24).lines(1).b();
  }
}

extension TextExtension on _TextWidgetBuilder {
  Text b() {
    return build();
  }

  Text btr() {
    return build().tr();
  }
}

class _AppBarWidgetBuilder {
  Widget? title;

  bool? _centerTitle;

  Color? _backgroundColor;

  double? _elevation;

  Widget? _leading;

  List<Widget>? _actions;

  _AppBarWidgetBuilder(this.title);

  _AppBarWidgetBuilder centerTitle(bool value) {
    _centerTitle = value;
    return this;
  }

  _AppBarWidgetBuilder backgroundColor(Color? value) {
    _backgroundColor = value;
    return this;
  }

  _AppBarWidgetBuilder elevation(double value) {
    _elevation = value;
    return this;
  }

  _AppBarWidgetBuilder leading(Widget? value) {
    _leading = value;
    return this;
  }

  _AppBarWidgetBuilder actions(List<Widget>? value) {
    _actions = value;
    return this;
  }

  AppBar build() {
    return AppBar(
      title: title,
      centerTitle: _centerTitle ?? true,
      backgroundColor: _backgroundColor ?? AppColors.kPrimaryColor,
      elevation: _elevation ?? 0,
      leading: _leading,
      actions: _actions,
    );
  }
}

extension AppBarBuilderExtension on String {
  _AppBarWidgetBuilder plainAppBar({Color color = Colors.white}) {
    return _AppBarWidgetBuilder(this
        .plain()
        .color(color)
        .weight(FontWeight.bold)
        .fSize(20)
        .weight(FontWeight.w600)
        .b());
  }
}

extension AppBarExtension on _AppBarWidgetBuilder {
  AppBar bAppBar() {
    return build();
  }
}

String toDateString(DateTime dateTime, {bool isUpCase = true}) {
  String result = '';

  DateTime toDay = DateTime.now();

  if (dateTime.day == toDay.day &&
      dateTime.month == toDay.month &&
      dateTime.year == toDay.year) {
    result += 'Today, ';
  }

  DateTime tomorrow = DateTime.now().add(const Duration(days: 1));

  if (dateTime.day == tomorrow.day &&
      dateTime.month == tomorrow.month &&
      dateTime.year == tomorrow.year) {
    result += 'Tomorrow, ';
  }

  result += AppStrings.kMonthHeader[dateTime.month - 1].tr().substring(0, 3) +
      " " +
      dateTime.day.toString() +
      '/' +
      dateTime.year.toString();
  if (isUpCase) return result.toUpperCase();
  return result;
}
