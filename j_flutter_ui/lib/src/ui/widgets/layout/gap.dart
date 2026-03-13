import 'package:flutter/material.dart';

import '../../resources/dimens.dart';

class Gap extends StatelessWidget {
  const Gap.h(this.size, {super.key}) : _height = size, _width = 0;

  const Gap.w(this.size, {super.key}) : _height = 0, _width = size;

  static const Gap h8 = Gap.h(JDimens.dp8);
  static const Gap h16 = Gap.h(JDimens.dp16);
  static const Gap h24 = Gap.h(JDimens.dp24);
  static const Gap w8 = Gap.w(JDimens.dp8);
  static const Gap w16 = Gap.w(JDimens.dp16);
  static const Gap w24 = Gap.w(JDimens.dp24);

  final double size;
  final double _height;
  final double _width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: _height, width: _width);
  }
}
