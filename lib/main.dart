import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:toxicity_checker/open_food_client.dart';
import 'package:toxicity_checker/product_ui.dart';

import 'ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    MobileAds.instance.initialize();
  }

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

  reset() {
    setState(() {
      _barCode = "";
      _txtBarCodeEditingController.text = _barCode;
    });
  }

  adBanner() {
    if (kIsWeb) return const SizedBox.shrink();

    return SizedBox(
      width: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.width * 2
          : MediaQuery.of(context).size.width / 2,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Center(
          child: SizedBox(height: 50, child: AdsManager()),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Center(
                child: Column(children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                        key: const Key("clearIcon"),
                        onPressed: () => {reset()},
                        tooltip: "Reset product search",
                        icon: const Icon(Icons.sync_outlined)),
                  )
                ],
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
              AnimatedCrossFade(
                crossFadeState: _barCode.isEmpty
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(seconds: 2),
                firstChild: _productUI.showProduct(_barCode, context),
                secondChild: _productUI.showEmptyProductCard(context),
                secondCurve: Curves.slowMiddle,
              ),
              adBanner()
            ])),
          ),
        ),
      ),
    );
  }
}
