import 'dart:convert';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:Vermax/buttons/button.dart';
import 'package:Vermax/consts.dart';
import 'package:Vermax/pages/couples.dart';

class QrCodesPage extends StatefulWidget {
  num amount;
  bool leading;
  int seed;
  int _totalPages = 0;

  QrCodesPage({
    Key? key,
    required this.amount,
    required this.leading,
    required this.seed,
  }) : super(key: key);

  @override
  State<QrCodesPage> createState() => _QrCodesPageState();
}

class _QrCodesPageState extends State<QrCodesPage> {
  int _leadingNum = 0;
  var _couples = [];
  int _currentPage = 1;

  List<Widget> dotList(amount) {
    List<Widget> dotList = [];
    for (var i = 1; i <= amount; i++) {
      dotList.add(dot(i));
    }
    return dotList;
  }

  saveGame() {
    final LocalStorage storage = LocalStorage('storage');

    final game = json.encode({
      'leading': _leadingNum,
      'couples': _couples,
    });

    storage.setItem('game', game);
  }

  Widget dot(page) {
    return Container(
      width: 10,
      height: 10,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: _currentPage == page
            ? Color.fromARGB(255, 64, 81, 192)
            : const Color.fromARGB(255, 46, 58, 140),
        shape: BoxShape.circle,
      ),
    );
  }

  List shuffle(List array) {
    var random = Random(widget.seed);
    for (var i = array.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);
      var temp = array[i];
      array[i] = array[n];
      array[n] = temp;
    }
    return array;
  }

  getLeadingNum(amount) {
    if (widget.leading) {
      Random rnd;
      int min = 1;
      int max = amount.toInt();
      rnd = Random();
      return min + rnd.nextInt(max - min);
    }

    return 0;
  }

  randomPlayers() {
    List<int> randomPlayers = [];

    for (var player = 1; player <= widget.amount.toInt(); player++) {
      randomPlayers.add(player);
    }

    return shuffle(randomPlayers);
  }

  pairUp(randomPlayers) {
    var pairs = [];
    for (var i = 0; i < widget.amount.toInt(); i += 2) {
      pairs.add(
        randomPlayers.sublist(
            i, i + 2 > randomPlayers.length ? randomPlayers.length : i + 2),
      );
    }

    return pairs;
  }

  generateQrCodes(List widgets) {
    List<Widget> list = [];
    int index = 1;
    List<int> players = [];
    // Shuffle players in list by number
    players = randomPlayers();

    // Create pairs of players
    _couples = pairUp(players);

    // Get leading player number
    _leadingNum = getLeadingNum(widget.amount);

    // Create QR codes for each player without leading player if is needed
    for (var player in players) {
      Widget widget = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImage(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              data: player.toString(),
              version: QrVersions.auto,
              size: 320,
              gapless: false,
            ),
          ],
        ),
      );

      if (_leadingNum != player) {
        list.add(widget);
        index++;
      }
    }

    for (var widget in widgets) {
      list.add(widget);
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    Map<String, dynamic> gameData = {}
      ..['amount'] = widget.amount
      ..['leading'] = widget.leading
      ..['seed'] = widget.seed;

    //storage.setItem('gameData', jsonEncode(gameData).toString());

    List<Widget> _qrCodes = generateQrCodes(
      [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              name: "start".tr(),
              width: 250,
              onPressed: () {
                saveGame();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CouplesScreen(
                      couples: _couples,
                      leader: _leadingNum,
                    ),
                  ),
                );
              },
            ),
          ],
        )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainColor,
        centerTitle: true,
        title: Text(
          "qr_codes".tr(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      backgroundColor: mainColor,
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index + 1;
          });
        },
        children: _qrCodes,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 5.0,
          runSpacing: 4.0,
          children: dotList(_qrCodes.length),
        ),
      ),
    );
  }
}
