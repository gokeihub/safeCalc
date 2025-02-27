import 'package:calculetor/pages/Setting/screen/about_safecalc.dart';
import 'package:calculetor/pages/Setting/screen/app_information_page.dart';
import 'package:calculetor/pages/Setting/screen/change_log_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (b) => const AppInformationPage(),
                      ),
                    );
                  },
                  title: const Text('App Information'),
                  trailing: const Icon(FontAwesomeIcons.info),
                ),
                Divider(),
                ListTile(
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
                Divider(),
                ListTile(
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
                Divider(),
                ListTile(
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
                Divider(),
                ListTile(
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
                Divider(),
                ListTile(
                  onTap: () async {
                    String privacyUrl = 'https://github.com/gokeihub';
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
                Divider(),
                ListTile(
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
                Divider(),
                ListTile( 
                  onTap: () {
                    String message = 'https://www.gokeihub.com/safeCalc';
                    Share.share(message);
                  },
                  title: const Text('Share'),
                  trailing: Icon(Icons.share),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
