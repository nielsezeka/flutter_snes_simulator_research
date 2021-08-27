import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SnesJSWidget extends StatefulWidget {
  const SnesJSWidget({Key? key}) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('InAppLocalhostServer Example'),
      ),
      body: Container(
        color: Colors.red,
        child: Column(
          children: <Widget>[
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse(
                      "http://localhost:8080/assets/SnesJs/index.html"),
                ),
                initialOptions: options,
                onWebViewCreated: (controller) {},
                onLoadStart: (controller, url) {},
                onLoadStop: (controller, url) {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
