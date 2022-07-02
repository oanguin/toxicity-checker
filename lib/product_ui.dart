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
            return showProductCard(null, context);
          } else {
            return showProductCard(null, context);
          }
        });
  }

  Widget showProductCard(Product? product, BuildContext context) {
    return Center(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          height: 300,
          child: product != null
              ? _showNestedProductCard(product, context)
              : _showNestedEmptyProductCard(context)),
    ));
  }

  Widget showEmptyProductCard(BuildContext context) {
    return showProductCard(null, context);
  }

  Widget _showNestedProductCard(Product product, context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  NutritionUI(ingredients: product.ingredients))),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: _generateCard(context,
            title: 'PRODUCT: ${product.productName}',
            detail: 'INGREDIENTS: ${product.ingredientsText ?? "Unknown"}',
            image: Images.showPicture(product.imageFrontSmallUrl ?? ''),
            key: "product-card"),
      ),
    );
  }

  Widget _showNestedEmptyProductCard(BuildContext context) {
    return _generateCard(context,
        title: 'Welcome to Toxic Ingredient Checker ️',
        detail:
            'Search for a product by the barcode to view detailed information about the products. Your healthier self will thank you.',
        image: Image.asset("assets/images/healthy.jpeg"),
        key: "product-card-empty");
  }

  Card _generateCard(BuildContext context,
      {required String title,
      required String detail,
      required Image image,
      required String key}) {
    return Card(
        shadowColor: const Color(0xFF69FF00),
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        key: Key(key),
        child: Column(children: <Widget>[
          ListTile(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              tileColor: const Color(0xFF375501),
              textColor: const Color(0xFF69FF00),
              title: Text(
                title,
                textAlign: TextAlign.center,
              )),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 30, left: 10, top: 10),
                child: SizedBox(
                  child: image,
                  width: 200,
                  height: 200,
                ),
              ),
              Flexible(
                  child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(detail)))
            ],
          )
        ]));
  }
}
