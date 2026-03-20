import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../localization/app_localizations.dart';
import '../../localization/intl.dart';
import '../../resources/dimens.dart';
import '../../resources/styles.dart';
import '../../utils/text_scale_utils.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    this.text,
    this.localeKey,
    this.args,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.autoFit = false,
    this.useHtml = false,
    this.minFontSize,
    this.maxFontSize,
    this.semanticsLabel,
  });

  final String? text;
  final String? localeKey;
  final Map<String, String>? args;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final bool autoFit;
  final bool useHtml;
  final double? minFontSize;
  final double? maxFontSize;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final String resolvedText = _resolveText(context);
    final ThemeData theme = Theme.of(context);
    final TextStyle resolvedStyle =
        (theme.textTheme.bodyLarge ??
                JTextStyles.body1.copyWith(color: theme.colorScheme.onSurface))
            .merge(DefaultTextStyle.of(context).style)
            .merge(style);
    final double textScale = TextScaleUtils.getClampedScale(context);
    final Widget textWidget = useHtml
        ? _buildHtmlText(
            text: resolvedText,
            style: resolvedStyle,
            textScale: textScale,
          )
        : _buildPlainText(
            text: resolvedText,
            style: resolvedStyle,
            textScale: textScale,
          );

    if (semanticsLabel == null || semanticsLabel!.trim().isEmpty) {
      return textWidget;
    }

    return Semantics(
      label: semanticsLabel,
      child: ExcludeSemantics(child: textWidget),
    );
  }

  Widget _buildPlainText({
    required String text,
    required TextStyle style,
    required double textScale,
  }) {
    if (autoFit) {
      return AutoSizeText(
        text,
        style: style,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        minFontSize: minFontSize ?? JFontSizes.fs12,
        maxFontSize: maxFontSize ?? style.fontSize ?? JFontSizes.fs16,
        textScaleFactor: textScale,
      );
    }

    return Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines == null ? null : overflow,
      textScaler: TextScaler.linear(textScale),
    );
  }

  Widget _buildHtmlText({
    required String text,
    required TextStyle style,
    required double textScale,
  }) {
    return Html(
      data: text,
      style: <String, Style>{
        'html': Style(margin: Margins.zero, padding: HtmlPaddings.zero),
        'body': Style(
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
          fontFamily: style.fontFamily,
          fontSize: FontSize((style.fontSize ?? 16) * textScale),
          fontWeight: style.fontWeight,
          color: style.color,
          textAlign: textAlign,
        ),
        'p': Style(margin: Margins.zero, padding: HtmlPaddings.zero),
      },
    );
  }

  String _resolveText(BuildContext context) {
    final String? resolvedLocaleKey = localeKey?.trim();

    if (resolvedLocaleKey != null && resolvedLocaleKey.isNotEmpty) {
      final String localized = Intl.text(
        resolvedLocaleKey,
        context: context,
        args: args,
      );
      if (localized.isNotEmpty && localized != resolvedLocaleKey) {
        return localized;
      }

      final String? fallbackLocalized = AppLocalizations.fallback(
        locale: Localizations.maybeLocaleOf(context),
      ).maybeTr(resolvedLocaleKey, args: args);
      if (fallbackLocalized != null && fallbackLocalized.isNotEmpty) {
        return fallbackLocalized;
      }

      if (text != null && text!.isNotEmpty) {
        return text!;
      }

      return '';
    }

    return text ?? '';
  }
}
