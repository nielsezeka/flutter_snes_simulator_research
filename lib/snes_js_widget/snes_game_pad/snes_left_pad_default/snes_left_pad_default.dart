import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snes_snimulator_flutter/snes_js_widget/snes_game_pad/snes_buttons/snes_control_arrow_buttons.dart';
import 'package:snes_snimulator_flutter/snes_js_widget/snes_game_pad/snes_buttons/snes_long_button.dart';
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
              child: SnesLongButton(
                label: 'Pause',
                onPressed: () {
                  SnesController.of(context).controller?.pauseOrResumeSnes();
                },
              ),
            ),
            Padding(padding: EdgeInsets.all(5)),
            Expanded(
              child: SnesLongButton(
                label: 'Select',
                onPressed: () {
                  SnesController.of(context)
                      .controller
                      ?.pressKey(DpadKey.selectKey);
                },
              ),
            ),
          ],
        ),
        Spacer(),
        Container(
          width: double.infinity,
          height: 200,
          child: SnesControlArrowButtons(
            onChangedButtons: (newState) {
              final key =
                  SnesControlArrowButtons.fromArrowKeyOfPad(newState.key);
              if (key != null) {
                if (newState.isPressed) {
                  SnesController.of(context).controller?.pressKey(
                        key,
                        withAutoRelease: false,
                      );
                } else {
                  SnesController.of(context).controller?.releaseKey(
                        key,
                      );
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
