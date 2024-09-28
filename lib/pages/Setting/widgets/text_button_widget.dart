// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TextButtonWidget extends StatelessWidget {
  final String text;
  final String url;
  const TextButtonWidget({
    super.key,
    required this.text,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          String privacyUrl = url.toString();
          final Uri uri = Uri.parse(privacyUrl);
          if (await canLaunch(uri.toString())) {
            await launch(uri.toString());
          } else {
            await launch(uri.toString());
          }
        },
        child: Text(text));
  }
}
