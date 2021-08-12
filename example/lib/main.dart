import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gradient_line_graph/gradient_line_graph.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Gradient Line Graph'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double downloadRate = 0;
  double downloadProgress = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      download();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: GradientLineGraphView(
                min: 0,
                max: 100,
                value: downloadRate,
                precentage: downloadProgress,
                color: Color(0xFF4cbdbb).withOpacity(0.7),
                duration: Duration(milliseconds: 0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future download() async {
    setState(() {
      downloadProgress = 0;
      downloadRate = 40;
    });

    Timer.periodic(new Duration(milliseconds: 500), (timer) {
      print('current downloadProgress: $downloadProgress');
      print('current downloadRate: $downloadRate');

      if (downloadProgress >= 99) {
        timer.cancel();
      }

      var generated = generateRandom(30, 80).toDouble();
      goToDownloadValue(generated);
    });
  }

  void goToDownloadValue(value) {
    var valueToAdd = (value - downloadRate) / 10;
    var counter = 0;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (counter == 9 || downloadRate == value) {
        timer.cancel();
      }

      counter++;
      setState(() {
        downloadRate += valueToAdd;
        downloadProgress += 0.5;
      });
    });
  }

  int generateRandom(int min, int max) {
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }
}
