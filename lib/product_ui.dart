import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/Product.dart';
import 'package:openfoodfacts/model/ProductResult.dart';

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
      print("Error retrieving the product : ${exception}");
      return null;
    } finally {
      _searching = false;
    }
  }

  Widget showProduct(barCode) {
    return FutureBuilder(
        future: displayProduct(barCode),
        builder:
            (BuildContext context, AsyncSnapshot<ProductResult?> snapshot) {
          if (snapshot.hasData) {
            return showProductCard(snapshot.data?.product);
          } else if (_searching) {
            return const CircularProgressIndicator();
          } else {
            return const Text('Please Enter a Barcode to start the search...');
          }
        });
  }

  Widget showProductCard(Product? product) {
    if (product == null) {
      return const Text('Sorry product not found...');
    }

    return Center(
        child: Card(
            key: const Key("product-card"),
            child: Column(children: <Widget>[
              ListTile(
                  tileColor: const Color(0xFF375501),
                  textColor: const Color(0xFF69FF00),
                  title: Text('PRODUCT: ${product.productName}')),
              Row(
                children: [
                  showPicture(product.imageFrontSmallUrl ?? ''),
                  Flexible(
                      child: Text('INGEDIENTS: ${product.ingredientsText}'))
                ],
              )
            ])));
  }

  Widget showPicture(String url) {
    if (url.isEmpty) {
      return Text('Sorry No Image');
    } else {
      try {
        return Image(image: NetworkImage(url));
      } catch (exception) {
        return Text('Sorry No Image');
      }
    }
  }
}
