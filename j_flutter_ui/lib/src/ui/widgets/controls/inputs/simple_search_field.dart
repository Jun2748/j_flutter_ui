import 'package:flutter/material.dart';

class SimpleSearchField extends StatefulWidget {
  const SimpleSearchField({
    super.key,
    this.controller,
    this.hintText = 'Search',
    this.onChanged,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final String hintText;
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
    return TextField(
      controller: _controller,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
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
      ),
    );
  }

  void _handleTextChanged() {
    setState(() {});
  }
}
