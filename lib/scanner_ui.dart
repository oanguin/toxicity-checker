import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScannerUI {
  var scannedBarcode = "";

  Widget showBarCodeScanner() {
    return FutureBuilder(
        future: _getBarCode(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            scannedBarcode = snapshot.data!;

            return ListView(children: <Widget>[
              const Text('We have found the product.'),
              ElevatedButton(
                  onPressed: () {
                    _getBarCode();
                  },
                  child: const Text('Rescan'))
            ]);
          } else {
            return const Text('Please scan for a product.');
          }
        });
  }

  Future<String> _getBarCode() async {
    return await FlutterBarcodeScanner.scanBarcode(
        "FF69FF00", "Select here to cancel...", false, ScanMode.BARCODE);
  }
}
