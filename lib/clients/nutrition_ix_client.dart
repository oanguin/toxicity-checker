import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:rest_client/rest_client.dart';
import 'package:toxicity_checker/clients/models/food_data.dart';

class NutritionIX {
  late final Client _restClient;

  NutritionIX(this._restClient);

  Map<String, String> _headers() {
    return {
      "Content-Type": "application/json",
      "x-app-id": const String.fromEnvironment('NUTRITIONIX_APP_ID',
          defaultValue: "27c34f98"),
      "x-app-key": const String.fromEnvironment('NUTRITIONIX_APP_KEY',
          defaultValue: "eb9f49bcb5a1bd63a9fe2f5402989664"),
      "x-remote-user-id":
          const String.fromEnvironment('NUTRITIONIX_USER_ID', defaultValue: "0")
    };
  }

  Future<FoodData?> getNutritionData({required String ingredient}) async {
    try {
      if (kDebugMode) {
        return _generateTestFoodData(ingredient);
      }

      var request = Request(
          url: const String.fromEnvironment('NUTRITIONIX_URL',
              defaultValue:
                  "https://trackapi.nutritionix.com/v2/natural/nutrients"),
          headers: _headers(),
          method: RequestMethod.post,
          body: '{"query": "$ingredient"}');

      var response = await _restClient.execute(request: request);

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to get data received status code ${response.statusCode} with payload ${response.body.toString()}');
      }

      var bodyPayload = response.body as Map<String, dynamic>;

      var foodDataPayload = bodyPayload["foods"][0];

      var foodName = foodDataPayload["food_name"];
      var calories = foodDataPayload["nf_calories"];
      var totalFat = foodDataPayload["nf_total_fat"];
      var saturatedFat = foodDataPayload["nf_saturated_fat"];
      var cholesterol = foodDataPayload["nf_cholesterol"];
      var sodium = foodDataPayload["nf_sodium"];
      var carbohydrate = foodDataPayload["nf_total_carbohydrate"];
      var dietaryFiber = foodDataPayload["nf_dietary_fiber"];
      var sugars = foodDataPayload["nf_sugars"];
      var protein = foodDataPayload["nf_protein"];
      var potassium = foodDataPayload["nf_potassium"];

      String? photoHiRes;
      String? photoThumb;
      if (foodDataPayload["photo"] != null) {
        var photos = foodDataPayload["photo"] as Map<String, dynamic>;
        photoHiRes = photos["highres"];
        photoThumb = photos["thumb"];
      }

      var foodData = FoodData(
          foodName ?? "",
          calories ?? 0,
          totalFat ?? 0,
          saturatedFat ?? 0,
          cholesterol ?? 0,
          sodium ?? 0,
          carbohydrate ?? 0,
          dietaryFiber ?? 0,
          sugars ?? 0,
          protein ?? 0,
          potassium ?? 0,
          photoHiRes ?? "",
          photoThumb ?? "",
          true);

      return foodData;
    } catch (exception) {
      log(exception.toString());
      return FoodData(ingredient, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", "", false);
    }
  }

  FoodData _generateTestFoodData(String ingredient) {
    return FoodData(
        ingredient,
        2,
        1.2,
        0.4,
        3,
        0.09,
        0.008,
        0.001,
        0.001,
        0.003,
        0.002,
        "https://www.foodnavigator.com/var/wrbm_gb_food_pharma/storage/images/9/0/8/1/2321809-1-eng-GB/Quiet-salt-reduction-is-vital-but-gourmet-salt-growth-may-stifle-industry-efforts.jpg",
        "https://www.foodnavigator.com/var/wrbm_gb_food_pharma/storage/images/9/0/8/1/2321809-1-eng-GB/Quiet-salt-reduction-is-vital-but-gourmet-salt-growth-may-stifle-industry-efforts.jpg",
        true);
  }
}
