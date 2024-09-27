// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:video_player/video_player.dart';

// class VideoPage extends StatefulWidget {
//   const VideoPage({Key? key}) : super(key: key);

//   @override
//   _VideoPageState createState() => _VideoPageState();
// }

// class _VideoPageState extends State<VideoPage> {
//   List<String> _videFilePaths = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadMediaFilePaths();
//   }

//   Future<void> _loadMediaFilePaths() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _videFilePaths = prefs.getStringList('mediaFilePaths') ?? [];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Media Capture and View'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: _showMediaSourceSelectionDialog,
//             child: const Text('Add Media'),
//           ),
//           Expanded(
//             child: GridView.builder(
//               itemCount: _videFilePaths.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//               ),
//               itemBuilder: (context, index) {
//                 final filePath = _videFilePaths[index];
//                 return GestureDetector(
//                   onTap: () {
//                     if (filePath.endsWith('.mp4')) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               VideoPlayerScreen(videoPath: filePath),
//                         ),
//                       );
//                     }
//                   },
//                   onLongPress: () => _showDeleteConfirmationDialog(index),
//                   child: filePath.endsWith('.mp4')
//                       ? VideoThumbnail(videoPath: filePath)
//                       : Hero(
//                           tag: filePath,
//                           child: Image.file(
//                             File(filePath),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _showMediaSourceSelectionDialog() async {
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Add Media'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     _captureMedia(
//                       ImageSource.camera,
//                     );
//                   },
//                   child: const Text('Capture Image from Camera'),
//                 ),
//                 const SizedBox(height: 10),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     _captureMedia(
//                       ImageSource.gallery,
//                     );
//                   },
//                   child: const Text('Pick Image from Gallery'),
//                 ),
//                 const SizedBox(height: 10),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     _captureMedia(
//                       ImageSource.camera,
//                     );
//                   },
//                   child: const Text('Capture Video from Camera'),
//                 ),
//                 const SizedBox(height: 10),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     _captureMedia(
//                       ImageSource.gallery,
//                     );
//                   },
//                   child: const Text('Pick Video from Gallery'),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _captureMedia(
//     ImageSource source,
//   ) async {
//     if (!(await Permission.storage.request().isGranted)) {
//       return; // Handle case where permission is not granted
//     }

//     final imagePicker = ImagePicker();
//     final pickedFile = await imagePicker.pickVideo(source: source);

//     if (pickedFile == null) {
//       return; // User canceled media capture
//     }

//     setState(() {
//       _videFilePaths.add(pickedFile.path);
//     });

//     await _saveMediaFilePaths();
//   }

//   Future<void> _saveMediaFilePaths() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('mediaFilePaths', _videFilePaths);
//   }

//   Future<void> _showDeleteConfirmationDialog(int index) async {
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Delete Media?'),
//           content: const Text('Are you sure you want to delete this media?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 _deleteMedia(index);
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Delete'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _deleteMedia(int index) async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _videFilePaths.removeAt(index);
//     });
//     await prefs.setStringList('mediaFilePaths', _videFilePaths);
//   }
// }

// class VideoThumbnail extends StatefulWidget {
//   final String? videoPath;

//   const VideoThumbnail({Key? key, this.videoPath}) : super(key: key);

//   @override
//   _VideoThumbnailState createState() => _VideoThumbnailState();
// }

// class _VideoThumbnailState extends State<VideoThumbnail> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.file(File(widget.videoPath!));
//     _initializeVideoPlayerFuture = _controller.initialize();
//     _controller.setLooping(true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _initializeVideoPlayerFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           return VideoPlayer(_controller);
//         } else {
//           return const CircularProgressIndicator();
//         }
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

// class VideoPlayerScreen extends StatefulWidget {
//   final String videoPath;

//   const VideoPlayerScreen({Key? key, required this.videoPath})
//       : super(key: key);

//   @override
//   _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
// }

// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//   bool play = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.file(File(widget.videoPath));
//     _initializeVideoPlayerFuture = _controller.initialize();
//     _controller.setLooping(true);
//     _controller.play();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _controller.value.isPlaying
//               ? _controller.pause()
//               : _controller.play();
//         },
//         child: Icon(
//           _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//         ),
//       ),
//       appBar: AppBar(
//         title: const Text('Video Player'),
//       ),
//       body: FutureBuilder(
//         future: _initializeVideoPlayerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return AspectRatio(
//               aspectRatio: _controller.value.aspectRatio,
//               child: VideoPlayer(_controller),
//             );
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

List<CameraDescription> cameras = [];
List<String> videoPagePath = [];

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  VideoPageState createState() => VideoPageState();
}

class VideoPageState extends State<VideoPage> {
  @override
  void initState() {
    super.initState();
    _loadVideoPageMediaFilePaths();
  }

  Future<void> _loadVideoPageMediaFilePaths() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      videoPagePath = prefs.getStringList('mediaVideoPageFilePaths') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showImageSourceSelectionDialog,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Media Capture and View'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: videoPagePath.length,
              // crossAxisCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onLongPress: () => _showDeleteConfirmationDialog(index),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => VideoFullScreenPage(
                        videoPath: videoPagePath[index],
                      ),
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.file(File(videoPagePath[index])),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showImageSourceSelectionDialog() async {
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
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TakeImageScreen(
                        onImageCapture: () {
                          setState(() {});
                        },
                      ),
                    ));
                  },
                  child: const Text('Capture from Camera'),
                ),
                const SizedBox(height: 10),
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
    if (!(await Permission.storage.request().isGranted)) {
      return;
    }

    final imagePicker = ImagePicker();
    final mediaFile = await imagePicker.pickVideo(source: source);
    if (mediaFile == null) {
      return;
    }

    setState(() {
      videoPagePath.add(mediaFile.path);
    });

    await _saveVideoPageMediaFilePaths();
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
      videoPagePath.removeAt(index);
    });
    await prefs.setStringList('mediaVideoPageFilePaths', videoPagePath);
  }

  Future<void> _saveVideoPageMediaFilePaths() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('mediaVideoPageFilePaths', videoPagePath);
  }
}

class VideoFullScreenPage extends StatefulWidget {
  final String videoPath;

  const VideoFullScreenPage({super.key, required this.videoPath});

  @override
  VideoFullScreenPageState createState() => VideoFullScreenPageState();
}

class VideoFullScreenPageState extends State<VideoFullScreenPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}

class TakeImageScreen extends StatefulWidget {
  final Function onImageCapture;

  const TakeImageScreen({super.key, required this.onImageCapture});

  @override
  TakeImageScreenState createState() => TakeImageScreenState();
}

class TakeImageScreenState extends State<TakeImageScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera Demo')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera_alt),
        onPressed: () async {
          await _initializeControllerFuture;
          final XFile file = await _controller.takePicture();
          final String filePath = file.path;
          setState(() {
            videoPagePath.add(filePath);
          });
          await _saveVideoPageMediaFilePaths();
          widget.onImageCapture();
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        },
      ),
    );
  }

  Future<void> _saveVideoPageMediaFilePaths() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('mediaVideoPageFilePaths', videoPagePath);
  }
}
