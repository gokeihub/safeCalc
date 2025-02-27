//! The user interface of this page is similar to that of LocalSend

import 'package:flutter/material.dart';
import '../widgets/text_button_widget.dart';

class AboutSafecalc extends StatelessWidget {
  const AboutSafecalc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About safeCalc"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      "assets/calculetor1.png",
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "safeCalc",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text("© 2025 Gokeihub"),
                const SizedBox(height: 15),
                const TextButtonWidget(
                    text: "Gokei Hub", url: 'https://gokeihub.blogspot.com/'),
                const SizedBox(height: 15),
                const Text(
                  "safeCalc is free, open-source Lock App",
                ),
                const SizedBox(height: 15),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Auther",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Row(
                  children: [
                    Text("Gokeihub LAB"),
                    TextButtonWidget(
                      text: "gokeihub",
                      url: 'https://github.com/gokeihub',
                    ),
                  ],
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButtonWidget(
                        text: "HomePage",
                        url: 'https://gokeihub.blogspot.com/',
                      ),
                      TextButtonWidget(
                        text: "Source Code (Github)",
                        url: 'https://github.com/gokeihub/safeCalc',
                      ),
                      TextButtonWidget(
                        text: "License",
                        url:
                            'https://github.com/gokeihub/safeCalc/blob/main/LICENSE',
                      ),
                      TextButtonWidget(
                        text: "CHANGELOG",
                        url:
                            'https://github.com/gokeihub/safeCalc/blob/main/CHANGELOG.md',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
