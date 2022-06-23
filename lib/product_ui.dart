import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/Product.dart';
import 'package:openfoodfacts/model/ProductResult.dart';
import 'package:toxicity_checker/utilities/images.dart';

import 'nutrition_ui.dart';
import 'open_food_client.dart';

class ProductUI {
  late bool _searching = false;
  late OpenFoodClient openFoodClient;

  ProductUI({required this.openFoodClient});

  Future<ProductResult?> displayProduct(String barCode) async {
    _searching = true;
    try {
      if (barCode.isEmpty) {
        return null;
      }
      final ProductResult result = await openFoodClient.getProduct(barCode);

      if (result.status != 1) {
        return null;
      }

      return result;
    } catch (exception) {
      return null;
    } finally {
      _searching = false;
    }
  }

  Widget showProduct(String barCode, BuildContext context) {
    return FutureBuilder(
        future: displayProduct(barCode),
        builder:
            (BuildContext context, AsyncSnapshot<ProductResult?> snapshot) {
          if (barCode.isNotEmpty && snapshot.hasData) {
            return showProductCard(snapshot.data?.product, context);
          } else if (_searching) {
            return const CircularProgressIndicator();
          } else {
            return const SizedBox.shrink();
          }
        });
  }

  Widget showProductCard(Product? product, BuildContext context) {
    if (product == null) {
      return const Text('Sorry product not found...🤕');
    }

    return Center(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.65,
        child: GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NutritionUI(ingredients: product.ingredients))),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          NutritionUI(ingredients: product.ingredients))),
              child: Card(
                  key: const Key("product-card"),
                  child: Column(children: <Widget>[
                    ListTile(
                        tileColor: const Color(0xFF375501),
                        textColor: const Color(0xFF69FF00),
                        title: Text('PRODUCT: ${product.productName}')),
                    Row(
                      children: [
                        Images.showPicture(product.imageFrontSmallUrl ?? ''),
                        Flexible(
                            child:
                                Text('INGREDIENTS: ${product.ingredientsText}'))
                      ],
                    )
                  ])),
            ),
          ),
        ),
      ),
    ));
  }
}
