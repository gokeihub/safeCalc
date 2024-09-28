import 'package:calculetor/pages/Home/pages/image_page.dart';
import 'package:calculetor/pages/Home/pages/network_image_page.dart';
import 'package:calculetor/pages/Home/pages/video_page.dart';
import 'package:flutter/material.dart';

import '../../Setting/widgets/safecalc_ads.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafecalcAds(
        apiUrl:
            "https://apon06.github.io/bookify_api/safecalc_ads/safecalc_ads_4.json",
      ),
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GridBox(
                  boxName: 'Image',
                  boxIcon: Icons.image,
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (b) => const ImagePage()));
                  },
                ),
                GridBox(
                  boxName: 'Network Image',
                  boxIcon: Icons.wifi,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (b) => const NetworkImagePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GridBox(
                boxName: 'Video',
                boxIcon: Icons.videocam,
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (b) => const MediaPage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridBox extends StatefulWidget {
  final Function()? onTap;
  final String boxName;
  final IconData boxIcon;
  const GridBox({
    super.key,
    this.onTap,
    required this.boxName,
    required this.boxIcon,
  });

  @override
  State<GridBox> createState() => _GridBoxState();
}

class _GridBoxState extends State<GridBox> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 140,
        width: 160,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[850] : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? Colors.black54 : Colors.grey[400]!,
              offset: const Offset(2, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.boxIcon,
              size: 80,
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[700] : Colors.grey[500],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              child: Text(
                widget.boxName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
