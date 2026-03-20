import 'package:flutter/material.dart';

import '../../../localization/intl.dart';
import '../../../localization/l.dart';
import '../../../resources/app_theme_tokens.dart';
import '../../../resources/dimens.dart';
import 'simple_text_field.dart';

enum SimpleSearchFieldVariant { standard, quiet }

class SimpleSearchField extends StatefulWidget {
  const SimpleSearchField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.variant = SimpleSearchFieldVariant.standard,
    this.fillColor,
    this.borderColor,
    this.onChanged,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final SimpleSearchFieldVariant variant;
  final Color? fillColor;
  final Color? borderColor;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  @override
  State<SimpleSearchField> createState() => _SimpleSearchFieldState();
}

class _SimpleSearchFieldState extends State<SimpleSearchField> {
  TextEditingController? _ownedController;

  TextEditingController get _controller {
    return widget.controller ?? _ensureOwnedController();
  }

  @override
  void initState() {
    super.initState();
    _attachController(_controller);
  }

  @override
  void didUpdateWidget(SimpleSearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller == widget.controller) {
      return;
    }

    final TextEditingController oldController =
        oldWidget.controller ?? _ensureOwnedController();
    _detachController(oldController);

    if (oldWidget.controller == null && widget.controller != null) {
      _ownedController?.dispose();
      _ownedController = null;
    }

    if (widget.controller == null && oldWidget.controller != null) {
      _ownedController = TextEditingController(
        text: oldWidget.controller?.text ?? '',
      );
    }

    _attachController(_controller);
    setState(() {});
  }

  @override
  void dispose() {
    _detachController(_controller);
    _ownedController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color? resolvedFillColor =
        widget.variant == SimpleSearchFieldVariant.quiet
        ? _resolvedQuietFillColor(theme)
        : widget.fillColor;
    final Color? resolvedBorderColor =
        widget.variant == SimpleSearchFieldVariant.quiet
        ? _resolvedQuietBorderColor(theme)
        : widget.borderColor;
    final Widget field = SimpleTextField(
      controller: _controller,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      hintText: _resolvedHintText(context),
      fillColor: resolvedFillColor,
      borderColor: resolvedBorderColor,
      prefixIcon: const Icon(Icons.search),
      suffixIcon: _controller.text.isEmpty
          ? null
          : IconButton(
              onPressed: widget.enabled
                  ? () {
                      _controller.clear();
                      widget.onChanged?.call('');
                    }
                  : null,
              icon: const Icon(Icons.close),
            ),
    );

    if (widget.variant != SimpleSearchFieldVariant.quiet) {
      return field;
    }

    return Theme(
      data: theme.copyWith(
        inputDecorationTheme: _quietInputDecorationTheme(context, theme),
      ),
      child: field,
    );
  }

  void _handleTextChanged() {
    setState(() {});
  }

  void _attachController(TextEditingController controller) {
    controller.addListener(_handleTextChanged);
  }

  void _detachController(TextEditingController controller) {
    controller.removeListener(_handleTextChanged);
  }

  TextEditingController _ensureOwnedController() {
    return _ownedController ??= TextEditingController();
  }

  InputDecorationThemeData _quietInputDecorationTheme(
    BuildContext context,
    ThemeData theme,
  ) {
    final SearchBarThemeData searchBarTheme = theme.searchBarTheme;
    final Set<WidgetState> states = _searchBarStates();
    final BorderRadius quietBorderRadius = _resolvedQuietBorderRadius(
      context,
      searchBarTheme.shape?.resolve(states),
    );
    final BorderSide enabledSide =
        searchBarTheme.side?.resolve(states) ??
        BorderSide(color: Colors.transparent, width: JDimens.dp1);
    final InputBorder? baseBorder =
        theme.inputDecorationTheme.border ??
        theme.inputDecorationTheme.enabledBorder ??
        theme.inputDecorationTheme.focusedBorder ??
        theme.inputDecorationTheme.disabledBorder ??
        theme.inputDecorationTheme.errorBorder ??
        theme.inputDecorationTheme.focusedErrorBorder;
    final OutlineInputBorder quietBorder = _quietBorder(
      baseBorder,
      borderRadius: quietBorderRadius,
      side: enabledSide,
    );

    return theme.inputDecorationTheme.copyWith(
      border: quietBorder,
      enabledBorder: quietBorder,
      focusedBorder: quietBorder,
      disabledBorder: quietBorder,
      errorBorder: quietBorder,
      focusedErrorBorder: quietBorder,
    );
  }

  Color _resolvedQuietFillColor(ThemeData theme) {
    final SearchBarThemeData searchBarTheme = theme.searchBarTheme;
    return widget.fillColor ??
        searchBarTheme.backgroundColor?.resolve(_searchBarStates()) ??
        theme.appThemeTokens.inputBackground;
  }

  Color _resolvedQuietBorderColor(ThemeData theme) {
    final SearchBarThemeData searchBarTheme = theme.searchBarTheme;
    return widget.borderColor ??
        searchBarTheme.side?.resolve(_searchBarStates())?.color ??
        Colors.transparent;
  }

  Set<WidgetState> _searchBarStates() {
    return <WidgetState>{if (!widget.enabled) WidgetState.disabled};
  }

  BorderRadius _resolvedQuietBorderRadius(
    BuildContext context,
    OutlinedBorder? searchBarShape,
  ) {
    if (searchBarShape is StadiumBorder) {
      return BorderRadius.circular(JHeights.input / 2);
    }

    if (searchBarShape is RoundedRectangleBorder) {
      return searchBarShape.borderRadius.resolve(Directionality.of(context));
    }

    if (searchBarShape is ContinuousRectangleBorder) {
      return searchBarShape.borderRadius.resolve(Directionality.of(context));
    }

    return BorderRadius.circular(JHeights.input / 2);
  }

  OutlineInputBorder _quietBorder(
    InputBorder? base, {
    required BorderRadius borderRadius,
    required BorderSide side,
  }) {
    final OutlineInputBorder? outlineBase = base is OutlineInputBorder
        ? base
        : null;

    return OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide:
          outlineBase?.borderSide.copyWith(
            color: side.color,
            width: side.width,
            style: side.style,
          ) ??
          side,
      gapPadding: outlineBase?.gapPadding ?? JDimens.dp4,
    );
  }

  String _resolvedHintText(BuildContext context) {
    final String? customHint = widget.hintText?.trim();
    if (customHint != null && customHint.isNotEmpty) {
      return customHint;
    }

    return _localizedText(L.commonSearch, context: context, fallback: 'Search');
  }

  String _localizedText(
    String key, {
    required BuildContext context,
    required String fallback,
  }) {
    final String localized = Intl.text(key, context: context);
    if (localized.isEmpty || localized == key) {
      return fallback;
    }
    return localized;
  }
}
