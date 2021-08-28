import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snes_snimulator_flutter/snes_js_widget/snes_screen/snes_js_widget.dart';
import '../snes_game_pad.dart';

class SnesLeftPadDefault extends StatefulWidget {
  const SnesLeftPadDefault({Key? key}) : super(key: key);

  @override
  _SnesLeftPadDefaultState createState() => _SnesLeftPadDefaultState();
}

class _SnesLeftPadDefaultState extends State<SnesLeftPadDefault> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                color: Colors.amber,
                child: CupertinoButton(
                  child: Container(
                    height: 50,
                  ),
                  onPressed: () {
                    SnesController.of(context).controller?.pauseOrResumeSnes();
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.green,
                child: CupertinoButton(
                  child: Container(
                    height: 50,
                  ),
                  onPressed: () {
                    SnesController.of(context)
                        .controller
                        ?.pressKey(DpadKey.selectKey);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
