import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SnesJSWidget extends StatefulWidget {
  final String urlOfGame;
  ValueChanged<InAppWebViewController> controllerCompleted;
  SnesJSWidget(
      {Key? key, required this.urlOfGame, required this.controllerCompleted})
      : super(key: key);

  @override
  _SnesJSWidgetState createState() => _SnesJSWidgetState();
}

class _SnesJSWidgetState extends State<SnesJSWidget> {
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
              widget.controllerCompleted(controller);
            },
          ),
        ),
      ),
    );
  }
}
///file:///C:/Users/Na%20Ngo/Desktop/current_project/snes_snimulator_flutter/assets/SnesJs/index.html?gameURL=https://nielsezeka.github.io/data/Super_Mario_World.smc