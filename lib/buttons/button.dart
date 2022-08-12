import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  String name;
  double width;
  Function()? onPressed;

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
        backgroundColor: Colors.black12,
        padding: const EdgeInsets.all(16.0),
        primary: Colors.white,
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
