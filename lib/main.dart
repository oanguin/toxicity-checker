import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toxicity_checker/open_food_client.dart';
import 'package:toxicity_checker/product_ui.dart';
import 'package:toxicity_checker/scanner_ui.dart';

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
  late TextEditingController _txtBarCodeEditingController;
  late String _barCode;
  late ProductUI _productUI;
  late ScannerUI _scannerUI;

  @override
  void initState() {
    super.initState();
    _txtBarCodeEditingController = TextEditingController();
    _barCode = '';
    _productUI = ProductUI(openFoodClient: widget.openFoodClient);
    _scannerUI = ScannerUI();
  }

  @override
  void dispose() {
    _txtBarCodeEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            TextField(
              key: const Key("_txtBarCode"),
              controller: _txtBarCodeEditingController,
              onSubmitted: (String value) async {
                _barCode = value;
                setState(() {});
              },
            ),
            _scannerUI.showBarCodeScanner(),
            _productUI.showProduct(_barCode),
          ])),
    );
  }
}
