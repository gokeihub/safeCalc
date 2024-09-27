// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MediaPage extends StatefulWidget {
//   const MediaPage({super.key});

//   @override
//   _MediaPageState createState() => _MediaPageState();
// }

// class _MediaPageState extends State<MediaPage> {
//   final TextEditingController textEditingController =
//       TextEditingController(text: '');
//   List<String> mediaFilePaths = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadMediaFilePaths();
//   }

//   Future<void> _loadMediaFilePaths() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       mediaFilePaths = prefs.getStringList('mediaFilePaths') ?? [];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (b) {
//               return AlertDialog(
//                 content: Column(
//                   children: [
//                     TextField(
//                       controller: textEditingController,
//                     ),
//                     ElevatedButton(
//                       onPressed: () async {
//                         setState(() {
//                           mediaFilePaths.add(textEditingController.text);
//                         });
//                         await _saveMediaFilePaths();
//                       },
//                       child: const Text('Add'),
//                     )
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       appBar: AppBar(
//         title: const Text('Media Capture and View'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: _showImageSourceSelectionDialog,
//             child: const Text('Add Media'),
//           ),
//           Expanded(
//             child: GridView.builder(
//               itemCount: mediaFilePaths.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//               ),
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onLongPress: () => _showDeleteConfirmationDialog(index),
//                   child: Image.file(File(mediaFilePaths[index])),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _showImageSourceSelectionDialog() async {
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
//                     _captureMedia(ImageSource.camera);
//                   },
//                   child: const Text('Capture from Camera'),
//                 ),
//                 const SizedBox(height: 10),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     _captureMedia(ImageSource.gallery);
//                   },
//                   child: const Text('Pick from Gallery'),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _captureMedia(ImageSource source) async {
//     if (!(await Permission.storage.request().isGranted)) {
//       return; // Handle case where permission is not granted
//     }

//     final imagePicker = ImagePicker();
//     final mediaFile = await imagePicker.pickImage(source: source);
//     if (mediaFile == null) {
//       return; // User canceled image capture
//     }

//     setState(() {
//       mediaFilePaths.add(mediaFile.path);
//     });

//     await _saveMediaFilePaths();
//   }

//   Future<void> _saveMediaFilePaths() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('mediaFilePaths', mediaFilePaths);
//   }

//   Future<void> _showDeleteConfirmationDialog(int index) async {
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Delete Image?'),
//           content: const Text('Are you sure you want to delete this image?'),
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
//       mediaFilePaths.removeAt(index);
//     });
//     await prefs.setStringList('mediaFilePaths', mediaFilePaths);
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:video_player/video_player.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Media Capture and View',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MediaPage(),
//     );
//   }
// }

// class MediaPage extends StatefulWidget {
//   @override
//   _MediaPageState createState() => _MediaPageState();
// }

// class _MediaPageState extends State<MediaPage> {
//   List<String> mediaFilePaths = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadMediaFilePaths();
//   }

//   Future<void> _loadMediaFilePaths() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       mediaFilePaths = prefs.getStringList('mediaFilePaths') ?? [];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Media Capture and View'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: _showMediaSourceSelectionDialog,
//             child: Text('Add Media'),
//           ),
//           Expanded(
//             child: GridView.builder(
//               itemCount: mediaFilePaths.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//               ),
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onLongPress: () => _showDeleteConfirmationDialog(index),
//                   child: mediaFilePaths[index].endsWith('.mp4')
//                       ? VideoPlayerScreen(videoPath: mediaFilePaths[index])
//                       : Image.file(File(mediaFilePaths[index])),
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
//           title: Text('Add Media'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     _captureMedia(ImageSource.camera, MediaType.image);
//                   },
//                   child: Text('Capture Image from Camera'),
//                 ),
//                 SizedBox(height: 10),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     _captureMedia(ImageSource.gallery, MediaType.image);
//                   },
//                   child: Text('Pick Image from Gallery'),
//                 ),
//                 SizedBox(height: 10),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     _captureMedia(ImageSource.camera, MediaType.video);
//                   },
//                   child: Text('Capture Video from Camera'),
//                 ),
//                 SizedBox(height: 10),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     _captureMedia(ImageSource.gallery, MediaType.video);
//                   },
//                   child: Text('Pick Video from Gallery'),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _captureMedia(ImageSource source, MediaType mediaType) async {
//     if (!(await Permission.storage.request().isGranted)) {
//       return; // Handle case where permission is not granted
//     }

//     final imagePicker = ImagePicker();
//     final pickedFile = await (mediaType == MediaType.image
//         ? imagePicker.pickImage(source: source)
//         : imagePicker.pickVideo(source: source));

//     if (pickedFile == null) {
//       return; // User canceled media capture
//     }

//     setState(() {
//       mediaFilePaths.add(pickedFile.path);
//     });

//     await _saveMediaFilePaths();
//   }

//   Future<void> _saveMediaFilePaths() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('mediaFilePaths', mediaFilePaths);
//   }

//   Future<void> _showDeleteConfirmationDialog(int index) async {
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Delete Media?'),
//           content: Text('Are you sure you want to delete this media?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 _deleteMedia(index);
//                 Navigator.of(context).pop();
//               },
//               child: Text('Delete'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _deleteMedia(int index) async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       mediaFilePaths.removeAt(index);
//     });
//     await prefs.setStringList('mediaFilePaths', mediaFilePaths);
//   }
// }

// enum MediaType { image, video }

// class VideoPlayerScreen extends StatefulWidget {
//   final String? videoPath;

//   const VideoPlayerScreen({ super.key, this.videoPath}) ;

//   @override
//   _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
// }

// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//  late VideoPlayerController _controller;
//  late Future<void> _initializeVideoPlayerFuture;

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
//           return AspectRatio(
//             aspectRatio: _controller.value.aspectRatio,
//             child: VideoPlayer(_controller),
//           );
//         } else {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
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

// ignore_for_file: library_private_types_in_public_api










// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:video_player/video_player.dart';

// class MediaPage extends StatefulWidget {
//   const MediaPage({super.key});

//   @override
//   _MediaPageState createState() => _MediaPageState();
// }

// class _MediaPageState extends State<MediaPage> {
//   List<String> mediaFilePaths = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadMediaFilePaths();
//   }

//   Future<void> _loadMediaFilePaths() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       mediaFilePaths = prefs.getStringList('mediaFilePaths') ?? [];
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
//               itemCount: mediaFilePaths.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//               ),
//               itemBuilder: (context, index) {
//                 final filePath = mediaFilePaths[index];
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
//                     } else {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               ImageFullScreenPage(imagePath: filePath),
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
//                     _captureMedia(ImageSource.camera, MediaType.image);
//                   },
//                   child: const Text('Capture Image from Camera'),
//                 ),
//                 const SizedBox(height: 10),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     _captureMedia(ImageSource.gallery, MediaType.image);
//                   },
//                   child: const Text('Pick Image from Gallery'),
//                 ),
//                 const SizedBox(height: 10),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     _captureMedia(ImageSource.camera, MediaType.video);
//                   },
//                   child: const Text('Capture Video from Camera'),
//                 ),
//                 const SizedBox(height: 10),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     _captureMedia(ImageSource.gallery, MediaType.video);
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

//   Future<void> _captureMedia(ImageSource source, MediaType mediaType) async {
//     if (!(await Permission.storage.request().isGranted)) {
//       return; // Handle case where permission is not granted
//     }

//     final imagePicker = ImagePicker();
//     final pickedFile = await (mediaType == MediaType.image
//         ? imagePicker.pickImage(source: source)
//         : imagePicker.pickVideo(source: source));

//     if (pickedFile == null) {
//       return; // User canceled media capture
//     }

//     setState(() {
//       mediaFilePaths.add(pickedFile.path);
//     });

//     await _saveMediaFilePaths();
//   }

//   Future<void> _saveMediaFilePaths() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('mediaFilePaths', mediaFilePaths);
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
//       mediaFilePaths.removeAt(index);
//     });
//     await prefs.setStringList('mediaFilePaths', mediaFilePaths);
//   }
// }

// enum MediaType { image, video }

// class VideoThumbnail extends StatefulWidget {
//   final String? videoPath;

//   const VideoThumbnail({super.key, this.videoPath});

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

// class ImageFullScreenPage extends StatelessWidget {
//   final String? imagePath;

//   const ImageFullScreenPage({super.key, this.imagePath});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () => Navigator.pop(context),
//         child: Center(
//           child: Hero(
//             tag: imagePath!,
//             child: Image.file(
//               File(imagePath!),
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class VideoPlayerScreen extends StatefulWidget {
//   final String videoPath;

//   const VideoPlayerScreen({super.key, required this.videoPath});

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
