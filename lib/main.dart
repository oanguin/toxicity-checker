import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toxicity_checker/open_food_client.dart';
import 'package:toxicity_checker/product_ui.dart';

void main() {
  runApp(ToxicityChecker(
    openFoodClient: OpenFoodClient(),
  ));
}

class ToxicityChecker extends StatelessWidget {
  const ToxicityChecker({Key? key, required this.openFoodClient})
      : super(key: key);

  final OpenFoodClient openFoodClient;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toxicity Checker',
      theme: ThemeData(
          textTheme:
              GoogleFonts.expletusSansTextTheme(Theme.of(context).textTheme),
          primaryColor: const Color(0xFFF5F5F5),
          primarySwatch: Colors.lightGreen,
          backgroundColor: const Color(0xFFF5F5F5),
          appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFFF5F5F5),
              foregroundColor: Color(0xFF375501))),
      home: ToxicityMainPage(
        title: 'Toxicity Checker',
        openFoodClient: openFoodClient,
      ),
    );
  }
}

class ToxicityMainPage extends StatefulWidget {
  const ToxicityMainPage(
      {Key? key, required this.title, required this.openFoodClient})
      : super(key: key);

  final OpenFoodClient openFoodClient;
  final String title;

  @override
  State<ToxicityMainPage> createState() => _ToxicityMainPageState();
}

class _ToxicityMainPageState extends State<ToxicityMainPage> {
  final _txtBarCodeEditingController = TextEditingController();
  late String _barCode;
  late ProductUI _productUI;
  late bool showScanner = false;

  @override
  void initState() {
    super.initState();
    _barCode = '';
    _productUI = ProductUI(openFoodClient: widget.openFoodClient);
  }

  @override
  void dispose() {
    _txtBarCodeEditingController.dispose();
    super.dispose();
  }

  getBarCode() async {
    String barcode = await FlutterBarcodeScanner.scanBarcode(
        "FF69FF00", "Cancel", false, ScanMode.BARCODE);

    setState(() {
      _barCode = barcode;
      _txtBarCodeEditingController.text = _barCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Center(
                child: Column(children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: TextField(
                  autofocus: true,
                  key: const Key("_txtBarCode"),
                  controller: _txtBarCodeEditingController,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.search),
                      hintText:
                          'Please enter a barcode to begin your search...',
                      border: OutlineInputBorder()),
                  onSubmitted: (String value) async {
                    setState(() {
                      _barCode = value;
                    });
                  },
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2,
                  child: ElevatedButton(
                      onPressed: () {
                        getBarCode();
                      },
                      child: const Text('Scan Barcode')),
                ),
              ),
              _productUI.showProduct(_barCode, context),
            ])),
          ),
        ),
      ),
    );
  }
}
