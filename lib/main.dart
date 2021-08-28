import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:snes_snimulator_flutter/snes_js_widget/snes_game_pad/snes_left_pad_default/snes_left_pad_default.dart';
import 'package:snes_snimulator_flutter/snes_js_widget/snes_game_pad/snes_right_pad_default/snes_right_pad_default.dart';
import 'package:snes_snimulator_flutter/snes_js_widget/snes_machine.dart';

final InAppLocalhostServer localhostServer = new InAppLocalhostServer();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await localhostServer.start();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
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
        child: SafeArea(
          child: SnesMachine(
            leftDpad: SnesLeftPadDefault(),
            rightDpad: SnesRightPadDefault(),
            linkToRoom:
                'https://nielsezeka.github.io/data/Super_Mario_World.smc',
          ),

          // SnesMachine.defaultSnes(
          //   linkToRoom:
          //       'https://nielsezeka.github.io/data/Super_Mario_World.smc',
          // ),
        ),
      ),
    );
  }
}
