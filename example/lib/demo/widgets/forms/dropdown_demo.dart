import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class DropdownDemo extends StatefulWidget {
  const DropdownDemo({super.key});

  String get title => 'Dropdown';

  @override
  State<DropdownDemo> createState() => _DropdownDemoState();
}

class _DropdownDemoState extends State<DropdownDemo> {
  String? _selectedRole = '';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: widget.title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          SimpleDropdown<String>(
            value: _selectedRole,
            labelText: 'Role',
            hintText: 'Choose a role',
            items: const <DropdownMenuItem<String>>[
              DropdownMenuItem<String>(
                value: 'Designer',
                child: Text('Designer'),
              ),
              DropdownMenuItem<String>(
                value: 'Engineer',
                child: Text('Engineer'),
              ),
              DropdownMenuItem<String>(
                value: 'Product Manager',
                child: Text('Product Manager'),
              ),
            ],
            onChanged: (String? value) {
              setState(() {
                _selectedRole = value;
              });
            },
          ),
          JGaps.h16,
          SimpleText.caption(
            text: 'Selected value: ${_selectedRole ?? 'None'}',
          ),
        ],
      ),
    );
  }
}
