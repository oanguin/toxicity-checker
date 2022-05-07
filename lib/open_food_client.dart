import 'package:openfoodfacts/openfoodfacts.dart';

class OpenFoodClient {
  Future<ProductResult> getProduct(String barCode) {
    return OpenFoodAPIClient.getProductRaw(
        barCode, OpenFoodFactsLanguage.ENGLISH);
  }
}
