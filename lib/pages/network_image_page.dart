import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkImagePage extends StatefulWidget {
  const NetworkImagePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NetworkImagePageState createState() => _NetworkImagePageState();
}

class _NetworkImagePageState extends State<NetworkImagePage> {
  List<String> _networkImageFilePaths = [];
  TextEditingController textEditingController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    _loadMediaFilePaths();
  }

  Future<void> _loadMediaFilePaths() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      try {
        _networkImageFilePaths = prefs.getStringList('mediaNetworkImagePageFilePaths') ?? [];
      } catch (e) {
        //
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()  {
           showModalBottomSheet(
              context: context,
              builder: (index) {
                return SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: CupertinoTextField(
                          controller: textEditingController,
                          placeholder: 'Enter Valid link',
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancle')),
                          TextButton(
                              onPressed: () async {
                                try {
                                  setState(() {
                                    _networkImageFilePaths
                                        .add(textEditingController.text);
                                    textEditingController.text == '';
                                    Navigator.pop(context);
                                  });
                                } catch (e) {
                                  //
                                }

                                try {
                                  await _saveMediaFilePaths();
                                } catch (e) {
                                  //
                                }
                              },
                              child: const Text('Ok')),
                        ],
                      )
                    ],
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Hi'),
      ),
      body: Column(
        children: [
          Expanded(
            child: MasonryGridView.count(
              itemCount: _networkImageFilePaths.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    try {
                      _showDeleteConfirmationDialog(index);
                    } catch (e) {
                      //
                    }
                  },
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (b) => ImageFullScreenPage(
                            imagePath: _networkImageFilePaths[index])));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CachedNetworkImage(
                      imageUrl: _networkImageFilePaths[index],
                    ),
                  ),
                );
              },
              crossAxisCount: 2,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveMediaFilePaths() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('mediaNetworkImagePageFilePaths', _networkImageFilePaths);
  }

  Future<void> _showDeleteConfirmationDialog(int index) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Image?'),
          content: const Text('Are you sure you want to delete this image?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteMedia(index);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteMedia(int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      try {
        _networkImageFilePaths.removeAt(index);
      } catch (e) {
        //
      }
    });
    await prefs.setStringList('mediaNetworkImagePageFilePaths', _networkImageFilePaths);
  }
}

class ImageFullScreenPage extends StatelessWidget {
  final String imagePath;

  const ImageFullScreenPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(80),
          panEnabled: false,
          scaleEnabled: true,
          minScale: 1.0,
          maxScale: 2.2,
          child: CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: imagePath,
          ),
        ),
      ),
    );
  }
}
