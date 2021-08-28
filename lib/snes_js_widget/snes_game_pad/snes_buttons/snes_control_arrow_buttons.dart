import 'package:flutter/material.dart';
import 'package:snes_snimulator_flutter/snes_js_widget/snes_screen/snes_js_widget.dart';

enum SnesControlArrowKey {
  up,
  down,
  left,
  right,
}

class ChangedState {
  final SnesControlArrowKey key;
  final bool isPressed;

  ChangedState({required this.key, required this.isPressed});
}

class SnesControlArrowButtons extends StatefulWidget {
  final ValueChanged<ChangedState> onChangedButtons;
  const SnesControlArrowButtons({
    Key? key,
    required this.onChangedButtons,
  }) : super(key: key);
  @override
  _SnesControlArrowButtonsState createState() =>
      _SnesControlArrowButtonsState();
  static DpadKey? fromArrowKeyOfPad(SnesControlArrowKey arrowPad) {
    switch (arrowPad) {
      case SnesControlArrowKey.left:
        return DpadKey.leftKey;
      case SnesControlArrowKey.right:
        return DpadKey.rightKey;
      case SnesControlArrowKey.up:
        return DpadKey.upKey;
      case SnesControlArrowKey.down:
        return DpadKey.downKey;
      default:
        return null;
    }
  }
}

class _SnesControlArrowButtonsState extends State<SnesControlArrowButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: TouchableGestureButton(
                    iconDisplay: Icon(
                      Icons.arrow_drop_up,
                      color: Colors.blue,
                      size: 36.0,
                    ),
                    touchDown: () {
                      widget.onChangedButtons(ChangedState(
                        isPressed: true,
                        key: SnesControlArrowKey.up,
                      ));
                    },
                    touchUp: () {
                      widget.onChangedButtons(ChangedState(
                        isPressed: false,
                        key: SnesControlArrowKey.up,
                      ));
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: TouchableGestureButton(
                    iconDisplay: Icon(
                      Icons.arrow_left,
                      color: Colors.blue,
                      size: 36.0,
                    ),
                    touchDown: () {
                      widget.onChangedButtons(ChangedState(
                        isPressed: true,
                        key: SnesControlArrowKey.left,
                      ));
                    },
                    touchUp: () {
                      widget.onChangedButtons(ChangedState(
                        isPressed: false,
                        key: SnesControlArrowKey.left,
                      ));
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: TouchableGestureButton(
                    iconDisplay: Icon(
                      Icons.arrow_right,
                      color: Colors.blue,
                      size: 36.0,
                    ),
                    touchDown: () {
                      widget.onChangedButtons(ChangedState(
                        isPressed: true,
                        key: SnesControlArrowKey.right,
                      ));
                    },
                    touchUp: () {
                      widget.onChangedButtons(ChangedState(
                        isPressed: false,
                        key: SnesControlArrowKey.right,
                      ));
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
                  child: Container(
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: TouchableGestureButton(
                    iconDisplay: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.blue,
                      size: 36.0,
                    ),
                    touchDown: () {
                      widget.onChangedButtons(ChangedState(
                        isPressed: true,
                        key: SnesControlArrowKey.down,
                      ));
                    },
                    touchUp: () {
                      widget.onChangedButtons(ChangedState(
                        isPressed: false,
                        key: SnesControlArrowKey.down,
                      ));
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TouchableGestureButton extends StatefulWidget {
  final VoidCallback touchDown;
  final VoidCallback touchUp;
  const TouchableGestureButton({
    Key? key,
    this.iconDisplay,
    required this.touchDown,
    required this.touchUp,
  }) : super(key: key);
  final Icon? iconDisplay;
  @override
  _TouchableGestureButtonState createState() => _TouchableGestureButtonState();
}

class _TouchableGestureButtonState extends State<TouchableGestureButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: isPressed ? Colors.red : Colors.redAccent,
        child: widget.iconDisplay,
      ),
      onTapDown: (detail) {
        setState(() {
          isPressed = true;
        });
        widget.touchDown();
      },
      onTapUp: (detail) {
        setState(() {
          isPressed = false;
        });
        widget.touchUp();
      },
    );
  }
}
