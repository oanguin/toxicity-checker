class FoodData {
  late String foodName;
  late double calories;
  late double totalFat;
  late double saturatedFat;
  late int cholesterol;
  late double sodium;
  late double carbohydrate;
  late double dietaryFiber;
  late double sugars;
  late double protein;
  late double potassium;
  late String photoHiRes;
  late String photoThumb;

  //This value is related if the data for the ingredient was found
  late bool dataFound;

  FoodData(
      this.foodName,
      this.calories,
      this.totalFat,
      this.saturatedFat,
      this.cholesterol,
      this.sodium,
      this.carbohydrate,
      this.dietaryFiber,
      this.sugars,
      this.protein,
      this.potassium,
      this.photoHiRes,
      this.photoThumb,
      this.dataFound);
}
