import 'package:flutter/material.dart';
import 'package:snes_snimulator_flutter/snes_js_widget/snes_game_pad/snes_buttons/snes_circle_button.dart';
import 'package:snes_snimulator_flutter/snes_js_widget/snes_game_pad/snes_buttons/snes_long_button.dart';
import 'package:snes_snimulator_flutter/snes_js_widget/snes_screen/snes_js_widget.dart';

import '../snes_game_pad.dart';

class SnesRightPadDefault extends StatefulWidget {
  const SnesRightPadDefault({Key? key}) : super(key: key);

  @override
  _SnesRightPadDefaultState createState() => _SnesRightPadDefaultState();
}

class _SnesRightPadDefaultState extends State<SnesRightPadDefault>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SnesLongButton(
                label: 'Start',
                onPressed: () {
                  SnesController.of(context)
                      .controller
                      ?.pressKey(DpadKey.startKey);
                },
              ),
            ),
          ],
        ),
        Spacer(),
        Container(
          width: double.infinity,
          height: 300,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: SnesCircleButton(
                        label: "Y",
                        onPressed: () {
                          SnesController.of(context)
                              .controller
                              ?.pressKey(DpadKey.yKey);
                        },
                      ),
                    ),
                    Expanded(
                      child: SnesCircleButton(
                        label: "B",
                        onPressed: () {
                          SnesController.of(context)
                              .controller
                              ?.pressKey(DpadKey.bKey);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: SnesCircleButton(
                      label: "X",
                      onPressed: () {
                        SnesController.of(context)
                            .controller
                            ?.pressKey(DpadKey.xKey);
                      },
                    )),
                    Expanded(
                        child: SnesCircleButton(
                      label: "A",
                      onPressed: () {
                        SnesController.of(context)
                            .controller
                            ?.pressKey(DpadKey.aKey);
                      },
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
