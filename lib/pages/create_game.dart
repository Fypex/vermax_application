import 'dart:ffi';
import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:localstorage/localstorage.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:flutter/material.dart';
import 'package:Vermax/buttons/button.dart';
import 'package:Vermax/consts.dart';
import 'package:Vermax/pages/qrcodes.dart';

class CreateGameScreen extends StatefulWidget {
  CreateGameScreen({Key? key}) : super(key: key);

  @override
  State<CreateGameScreen> createState() => _CreateGameScreenState();
}

class _CreateGameScreenState extends State<CreateGameScreen> {
  double _amountPlayers = 4;
  bool _leading_player = false;
  int _random_seed = Random.secure().nextInt(40);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainColor,
        centerTitle: true,
        title: Text(
          "create_game".tr(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(height: 50),
              Text(
                "players".tr(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
              Text(
                _amountPlayers.toInt().toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 70,
                ),
              )
            ],
          ),
          Column(
            children: [
              Slider(
                value: _amountPlayers,
                activeColor: Colors.white,
                inactiveColor: const Color.fromARGB(255, 46, 58, 140),
                min: 4,
                max: 20,
                divisions: 8,
                onChanged: (double value) {
                  setState(() {
                    _amountPlayers = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Text(
                "are_you_play?".tr(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              SlidingSwitch(
                value: _leading_player,
                width: 250,
                onChanged: (bool value) {
                  _leading_player = value;
                },
                height: 55,
                animationDuration: const Duration(milliseconds: 400),
                onTap: () {},
                onDoubleTap: () {},
                onSwipe: () {},
                textOff: "no".tr(),
                textOn: "yes".tr(),
                colorOn: const Color.fromARGB(255, 255, 255, 255),
                colorOff: const Color.fromARGB(255, 255, 255, 255),
                background: const Color.fromARGB(255, 46, 58, 140),
                buttonColor: mainColor,
                inactiveColor: const Color.fromARGB(255, 255, 255, 255),
              ),
              const SizedBox(height: 50),
              Button(
                name: 'continue'.tr(),
                width: MediaQuery.of(context).size.width,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QrCodesPage(
                        amount: _amountPlayers.toInt(),
                        leading: _leading_player,
                        seed: _random_seed,
                      ),
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
