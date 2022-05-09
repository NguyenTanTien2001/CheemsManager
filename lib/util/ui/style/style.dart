import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '/constants/app_colors.dart';
import '/util/extension/widget_extension.dart';
import '/util/ui/place_holder/default_shimmer.dart';

PreferredSize getThemeAppBar(BuildContext context, String title,
    {Function? onBack,
    Widget? customLeading,
    Widget? action,
    bool centerTitle = false,
    Widget? customTitle,
    PreferredSize? bottom,
    bool hideLead = false,
    bool raisedLeadingIcon = true,
    bool hideBottom = false}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(50),
    child: AppBar(
      automaticallyImplyLeading: true,
      centerTitle: centerTitle,
      elevation: 0.0,
      backgroundColor: Colors.white,
      title: customTitle ?? title.bold().b(),
      bottom: hideBottom
          ? null
          : bottom ??
              PreferredSize(
                  child: Container(
                    color: const Color(0xfff2f2f2),
                    height: 1,
                    width: double.infinity,
                  ),
                  preferredSize: const Size.fromHeight(1)),
      leading: hideLead
          ? Container(
              width: 44,
            )
          : Center(
              child: customLeading ??
                  InkWell(
                      child: raisedLeadingIcon
                          ? Center(child: themeBackBtn(context))
                          : const Icon(
                              Icons.arrow_back,
                              color: AppColors.primary,
                              size: 20,
                            ).rectAll(24, color: Colors.transparent).pad(10),
                      onTap: () {
                        Navigator.of(context);
                        if (onBack != null) {
                          onBack();
                        }
                      }).square(44),
            ),
      actions: action != null
          ? <Widget>[action]
          : <Widget>[
              Container(
                width: 44,
              )
            ],
    ),
  );
}

Widget appCachedImage(
    {String? url,
    Widget? loadingPlaceHolder,
    Widget? errorPlaceHolder,
    BoxFit? fit}) {
  return url != null
      ? CachedNetworkImage(
          imageUrl: url,
          fit: fit ?? BoxFit.cover,
          placeholder: (context, url) =>
              loadingPlaceHolder ?? const RectangleShimmer(),
          errorWidget: (context, _, __) =>
              errorPlaceHolder ?? const Text('error'),
        )
      : const RectangleShimmer();
}

Widget simpleShimmer(double height, double width) {
  return SizedBox(
    height: height,
    width: width,
    child: Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        color: Colors.grey,
      ),
    ),
  );
}

Widget themeBackBtn(BuildContext context) {
  return IconButton(
    icon: const Icon(
      Icons.arrow_back,
      size: 20,
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
}
