import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '/util/extension/widget_extension.dart';
import 'default_shimmer.dart';

class DefaultWarpPlaceHolder extends StatelessWidget {
  const DefaultWarpPlaceHolder({Key? key, this.length = 4, this.height})
      : super(key: key);
  final int length;
  final double? height;

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    int _length = ((length % 2 == 0) ? length : length + 1);
    double _height = height ?? deviceSize.height;
    return Wrap(
      spacing: 0.025 * deviceSize.width,
      runSpacing: 0.025 * _height,
      children: [
        for (int i = 0; i < _length; i++)
          RectangleShimmer(
            width: deviceSize.width * 0.46,
            height: _height * (1 - 0.025 * (_length / 2 + 1)) / (_length / 2),
          ),
      ],
    ).marg(0.05 * _height, 0.025 * deviceSize.width);
  }
}

class DefaultListPlaceHolder extends StatelessWidget {
  const DefaultListPlaceHolder({Key? key, this.length = 8, this.height})
      : super(key: key);
  final int length;
  final double? height;

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    double _height = height ?? deviceSize.height;
    return Column(
      children: [
        for (int i = 0; i < length; i++)
          RectangleShimmer(
            width: deviceSize.width * 0.9,
            height: _height * (1 - 0.05 * length) / length,
          ).marg(0.025 * _height, 0.05 * deviceSize.width),
      ],
    );
  }
}
