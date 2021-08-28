import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

enum DpadKey {
  selectKey, //keycode 2
  startKey, //key code 3
  upKey,
  downKet,
  leftKey,
  rightKey,
  lKey,
  rKey,
  bKey,
  yKey,
  aKey,
  xKey,
}

extension ToKeyCode on DpadKey {
  int toSnesKeyCode() {
    switch (this) {
      case DpadKey.selectKey:
        return 2;
      case DpadKey.startKey:
        return 3;
      default:
    }
    return -1;
  }
}

class DpadController {
  InAppWebViewController? _webController;
  void setActivedWebController(InAppWebViewController newController) {
    _webController = newController;
  }

  void pauseOrResumeSnes() {
    checkSnesController();
    _webController?.callAsyncJavaScript(functionBody: "pauseGame();");
  }

  void pressKey(DpadKey key) {
    checkSnesController();
    print("pressDown(${key.toSnesKeyCode()});");
    _webController?.callAsyncJavaScript(
        functionBody: "pressDown(${key.toSnesKeyCode()});");
    Future.delayed(Duration(milliseconds: 200), () {
      releaseKey(key);
    });
  }

  void releaseKey(DpadKey key) {
    checkSnesController();
    print("releaseUp(${key.toSnesKeyCode()});");
    _webController?.callAsyncJavaScript(
        functionBody: "releaseUp(${key.toSnesKeyCode()});");
  }

  void checkSnesController() {
    if (_webController == null) {
      print("[SNES][ERROR]: the controller is not ready!!!");
    }
  }
}

class SnesJSWidget extends StatefulWidget {
  final String urlOfGame;
  ValueChanged<DpadController> controllerCompleted;
  SnesJSWidget(
      {Key? key, required this.urlOfGame, required this.controllerCompleted})
      : super(key: key);

  @override
  _SnesJSWidgetState createState() => _SnesJSWidgetState();
}

class _SnesJSWidgetState extends State<SnesJSWidget> {
  DpadController controllerOfSnes = DpadController();
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: AspectRatio(
          aspectRatio: 540 / 480,
          child: InAppWebView(
            initialUrlRequest: URLRequest(
              url: Uri.parse(
                  "http://localhost:8080/assets/SnesJs/index.html?gameURL=${widget.urlOfGame}"),
            ),
            initialOptions: options,
            onWebViewCreated: (controller) {},
            onLoadStart: (controller, url) {},
            onLoadStop: (controller, url) {
              controllerOfSnes.setActivedWebController(controller);
              widget.controllerCompleted(controllerOfSnes);
            },
            onConsoleMessage: (controller, messase) {
              print(messase);
            },
          ),
        ),
      ),
    );
  }
}
///file:///C:/Users/Na%20Ngo/Desktop/current_project/snes_snimulator_flutter/assets/SnesJs/index.html?gameURL=https://nielsezeka.github.io/data/Super_Mario_World.smc