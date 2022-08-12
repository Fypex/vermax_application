import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:Vermax/consts.dart';
import 'package:Vermax/pages/home_page.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    const langs = [
      [
        'en',
        'US',
        'English',
      ],
      [
        'uk',
        'UA',
        'Українська',
      ],
    ];

    _langElements(BuildContext context) {
      return langs.map((lang) {
        return ListTile(
          leading: Image.asset(
            'assets/flags/${lang[0]}.png',
            width: 25,
            height: 25,
          ),
          style: ListTileStyle.values[1],
          tileColor: Color.fromARGB(255, 40, 54, 143),
          title: Text(
            lang[2].toString(),
            style: const TextStyle(color: Colors.white),
          ),
          onTap: () async {
            setState(() {
              context.setLocale(
                Locale(lang[0], lang[1]),
              );
            });
          },
        );
      }).toList();
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: mainColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
          elevation: 0,
          backgroundColor: mainColor,
          centerTitle: true,
          title: Text(
            "settings".tr(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "language".tr(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: _langElements(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
