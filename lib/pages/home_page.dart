import 'package:calculetor/pages/image_page.dart';
import 'package:calculetor/pages/network_image_page.dart';
import 'package:calculetor/pages/video_page.dart';
import 'package:flutter/material.dart';
// import '../firebase/config.dart';
import '../utils/grid_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late Future<void> _initConfigFuture;

  @override
  void initState() {
    super.initState();
    // _initConfigFuture = Config.initConfig();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: FutureBuilder<void>(
        //     future: _initConfigFuture,
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return const SizedBox.shrink(); // Show nothing while waiting
        //       } else if (snapshot.hasError) {
        //         return const Text('Error loading ads');
        //       } else {
        //         return Text(Config.titleText);
        //       }
        //     },
        //   ),
        // ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
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
                  boxIcon: Icons.image,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (b) => const NetworkImagePage()));
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GridBox(
                boxName: 'Video',
                boxIcon: Icons.camera_alt,
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (b) =>  VideoPage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
