import 'package:flutter/material.dart';
import '../snes_screen/snes_js_widget.dart';

class SnesController extends InheritedWidget {
  final DpadController? controller;
  const SnesController({
    Key? key,
    required this.controller,
    required Widget child,
  }) : super(key: key, child: child);

  static SnesController of(BuildContext context) {
    final SnesController? result =
        context.dependOnInheritedWidgetOfExactType<SnesController>();
    assert(result != null, 'No Dpad Found');
    return result!;
  }

  @override
  bool updateShouldNotify(SnesController old) => true;
}
