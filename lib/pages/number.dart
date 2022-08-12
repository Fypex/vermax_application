import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:Vermax/consts.dart';

class NumberScreen extends StatefulWidget {
  String number;

  NumberScreen({
    Key? key,
    required this.number,
  }) : super(key: key);

  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  String value = "*";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainColor,
        centerTitle: true,
        title: Text(
          "your_number".tr(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      backgroundColor: mainColor,
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(
                    bottom: 40, left: 40, right: 40, top: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 61, 78, 184),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 51, 65, 155),
                      offset: Offset(0, 0),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 120,
                    ),
                  ),
                ),
              ),
              onTap: () {
                setState(() {
                  if (value == "*") {
                    value = widget.number.toString();
                  } else {
                    value = "*";
                  }
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'click'.tr(),
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
