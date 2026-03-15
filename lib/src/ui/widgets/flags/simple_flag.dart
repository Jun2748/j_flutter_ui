import 'package:flutter/material.dart';

import '../../resources/images.dart';
import '../../utils/flag_utils.dart';

class SimpleFlag extends StatelessWidget {
  const SimpleFlag.asset(
    this.asset, {
    super.key,
    this.size,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.placeholder,
  }) : countryCode = null;

  const SimpleFlag.countryCode(
    this.countryCode, {
    super.key,
    this.size,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.placeholder,
  }) : asset = null;

  final String? asset;
  final String? countryCode;
  final double? size;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final Widget? placeholder;

  @override
  Widget build(BuildContext context) {
    final double? resolvedWidth = width ?? size;
    final double? resolvedHeight = height ?? size;
    final String? resolvedAsset =
        asset ?? FlagUtils.flagAssetFromCountry(countryCode);

    if (resolvedAsset == null || resolvedAsset.isEmpty) {
      return SizedBox(width: resolvedWidth, height: resolvedHeight);
    }

    return Images.svg(
      resolvedAsset,
      width: resolvedWidth,
      height: resolvedHeight,
      fit: fit,
      alignment: alignment,
      placeholder: placeholder,
    );
  }
}
