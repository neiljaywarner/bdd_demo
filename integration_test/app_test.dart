import 'package:bdd_demo/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter',
        (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.text('0'), findsOneWidget);
      final fab = find.byIcon(Icons.add);
      await tester.tap(fab);
      await tester.pumpAndSettle();
      expect(find.text('1'), findsOneWidget);
    });
  });
}