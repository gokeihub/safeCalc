// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:flutter/material.dart';

// class Config {
//   static final _config = FirebaseRemoteConfig.instance;

//   static Future<void> initConfig() async {
//     try {
//       await _config.setConfigSettings(RemoteConfigSettings(
//         fetchTimeout: const Duration(minutes: 1),
//         minimumFetchInterval: const Duration(minutes: 30),
//       ));

//       // Uncomment and define default values if needed
//       // await _config.setDefaults(const {
//       //   "show_ads": true,
//       // });

//       await _config.fetchAndActivate();
//       _config.onConfigUpdated.listen((event) async {
//         await _config.activate();
//         // Optionally, add logging or other actions here
//         debugPrint('Remote Config updated and activated');
//       });
//     } catch (e) {
//       debugPrint('Failed to initialize Remote Config: $e');
//     }
//   }

//   static String get titleText => _config.getString('title');

// }