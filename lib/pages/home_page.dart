import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:Vermax/buttons/button.dart';
import 'package:Vermax/consts.dart';
import 'package:Vermax/pages/couples.dart';
import 'package:Vermax/pages/create_game.dart';
import 'package:Vermax/pages/number.dart';
import 'package:Vermax/pages/rules.dart';
import 'package:localstorage/localstorage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:Vermax/pages/settings.dart';

class HomePage extends StatefulWidget {
  static const double buttonWidth = 200;

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    if (barcodeScanRes != '-1') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NumberScreen(
            number: barcodeScanRes,
          ),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    var _game = 0;
    var _game_info;

    final LocalStorage storage = LocalStorage('storage');

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: mainColor,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: mainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  FutureBuilder(
                    future: storage.ready,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Container();
                      }

                      if (snapshot.hasData) {
                        _game_info =
                            json.decode(storage.getItem('game') ?? '[]');

                        if (_game_info.length > 0) {
                          return Column(
                            children: [
                              Button(
                                name: 'continue'.tr(),
                                width: HomePage.buttonWidth,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CouplesScreen(
                                        couples: _game_info['couples'],
                                        leader: _game_info['leading'],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      } else {
                        return Container();
                      }
                    },
                  ),
                  Button(
                    name: "create_game".tr(),
                    width: HomePage.buttonWidth,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateGameScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Button(
                    name: "scan_qr".tr(),
                    width: HomePage.buttonWidth,
                    onPressed: () {
                      scanQR();
                    },
                  ),
                  const SizedBox(height: 20),
                  Button(
                    name: "rules.title".tr(),
                    width: HomePage.buttonWidth,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Rules()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Button(
                    name: "settings".tr(),
                    width: HomePage.buttonWidth,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsScreen()),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
