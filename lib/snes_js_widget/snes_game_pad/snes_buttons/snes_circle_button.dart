import 'package:flutter/material.dart';

class SnesCircleButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String label;
  const SnesCircleButton(
      {Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  _SnesCircleButtonState createState() => _SnesCircleButtonState();
}

class _SnesCircleButtonState extends State<SnesCircleButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          widget.onPressed();
        },
        child: Text(widget.label),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
        ),
      ),
    );
  }
}
