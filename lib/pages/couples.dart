import 'package:Vermax/pages/home_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:Vermax/buttons/button.dart';
import 'package:Vermax/consts.dart';

class CouplesScreen extends StatefulWidget {
  final List couples;
  final int leader;

  CouplesScreen({
    Key? key,
    required this.couples,
    required this.leader,
  }) : super(key: key);

  @override
  State<CouplesScreen> createState() => _CouplesScreenState();
}

class _CouplesScreenState extends State<CouplesScreen> {
  List checked = [];

  @override
  Widget build(BuildContext context) {
    List<Widget> _list = [];

    coupleWidgetList() {
      List<Widget> list = [];

      for (int i = 0; i < widget.couples.length; i++) {
        checked.add(false);

        list.add(GestureDetector(
          onTap: () {
            setState(() {
              checked[i] = !checked[i];
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: checked[i]
                  ? Color.fromARGB(62, 46, 59, 140)
                  : const Color.fromARGB(255, 46, 58, 140),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      widget.couples[i][0].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      '-',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      widget.couples[i][1].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
      }

      setState(() {
        _list = list;
      });
    }

    coupleWidgetList();

    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Button(
                        name: "new_game".tr(),
                        width: 120,
                        onPressed: () {
                          final LocalStorage storage = LocalStorage('storage');
                          storage.deleteItem('game');
                          Navigator.pushReplacementNamed(context, '/');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        },
                      ),
                      if (widget.leader > 0)
                        Button(
                          name: "you".tr() + ": ${widget.leader}",
                          width: 75,
                          onPressed: () {},
                        ),
                    ],
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: _list,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
