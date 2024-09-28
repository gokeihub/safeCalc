//! The user interface of this page is similar to that of LocalSend

import 'package:cached_network_image/cached_network_image.dart';
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
                    child: CachedNetworkImage(
                      imageUrl: "https://i.postimg.cc/GpyZ9kJL/calculetor.png",
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
                const Text("© 2024 Md Apon Ahmed"),
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
                    Text("Md Apon Ahmed"),
                    TextButtonWidget(
                      text: "apon06",
                      url: 'https://github.com/apon06',
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
                        url: 'https://github.com/apon06/safeCalc',
                      ),
                      TextButtonWidget(
                        text: "License",
                        url:
                            'https://github.com/apon06/safeCalc/blob/main/LICENSE',
                      ),
                      TextButtonWidget(
                        text: "CHANGELOG",
                        url:
                            'https://github.com/apon06/safeCalc/blob/main/CHANGELOG.md',
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
