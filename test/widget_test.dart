// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:openfoodfacts/model/Product.dart';
import 'package:openfoodfacts/model/ProductResult.dart';
import 'package:toxicity_checker/main.dart';
import 'package:toxicity_checker/open_food_client.dart';

import 'widget_test.mocks.dart';

@GenerateMocks([OpenFoodClient])
void main() {
  testWidgets('TEST: Check if Toxicity Checker is Present',
      (WidgetTester tester) async {
    //Mocks
    final openFoodClient = MockOpenFoodClient();

    // Build our app and trigger a frame.
    await tester.pumpWidget(ToxicityChecker(openFoodClient: openFoodClient));

    // Toxicity Checker should be in the header and maybe elsewhere
    expect(find.text('Toxicity Checker'), findsWidgets);
  });

  testWidgets('TEST: Check that Barcode Input Is present',
      (WidgetTester tester) async {
    //Mocks
    final openFoodClient = MockOpenFoodClient();
    when(openFoodClient.getProduct(""))
        .thenAnswer((_) async => const ProductResult(status: 0));

    // Build our app and trigger a frame.
    await tester.pumpWidget(ToxicityChecker(openFoodClient: openFoodClient));

    // I should be able to enter text into text field with key `_txtBarCode`
    await tester.enterText(
        find.byKey(const Key("_txtBarCode")), 'Hello New Barcode');

    expect(find.text('Hello New Barcode'), findsWidgets);
  });

  testWidgets(
      'TEST: Search for barcode returns a product then the product card should be visible',
      (WidgetTester tester) async {
    //Mocks
    final openFoodClient = MockOpenFoodClient();
    when(openFoodClient.getProduct("test-product")).thenAnswer((_) async =>
        ProductResult(
            status: 1,
            product: Product(
                productName: "test-product name",
                ingredientsText: "some ingredients",
                imageFrontSmallUrl: "")));

    // Build our app and trigger a frame.
    await tester.pumpWidget(ToxicityChecker(openFoodClient: openFoodClient));

    // I should be able to enter text into text field with key `_txtBarCode`
    await tester.enterText(
        find.byKey(const Key("_txtBarCode")), 'test-product');

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    await tester.pumpAndSettle();

    verify(openFoodClient.getProduct("test-product"));
    expect(find.text('test-product'), findsOneWidget);
    await tester.ensureVisible(find.byKey(const Key("product-card")));
  });
}
