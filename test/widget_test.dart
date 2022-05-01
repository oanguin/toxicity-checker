// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toxicity_checker/main.dart';

void main() {
  testWidgets('TEST: Check if Toxicity Checker is Present',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ToxicityChecker());

    // Toxicity Checker should be in the header and maybe elsewhere
    expect(find.text('Toxicity Checker'), findsWidgets);
  });

  testWidgets('TEST: Check that Barcode Input Is present',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ToxicityChecker());

    // I should be able to enter text into text field with key `_txtBarCode`
    await tester.enterText(
        find.byKey(const Key("_txtBarCode")), 'Hello New Barcode');

    expect(find.text('Hello New Barcode'), findsWidgets);
  });
}
