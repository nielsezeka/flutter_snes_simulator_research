import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:snes_snimulator_flutter/snes_js_widget/snes_js_widget.dart';

final InAppLocalhostServer localhostServer = new InAppLocalhostServer();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await localhostServer.start();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  InAppWebViewController? myController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: Colors.black,
                child: Column(
                  children: [
                    CupertinoButton(
                      child: Container(
                        width: 100,
                        height: 50,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        myController?.callAsyncJavaScript(
                            functionBody: "pauseGame();");
                      },
                    )
                  ],
                ),
              ),
            ),
            SnesJSWidget(
              urlOfGame:
                  'https://nielsezeka.github.io/data/Super_Mario_World.smc',
              controllerCompleted: (controller) => myController = controller,
            ),
            // Expanded(
            //   child: Container(
            //     color: Colors.blue,
            //   ),
            // ),
            Expanded(
                child: Container(
              color: Colors.black,
            )),
          ],
        ),
      ),
    );
  }
}
