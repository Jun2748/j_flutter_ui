import 'package:flutter/material.dart';

import '../../../localization/intl.dart';
import '../../../localization/l.dart';
import 'simple_text_field.dart';

class SimpleSearchField extends StatefulWidget {
  const SimpleSearchField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.onChanged,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
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
    return SimpleTextField(
      controller: _controller,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      hintText: _resolvedHintText(context),
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
