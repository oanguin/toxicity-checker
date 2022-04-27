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
      home: const ToxictyMainPage(title: 'Toxicity Checker'),
    );
  }
}

class ToxictyMainPage extends StatefulWidget {
  const ToxictyMainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ToxictyMainPage> createState() => _ToxictyMainPageState();
}

class _ToxictyMainPageState extends State<ToxictyMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text(widget.title)])),
    );
  }
}
