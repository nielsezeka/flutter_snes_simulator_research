import 'package:flutter/material.dart';
import 'package:snes_snimulator_flutter/snes_js_widget/snes_game_pad/snes_left_pad_default/snes_left_pad_default.dart';
import 'package:snes_snimulator_flutter/snes_js_widget/snes_screen/snes_js_widget.dart';

import 'snes_game_pad/snes_game_pad.dart';

class SnesMachine extends StatefulWidget {
  final Widget leftDpad;
  final Widget rightDpad;
  SnesMachine({
    Key? key,
    required this.leftDpad,
    required this.rightDpad,
  }) : super(key: key);

  @override
  _SnesMachineState createState() => _SnesMachineState();
  SnesMachine.defaultSnes()
      : leftDpad = SnesLeftPadDefault(),
        rightDpad = SnesLeftPadDefault();
}

class _SnesMachineState extends State<SnesMachine> {
  DpadController? myDpad;
  @override
  Widget build(BuildContext context) {
    return SnesController(
      controller: myDpad,
      child: Row(
        children: [
          Expanded(child: widget.leftDpad),
          SnesJSWidget(
            urlOfGame:
                'https://nielsezeka.github.io/data/Super_Mario_World.smc',
            controllerCompleted: (controller) {
              setState(() {
                myDpad = controller;
              });
            },
          ),
          Expanded(child: widget.rightDpad),
        ],
      ),
    );
  }
}
