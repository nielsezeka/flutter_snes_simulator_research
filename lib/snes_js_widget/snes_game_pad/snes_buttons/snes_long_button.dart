import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnesLongButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String label;
  const SnesLongButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  _SnesLongButtonState createState() => _SnesLongButtonState();
}

class _SnesLongButtonState extends State<SnesLongButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Container(
          height: 50,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.yellow,
            child: Center(
              child: Text(
                widget.label,
              ),
            ),
          ),
        ),
        onPressed: () {
          widget.onPressed();
        },
      ),
    );
  }
}
