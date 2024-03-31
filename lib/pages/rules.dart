import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:Vermax/consts.dart';

class Rules extends StatelessWidget {
  const Rules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainColor,
        centerTitle: true,
        title: Text(
          "rules.title".tr(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      backgroundColor: mainColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            RuleText(
              text: "rules.text.1".tr(),
            ),
            RuleText(
              text: "rules.text.2".tr(),
            ),
            RuleText(
              text: "rules.text.3".tr(),
            ),
            RuleText(
              text: "rules.text.4".tr(),
            ),
            RuleText(
              text: "rules.text.5".tr(),
            ),
          ],
        ),
      )),
    );
  }
}

class RuleText extends StatelessWidget {
  RuleText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
