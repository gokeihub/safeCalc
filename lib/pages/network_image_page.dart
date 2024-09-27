import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkImagePage extends StatefulWidget {
  const NetworkImagePage({super.key});

  @override
  NetworkImagePageState createState() => NetworkImagePageState();
}

class NetworkImagePageState extends State<NetworkImagePage> {
  List<String> _networkImageFilePaths = [];
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMediaFilePaths();
  }

  Future<void> _loadMediaFilePaths() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _networkImageFilePaths =
          prefs.getStringList('mediaNetworkImagePageFilePaths') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _showAddImageDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Network Images'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MasonryGridView.count(
          itemCount: _networkImageFilePaths.length,
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () {
                _showDeleteConfirmationDialog(index);
              },
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (b) => ImageFullScreenPage(
                        imagePath: _networkImageFilePaths[index])));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: _networkImageFilePaths[index],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: isDarkMode ? Colors.grey[850] : Colors.grey[300],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: isDarkMode ? Colors.grey[850] : Colors.grey[300],
                    child: const Icon(Icons.error, color: Colors.red),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _showAddImageDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Network Image'),
          content: SizedBox(
            height: 100,
            child: Column(
              children: [
                CupertinoTextField(
                  controller: textEditingController,
                  placeholder: 'Enter Valid URL',
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        if (textEditingController.text.isNotEmpty) {
                          setState(() {
                            _networkImageFilePaths
                                .add(textEditingController.text);
                            textEditingController.clear();
                          });
                          await _saveMediaFilePaths();
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _saveMediaFilePaths() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'mediaNetworkImagePageFilePaths', _networkImageFilePaths);
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
      _networkImageFilePaths.removeAt(index);
    });
    await prefs.setStringList(
        'mediaNetworkImagePageFilePaths', _networkImageFilePaths);
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
            fit: BoxFit.cover,
            imageUrl: imagePath,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                const Icon(Icons.error, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
