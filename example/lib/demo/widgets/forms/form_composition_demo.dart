import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class FormCompositionDemo extends StatelessWidget {
  const FormCompositionDemo({super.key});

  String get title => 'Form Composition';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          SimpleForm(
            child: FormSection(
              title: 'Personal Information',
              description:
                  'This demo shows how SimpleForm, FormSection, and FormFieldWrapper work together.',
              action: SimpleButton.text(label: 'Save', onPressed: () {}),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  FormFieldWrapper(
                    label: 'Full Name',
                    required: true,
                    helperText: 'Use your legal name.',
                    child: SimpleTextField(
                      hintText: 'Enter full name',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                  ),
                  JGaps.h16,
                  FormFieldWrapper(
                    label: 'Email',
                    child: SimpleTextField(
                      hintText: 'name@example.com',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                  JGaps.h16,
                  FormFieldWrapper(
                    label: 'Role',
                    helperText: 'Select the most relevant role.',
                    child: SimpleDropdown<String>(
                      hintText: 'Choose role',
                      items: <DropdownMenuItem<String>>[
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
