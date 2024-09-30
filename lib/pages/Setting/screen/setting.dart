// ignore_for_file: deprecated_member_use

import 'package:calculetor/pages/Setting/screen/about_safecalc.dart';
import 'package:calculetor/pages/Setting/screen/app_information_page.dart';
import 'package:calculetor/pages/Setting/screen/change_log_page.dart';
import 'package:calculetor/pages/Setting/widgets/safecalc_ads.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      bottomNavigationBar: SafecalcAds(
        apiUrl:
            "https://apon06.github.io/bookify_api/safecalc_ads/safecalc_ads_1.json",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (b) => const AppInformationPage(),
                    ),
                  );
                },
                title: const Text('App Information'),
                trailing: const Icon(Icons.info_rounded),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (b) => const AboutSafecalc(),
                    ),
                  );
                },
                title: const Text('About safeCalc'),
                trailing: const Icon(Icons.info_rounded),
              ),
            ),
            SafecalcAds(
              apiUrl:
                  "https://apon06.github.io/bookify_api/safecalc_ads/safecalc_ads_2.json",
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (b) => const ChangeLogPage(),
                    ),
                  );
                },
                title: const Text('Changelog'),
                trailing: const Icon(Icons.history),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () async {
                  String privacyUrl =
                      'https://sites.google.com/view/safecalc-pricey/home';
                  final Uri url = Uri.parse(privacyUrl);
                  if (await canLaunch(url.toString())) {
                    await launch(url.toString());
                  } else {
                    await launch(url.toString());
                  }
                },
                title: const Text('Privacy Policy'),
                trailing: const Icon(Icons.privacy_tip),
              ),
            ),
            SafecalcAds(
              apiUrl:
                  "https://apon06.github.io/bookify_api/safecalc_ads/safecalc_ads_3.json",
            ),
            Card(
              child: ListTile(
                onTap: () async {
                  String privacyUrl =
                      'https://sites.google.com/view/safecalc-terms/home';
                  final Uri url = Uri.parse(privacyUrl);
                  if (await canLaunch(url.toString())) {
                    await launch(url.toString());
                  } else {
                    await launch(url.toString());
                  }
                },
                title: const Text('Terms & Conditions'),
                trailing: Icon(Icons.assignment),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () async {
                  String privacyUrl = 'https://github.com/apon06';
                  final Uri url = Uri.parse(privacyUrl);
                  if (await canLaunch(url.toString())) {
                    await launch(url.toString());
                  } else {
                    await launch(url.toString());
                  }
                },
                title: const Text('Github'),
                trailing: Icon(FontAwesomeIcons.github),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () async {
                  String privacyUrl = 'https://t.me/+-xBeTl30frgwNWI1';
                  final Uri url = Uri.parse(privacyUrl);
                  if (await canLaunch(url.toString())) {
                    await launch(url.toString());
                  } else {
                    await launch(url.toString());
                  }
                },
                title: const Text('Telegram'),
                trailing: Icon(Icons.telegram),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
