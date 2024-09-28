import 'package:calculetor/pages/Home/pages/image_page.dart';
import 'package:calculetor/pages/calculator_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //   theme: ThemeData(
      //   brightness: Brightness.light,
      //   primaryColor: Colors.blueAccent,
      //   iconTheme: const IconThemeData(color: Colors.black54),
      // ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white70),
      ),
      // themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: CalculatorPage(),
    );
  }
}