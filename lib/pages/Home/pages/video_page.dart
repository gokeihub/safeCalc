import 'dart:io';
import 'package:better_player_enhanced/better_player.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> mediaFilePaths = [];

class MediaPage extends StatefulWidget {
  const MediaPage({super.key});

  @override
  MediaPageState createState() => MediaPageState();
}

class MediaPageState extends State<MediaPage> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _loadMediaFilePaths();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _initializeControllerFuture = _cameraController.initialize();
    await _initializeControllerFuture;
    setState(() {
      _isCameraInitialized = true;
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _loadMediaFilePaths() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      mediaFilePaths = prefs.getStringList('mediaFilePaths') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showMediaSourceSelectionDialog,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Video'),
      ),
      body: Column(
        children: [
          Expanded(
            child: MasonryGridView.count(
              itemCount: mediaFilePaths.length,
              crossAxisCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onLongPress: () => _showDeleteConfirmationDialog(index),
                  onTap: () => _showMediaFullScreenPage(mediaFilePaths[index]),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: mediaFilePaths[index].endsWith('.mp4')
                        ? Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey[500],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Icon(Icons.videocam, size: 100),
                            ),
                          )
                        : Image.file(
                            File(
                              mediaFilePaths[index],
                            ),
                          ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showMediaSourceSelectionDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Media'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    _captureMedia(ImageSource.gallery);
                  },
                  child: const Text('Pick from Gallery'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _captureMedia(ImageSource source) async {
    final imagePicker = ImagePicker();
    if (source == ImageSource.camera && _isCameraInitialized) {
      await _initializeControllerFuture;
      final XFile file = await _cameraController.takePicture();
      _addMediaFile(file.path);
    } else {
      final XFile? mediaFile = await imagePicker.pickVideo(source: source);
      if (mediaFile != null) {
        _addMediaFile(mediaFile.path);
      } else {
        final XFile? videoFile = await imagePicker.pickVideo(source: source);
        if (videoFile != null) {
          _addMediaFile(videoFile.path);
        }
      }
    }
  }

  Future<void> _addMediaFile(String path) async {
    setState(() {
      mediaFilePaths.add(path);
    });
    await _saveMediaFilePaths();
  }

  Future<void> _showDeleteConfirmationDialog(int index) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Media?'),
          content: const Text('Are you sure you want to delete this media?'),
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
      mediaFilePaths.removeAt(index);
    });
    await prefs.setStringList('mediaFilePaths', mediaFilePaths);
  }

  Future<void> _showMediaFullScreenPage(String mediaPath) async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MediaFullScreenPage(mediaPath: mediaPath),
    ));
  }

  Future<void> _saveMediaFilePaths() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('mediaFilePaths', mediaFilePaths);
  }
}

class MediaFullScreenPage extends StatelessWidget {
  final String mediaPath;
  const MediaFullScreenPage({super.key, required this.mediaPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Player"),
      ),
      body: Center(
        child: mediaPath.endsWith('.mp4')
            ? BetterPlayer.file(
                mediaPath,
                betterPlayerConfiguration: BetterPlayerConfiguration(
                  aspectRatio: _getVideoAspectRatio(mediaPath),
                  fit: BoxFit.contain,
                  autoPlay: true,
                  looping: true,
                ),
              )
            : InteractiveViewer(
                boundaryMargin: const EdgeInsets.all(80),
                panEnabled: false,
                scaleEnabled: true,
                minScale: 1.0,
                maxScale: 2.2,
                child: Image.file(
                  File(mediaPath),
                  fit: BoxFit.contain,
                ),
              ),
      ),
    );
  }

  double _getVideoAspectRatio(String mediaPath) {
    if (mediaPath.contains('portrait')) {
      return 9 / 16;
    }
    return 16 / 9;
  }
}
