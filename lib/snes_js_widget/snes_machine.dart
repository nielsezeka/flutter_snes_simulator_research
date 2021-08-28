import 'package:flutter/material.dart';
import 'package:snes_snimulator_flutter/snes_js_widget/snes_game_pad/snes_left_pad_default/snes_left_pad_default.dart';
import 'package:snes_snimulator_flutter/snes_js_widget/snes_game_pad/snes_right_pad_default/snes_right_pad_default.dart';
import 'package:snes_snimulator_flutter/snes_js_widget/snes_screen/snes_js_widget.dart';

import 'snes_game_pad/snes_game_pad.dart';

class SnesMachine extends StatefulWidget {
  final Widget leftDpad;
  final Widget rightDpad;
  final String linkToRoom;
  SnesMachine({
    Key? key,
    required this.leftDpad,
    required this.rightDpad,
    required this.linkToRoom,
  }) : super(key: key);

  @override
  _SnesMachineState createState() => _SnesMachineState();
  SnesMachine.defaultSnes({required this.linkToRoom})
      : leftDpad = SnesLeftPadDefault(),
        rightDpad = SnesRightPadDefault();
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
            urlOfGame: widget.linkToRoom,
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
