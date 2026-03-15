import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract final class Images {
  const Images._();

  static const String basePackage = 'j_flutter_ui';
  static const String _baseImagePath = 'assets/images';

  static AssetImage asset(String name, {String format = 'png'}) {
    return AssetImage(
      _rasterAssetPath(name, format: format),
      package: basePackage,
    );
  }

  static Widget svg(
    String asset, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center,
    Color? color,
    Widget? placeholder,
  }) {
    return RepaintBoundary(
      child: SvgPicture.asset(
        asset,
        package: basePackage,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        colorFilter: color == null
            ? null
            : ColorFilter.mode(color, BlendMode.srcIn),
        placeholderBuilder: (BuildContext context) =>
            placeholder ?? const SizedBox.shrink(),
      ),
    );
  }

  static String _rasterAssetPath(String name, {required String format}) {
    final String normalizedName = name.trim();
    final String normalizedFormat = format.trim().toLowerCase();

    return '$_baseImagePath/$normalizedFormat/$normalizedName.$normalizedFormat';
  }
}
