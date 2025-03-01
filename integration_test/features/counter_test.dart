// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../test/njw_bdd_steps/the_app_is_running.dart';
import 'package:bdd_widget_test/step/i_see_text.dart';
import 'package:bdd_widget_test/step/i_tap_icon.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('''Counter''', () {
    testWidgets('''Initial counter value is 0''', (tester) async {
      await theAppIsRunning(tester);
      await iSeeText(tester, '0');
    });
    testWidgets('''Plus button increases the counter''', (tester) async {
      await theAppIsRunning(tester);
      await iTapIcon(tester, Icons.add);
      await iSeeText(tester, '1');
    });
  });
}
