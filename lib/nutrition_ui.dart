import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/Ingredient.dart';
import 'package:rest_client/rest_client.dart';
import 'package:toxicity_checker/clients/clients.dart';
import 'package:toxicity_checker/utilities/images.dart';

class NutritionUI extends StatefulWidget {
  const NutritionUI({Key? key, required this.ingredients}) : super(key: key);

  final List<Ingredient>? ingredients;
  @override
  State<NutritionUI> createState() => _NutritionUIState();
}

class _NutritionUIState extends State<NutritionUI> {
  final NutritionIX _nutritionIXClient = NutritionIX(Client());
  late bool _searching = false;
  late final Map<String, FoodData?> foodDataMap = {};

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text("Nutrition Data")),
        body: showBody());
  }

  Widget showBody() {
    if (widget.ingredients != null) {
      return PageView.builder(
        itemBuilder: pageView,
        itemCount: widget.ingredients?.length,
      );
    } else {
      return const Text("Sorry we did not find any ingredients!");
    }
  }

  Widget pageView(BuildContext context, int index) {
    var ingredient = widget.ingredients?[index].text;
    return pageBuilder(ingredient);
  }

  Future<FoodData?> getFoodData(String? ingredient) async {
    if (ingredient == null) {
      return null;
    }

    if (foodDataMap.containsKey(ingredient)) {
      return foodDataMap[ingredient];
    }

    _searching = true;
    var result =
        await _nutritionIXClient.getNutritionData(ingredient: ingredient);
    foodDataMap[ingredient] = result;
    _searching = false;
    return result;
  }

  Widget pageBuilder(String? ingredient) {
    return ingredient != null
        ? FutureBuilder(
            future: getFoodData(ingredient),
            builder: (BuildContext context, AsyncSnapshot<FoodData?> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  return _generateNutritionFactTable(snapshot.data!);
                } else {
                  return const Text("Unknown");
                }
              } else if (_searching) {
                return Container(
                  alignment: Alignment.center,
                  child: const SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator()),
                );
              } else {
                return const SizedBox.shrink();
              }
            })
        : const Text("Unknown Ingredient");
  }

  Widget _generateNutritionFactTable(FoodData foodData) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: SizedBox(
            width: MediaQuery.of(context).size.width > 900
                ? MediaQuery.of(context).size.width * (1 / 3)
                : MediaQuery.of(context).size.width * (3 / 4),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(20.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _paddedContainer(Text(
                    "Nutrition Facts for ${foodData.foodName}",
                    textAlign: TextAlign.left,
                    textScaleFactor: 1.4,
                  )),
                  const Divider(
                    color: Colors.black,
                    thickness: 8,
                  ),
                  _paddedContainer(Images.showPicture(foodData.photoThumb)),
                  _paddedContainer(Text("Calories ${foodData.calories}")),
                  _paddedContainer(Text("Total Fat ${foodData.totalFat}g")),
                  _paddedContainer(
                      Text("Saturated Fat ${foodData.saturatedFat}g")),
                  _paddedContainer(
                      Text("Cholesterol ${foodData.cholesterol}mg")),
                  _paddedContainer(Text("Sodium ${foodData.sodium}mg")),
                  _paddedContainer(
                      Text("Carbohydrates ${foodData.carbohydrate}g")),
                  _paddedContainer(
                      Text("Dietary Fiber ${foodData.dietaryFiber}g")),
                  _paddedContainer(Text("Sugars ${foodData.sugars}g")),
                  _paddedContainer(Text("Protein ${foodData.protein}g")),
                  _paddedContainer(Text("Potassium ${foodData.potassium}mg")),
                ],
              ),
            ),
          )),
    );
  }

  Widget _paddedContainer(Widget widget) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: widget,
    );
  }
}
