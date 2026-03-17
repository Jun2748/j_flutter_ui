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
  late final TextEditingController _controller =
      widget.controller ?? TextEditingController();

  bool get _ownsController => widget.controller == null;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChanged);
    if (_ownsController) {
      _controller.dispose();
    }
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

  String _resolvedHintText(BuildContext context) {
    final String? customHint = widget.hintText?.trim();
    if (customHint != null && customHint.isNotEmpty) {
      return customHint;
    }

    final String localizedHint = Intl.text(L.commonSearch, context: context);
    return localizedHint == L.commonSearch ? 'Search' : localizedHint;
  }
}
