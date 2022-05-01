import 'package:flutter/material.dart';

void main() {
  runApp(const ToxicityChecker());
}

class ToxicityChecker extends StatelessWidget {
  const ToxicityChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toxicity Checker',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ToxicityMainPage(title: 'Toxicity Checker'),
    );
  }
}

class ToxicityMainPage extends StatefulWidget {
  const ToxicityMainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ToxicityMainPage> createState() => _ToxicityMainPageState();
}

class _ToxicityMainPageState extends State<ToxicityMainPage> {
  late TextEditingController _txtBarCodeEditingController;
  late String _barCode;

  @override
  void initState() {
    super.initState();
    _txtBarCodeEditingController = TextEditingController();
    _barCode = '';
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
              onSubmitted: (String value) {
                _barCode = value;
                setState(() {});
              },
            ),
            Text(_barCode),
          ])),
    );
  }
}
