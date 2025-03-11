import 'package:calculetor/pages/Home/pages/image_page.dart';
import 'package:calculetor/pages/Home/pages/network_image_page.dart';
import 'package:calculetor/pages/Home/pages/video_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, 
                  crossAxisSpacing: 16, 
                  mainAxisSpacing: 16, // Space between rows
                ),
                itemCount: 3, // Number of items in the grid
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return GridBox(
                      boxName: 'Image',
                      boxIcon: Icons.image,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (b) => const ImagePage()),
                        );
                      },
                    );
                  } else if (index == 1) {
                    return GridBox(
                      boxName: 'Network Image',
                      boxIcon: Icons.wifi,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (b) => const NetworkImagePage(),
                          ),
                        );
                      },
                    );
                  } else {
                    return GridBox(
                      boxName: 'Video',
                      boxIcon: Icons.videocam,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (b) => const MediaPage()),
                        );
                      },
                    );
                  }
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
        width: 160,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[850] : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
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
