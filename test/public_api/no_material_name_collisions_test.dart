import 'package:flutter/material.dart' as m;
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

void main() {
  test('Material SimpleDialog and j_flutter_ui APIs coexist', () {
    const m.SimpleDialog(title: m.Text('Title'), children: <m.Widget>[]);
    const SimpleAlertDialog(title: 'Title', message: 'Message');
  });
}

