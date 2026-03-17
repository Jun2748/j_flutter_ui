import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class ThemeDemo extends StatelessWidget {
  const ThemeDemo({super.key});

  @override
  Widget build(BuildContext context) {
    String tr(String key) => Intl.text(key, context: context);

    return AppScaffold(
      appBar: AppBarEx(title: tr(L.demoThemeTitle)),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          Section(
            title: tr(L.demoThemeCurrentSectionTitle),
            padding: JInsets.zero,
            child: _ThemePreviewCard(
              title: tr(L.demoThemeCurrentCardTitle),
              description: tr(L.demoThemeCurrentCardDescription),
              statusLabel: tr(L.demoThemeCurrentStatus),
            ),
          ),
          JGaps.h24,
          Section(
            title: tr(L.demoThemeCustomSectionTitle),
            padding: JInsets.zero,
            child: Theme(
              data: _buildPreviewTheme(Theme.of(context)),
              child: _ThemePreviewCard(
                title: tr(L.demoThemeCustomCardTitle),
                description: tr(L.demoThemeCustomCardDescription),
                statusLabel: tr(L.demoThemeCustomStatus),
              ),
            ),
          ),
          JGaps.h24,
          Section(
            title: tr(L.demoThemeSummarySectionTitle),
            padding: JInsets.zero,
            child: SimpleCard(
              margin: EdgeInsets.zero,
              child: VStack(
                gap: JDimens.dp12,
                children: <Widget>[
                  SimpleText.body(text: tr(L.demoThemeSummaryText)),
                  SimpleText.body(text: tr(L.demoThemeSummaryButton)),
                  SimpleText.body(text: tr(L.demoThemeSummaryField)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ThemeData _buildPreviewTheme(ThemeData base) {
    final bool isDark = base.brightness == Brightness.dark;
    final Color background = isDark
        ? const Color(0xFF0F1C1F)
        : const Color(0xFFF4FBF8);
    final Color surface = isDark
        ? const Color(0xFF17262A)
        : const Color(0xFFE8F5EE);
    final Color card = isDark
        ? const Color(0xFF1D3034)
        : const Color(0xFFFFFFFF);
    final Color outline = isDark
        ? const Color(0xFF31535A)
        : const Color(0xFFB8D6CB);
    final Color divider = isDark
        ? const Color(0xFF284247)
        : const Color(0xFFD4E8DF);
    final Color primary = isDark
        ? const Color(0xFF6EE7B7)
        : const Color(0xFF0F766E);
    final Color onPrimary = isDark ? const Color(0xFF06211E) : Colors.white;
    final Color onSurface = isDark
        ? const Color(0xFFEAFBF5)
        : const Color(0xFF16312B);
    final Color onSurfaceVariant = isDark
        ? const Color(0xFFB7D7CC)
        : const Color(0xFF4B6B63);
    final Color error = isDark
        ? const Color(0xFFFDA29B)
        : const Color(0xFFB42318);
    final Color success = isDark
        ? const Color(0xFF86EFAC)
        : const Color(0xFF15803D);
    final Color warning = isDark
        ? const Color(0xFFFCD34D)
        : const Color(0xFFD97706);
    final Color info = isDark
        ? const Color(0xFF7DD3FC)
        : const Color(0xFF0369A1);
    final AppThemeTokens tokens = AppThemeTokens(
      primary: primary,
      secondary: info,
      cardBackground: card,
      cardBorderColor: outline,
      inputBackground: card,
      inputBorderColor: outline,
      dividerColor: divider,
      mutedText: onSurfaceVariant,
    );
    final ColorScheme colorScheme = base.colorScheme.copyWith(
      primary: primary,
      onPrimary: onPrimary,
      secondary: info,
      onSecondary: Colors.white,
      tertiary: success,
      onTertiary: Colors.white,
      error: error,
      onError: Colors.white,
      surface: surface,
      onSurface: onSurface,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: divider,
    );
    final TextTheme textTheme = base.textTheme.copyWith(
      displayLarge: (base.textTheme.displayLarge ?? JTextStyles.title1)
          .copyWith(color: onSurface),
      headlineLarge: (base.textTheme.headlineLarge ?? JTextStyles.heading1)
          .copyWith(color: onSurface),
      bodyLarge: (base.textTheme.bodyLarge ?? JTextStyles.body1).copyWith(
        color: onSurface,
      ),
      bodyMedium: (base.textTheme.bodyMedium ?? JTextStyles.body2).copyWith(
        color: onSurfaceVariant,
      ),
      labelSmall: (base.textTheme.labelSmall ?? JTextStyles.label).copyWith(
        color: onSurfaceVariant,
      ),
      labelLarge: (base.textTheme.labelLarge ?? JTextStyles.button).copyWith(
        color: onSurface,
      ),
    );
    final RoundedRectangleBorder previewShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(JDimens.dp20),
    );
    final List<ThemeExtension<dynamic>> extensions =
        base.extensions.values
            .where(
              (ThemeExtension<dynamic> extension) =>
                  extension is! JStatusColors && extension is! AppThemeTokens,
            )
            .toList()
          ..add(tokens)
          ..add(JStatusColors(success: success, warning: warning, info: info));

    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      dividerTheme: DividerThemeData(
        color: divider,
        space: JDimens.dp1,
        thickness: JDimens.dp1,
      ),
      disabledColor: onSurfaceVariant.withAlpha(160),
      textTheme: textTheme,
      extensions: extensions,
      cardTheme: base.cardTheme.copyWith(
        color: card,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(JDimens.dp20),
          side: BorderSide(color: outline),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: (base.elevatedButtonTheme.style ?? const ButtonStyle()).copyWith(
          shape: WidgetStatePropertyAll<OutlinedBorder>(previewShape),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: (base.outlinedButtonTheme.style ?? const ButtonStyle()).copyWith(
          shape: WidgetStatePropertyAll<OutlinedBorder>(previewShape),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: (base.textButtonTheme.style ?? const ButtonStyle()).copyWith(
          shape: WidgetStatePropertyAll<OutlinedBorder>(previewShape),
        ),
      ),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        filled: true,
        fillColor: card,
        focusedBorder: _inputBorder(
          color: primary,
          radius: JDimens.dp20,
          width: JDimens.dp1_5,
        ),
        enabledBorder: _inputBorder(color: outline, radius: JDimens.dp20),
        disabledBorder: _inputBorder(color: divider, radius: JDimens.dp20),
        errorBorder: _inputBorder(color: error, radius: JDimens.dp20),
        focusedErrorBorder: _inputBorder(
          color: error,
          radius: JDimens.dp20,
          width: JDimens.dp1_5,
        ),
      ),
    );
  }

  OutlineInputBorder _inputBorder({
    required Color color,
    required double radius,
    double width = JDimens.dp1,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}

class _ThemePreviewCard extends StatelessWidget {
  const _ThemePreviewCard({
    required this.title,
    required this.description,
    required this.statusLabel,
  });

  final String title;
  final String description;
  final String statusLabel;

  @override
  Widget build(BuildContext context) {
    String tr(String key) => Intl.text(key, context: context);
    final ThemeData theme = Theme.of(context);
    final Color success =
        theme.extension<JStatusColors>()?.success ?? theme.colorScheme.tertiary;

    return SimpleCard(
      margin: EdgeInsets.zero,
      child: VStack(
        gap: JDimens.dp20,
        children: <Widget>[
          VStack(
            gap: JDimens.dp8,
            children: <Widget>[
              SimpleText.heading(text: title),
              SimpleText.body(text: description),
            ],
          ),
          HStack(
            gap: JDimens.dp8,
            children: <Widget>[
              Icon(Icons.check_circle_outline, color: success),
              Expanded(
                child: SimpleText.caption(text: statusLabel, color: success),
              ),
            ],
          ),
          _ThemePreviewGroup(
            title: tr(L.demoThemeTextGroupTitle),
            child: VStack(
              gap: JDimens.dp8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SimpleText.title(text: tr(L.demoTextTitleSample)),
                SimpleText.caption(text: tr(L.demoTextCaptionSample)),
              ],
            ),
          ),
          _ThemePreviewGroup(
            title: tr(L.demoThemeButtonGroupTitle),
            child: VStack(
              gap: JDimens.dp12,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SimpleButton.primary(label: tr(L.commonSave), onPressed: _noop),
                SimpleButton.secondary(
                  label: tr(L.demoButtonDisabledLabel),
                  onPressed: null,
                ),
                SimpleButton.outline(
                  label: tr(L.demoButtonLoadingOutline),
                  loading: true,
                  onPressed: _noop,
                ),
              ],
            ),
          ),
          _ThemePreviewGroup(
            title: tr(L.demoThemeFieldGroupTitle),
            child: VStack(
              gap: JDimens.dp12,
              children: <Widget>[
                SimpleTextField(
                  labelText: tr(L.commonName),
                  hintText: tr(L.demoThemeFieldHint),
                  helperText: tr(L.demoThemeFieldHelper),
                ),
                SimpleTextField(
                  labelText: tr(L.commonName),
                  hintText: tr(L.demoThemeFieldHint),
                  helperText: tr(L.demoTextFieldDisabledHelper),
                  enabled: false,
                ),
                SimpleTextField(
                  labelText: tr(L.commonName),
                  hintText: tr(L.demoThemeFieldHint),
                  errorText: tr(L.demoThemeFieldError),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void _noop() {}
}

class _ThemePreviewGroup extends StatelessWidget {
  const _ThemePreviewGroup({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return VStack(
      gap: JDimens.dp8,
      children: <Widget>[
        SimpleText.label(text: title, weight: FontWeight.w600),
        child,
      ],
    );
  }
}
