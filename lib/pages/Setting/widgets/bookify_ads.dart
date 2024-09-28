// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookifyAds extends StatefulWidget {
  final String apiUrl;
  const BookifyAds({super.key, required this.apiUrl});

  @override
  BookifyAdsState createState() => BookifyAdsState();
}

class BookifyAdsState extends State<BookifyAds> {
  // Variables to hold API data
  String? url;
  String? image;
  String? main1Name;
  String? main2Name;
  bool isLoading = true;
  bool connectionStatus = true;
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    _loadSavedData(); // Load data from SharedPreferences
    fetchData();
    _checkConnection();
  }

  // Fetch data from API
  Future<void> fetchData() async {
    final apiUrl = widget.apiUrl;

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          url = data['url'];
          image = data['image'];
          main1Name = data['main1Name'];
          main2Name = data['main2Name'];
          isLoading = false;
        });
        _saveData(); // Save the fetched data to SharedPreferences
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle the exception
    }
  }

  // Save data to SharedPreferences
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('url', url ?? '');
    prefs.setString('image', image ?? '');
    prefs.setString('main1Name', main1Name ?? '');
    prefs.setString('main2Name', main2Name ?? '');
  }

  // Load saved data from SharedPreferences
  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      url = prefs.getString('url');
      image = prefs.getString('image');
      main1Name = prefs.getString('main1Name');
      main2Name = prefs.getString('main2Name');
      isLoading = false;
    });
  }

  Future<void> _checkConnection() async {
    try {
      List<ConnectivityResult> results =
          await _connectivity.checkConnectivity();
      if (results.contains(ConnectivityResult.mobile) ||
          results.contains(ConnectivityResult.wifi)) {
        setState(() {
          connectionStatus = true;
        });
      } else {
        setState(() {
          connectionStatus = false;
        });
      }
    } catch (e) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: SizedBox(),
      );
    }

    return connectionStatus
        ? GestureDetector(
            onTap: () async {
              if (url != null) {
                final Uri playStoreAppUrl = Uri.parse(url!);
                final Uri webUrl = Uri.parse(url!);

                if (await canLaunch(playStoreAppUrl.toString())) {
                  await launch(playStoreAppUrl.toString());
                } else {
                  await launch(webUrl.toString());
                }
              }
            },
            child: Card(
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 10),
                          CachedNetworkImage(
                            imageUrl: image ?? '',
                            errorWidget: (context, error, stackTrace) {
                              return const Icon(Icons.error);
                            },
                            height: 50,
                          ),
                          const SizedBox(width: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                main1Name ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                main2Name ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            height: 40,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Center(
                              child: Text("Install"),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
