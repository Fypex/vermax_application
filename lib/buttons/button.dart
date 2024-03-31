import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String name;
  final double width;
  final Function()? onPressed;

  Button({
    Key? key,
    required this.name,
    required this.width,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black12,
        padding: const EdgeInsets.all(16.0),
        textStyle: const TextStyle(fontSize: 20),
      ),
      onPressed: onPressed,
      child: Container(
        width: width,
        alignment: Alignment.center,
        child: Text(name),
      ),
    );
  }
}
