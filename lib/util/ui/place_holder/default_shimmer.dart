import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '/util/ui/style/style.dart';

class IconShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? baseColor;
  final Color? highlightColor;
  final Color? loadingColor;
  final Icon icon;

  const IconShimmer({
    Key? key,
    this.width,
    this.height,
    this.baseColor,
    this.highlightColor,
    this.loadingColor,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade300,
      highlightColor: highlightColor ?? Colors.grey.shade100,
      enabled: true,
      child: icon,
    );
  }
}

class VerticalExpandedShimmer extends StatelessWidget {
  final double height;
  final BorderRadius? borderRadius;
  final BoxShape shape;
  final Color? baseColor;
  final Color? highlightColor;
  final Color? loadingColor;

  const VerticalExpandedShimmer({
    Key? key,
    this.shape = BoxShape.rectangle,
    required this.height,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
    this.loadingColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade300,
      highlightColor: highlightColor ?? Colors.grey.shade100,
      enabled: true,
      child: Expanded(
        child: Container(
          height: height,
        ),
      ),
    );
  }
}

class RectangleShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxShape shape;
  final Color? baseColor;
  final Color? highlightColor;
  final Color? loadingColor;

  const RectangleShimmer({
    Key? key,
    this.shape = BoxShape.rectangle,
    this.borderRadius,
    this.width,
    this.height,
    this.baseColor,
    this.highlightColor,
    this.loadingColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade300,
      highlightColor: highlightColor ?? Colors.grey.shade100,
      enabled: true,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          shape: shape,
          color: loadingColor ?? Colors.grey,
        ),
      ),
    );
  }
}

class CircleShimmer extends StatelessWidget {
  final double radius;
  final BorderRadius? borderRadius;
  final Color? baseColor;
  final Color? highlightColor;
  final Color? loadingColor;

  const CircleShimmer({
    Key? key,
    this.borderRadius,
    this.radius = 28,
    this.baseColor,
    this.highlightColor,
    this.loadingColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade300,
      highlightColor: highlightColor ?? Colors.grey.shade100,
      enabled: true,
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          shape: BoxShape.circle,
          color: loadingColor ?? Colors.grey,
        ),
      ),
    );
  }
}

class GridPostShimmer extends StatelessWidget {
  final Color? baseColor;
  final Color? highlightColor;
  final Color? loadingColor;

  const GridPostShimmer({
    Key? key,
    this.baseColor,
    this.highlightColor,
    this.loadingColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) => LayoutBuilder(
              builder: (context, constraints) => simpleShimmer(
                  constraints.biggest.width, constraints.biggest.width),
            )),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 1, mainAxisSpacing: 1));
  }
}
