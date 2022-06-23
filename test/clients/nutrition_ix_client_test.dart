import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rest_client/rest_client.dart';
import 'package:toxicity_checker/clients/clients.dart';

import 'nutrition_ix_client_test.mocks.dart';

@GenerateMocks([Client, Response])
void main() {
  test("Test NutritionIX client returns water as name of food", () async {
    final client = MockClient();
    final nutritionIXClient = NutritionIX(client);
    final response = MockResponse();
    final payload = <String, dynamic>{};
    final foods = {"food_name": "water"};
    final foodsMap = [foods];
    payload.addAll({"foods": foodsMap});

    when(client.execute(request: anyNamed("request")))
        .thenAnswer((_) async => response);
    when(response.statusCode).thenReturn(200);
    when(response.body).thenReturn(payload);

    FoodData? foodData =
        await nutritionIXClient.getNutritionData(ingredient: "water");

    expect(foodData!.foodName, "water");
  });

  test(
      "Test NutritionIX client does not return null when the client request throws an exception",
      () async {
    final client = MockClient();
    final nutritionIXClient = NutritionIX(client);

    when(client.execute(request: anyNamed("request")))
        .thenThrow(Exception("Make it fail ð"));

    FoodData? foodData =
        await nutritionIXClient.getNutritionData(ingredient: "water");

    expect(foodData, isNot(null));
  });

  test(
      "Test NutritionIX client does not return null when status code from client is not 200",
      () async {
    final client = MockClient();
    final nutritionIXClient = NutritionIX(client);
    final response = MockResponse();

    when(client.execute(request: anyNamed("request")))
        .thenAnswer((_) async => response);
    when(response.statusCode).thenReturn(401);

    FoodData? foodData =
        await nutritionIXClient.getNutritionData(ingredient: "water");

    expect(foodData, isNot(null));
  });
}
