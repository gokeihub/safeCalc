import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInformationPage extends StatefulWidget {
  const AppInformationPage({super.key});

  @override
  State<AppInformationPage> createState() => _AppInformationPageState();
}

class _AppInformationPageState extends State<AppInformationPage> {
  String version = "";
  String appName = "";
  String packageName = "";

  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }

  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String versionNumber = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    setState(() {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = '$versionNumber+$buildNumber';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Information"),
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: const Text('App Version'),
              trailing: Text(version.toString()),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('App Name'),
              trailing: Text(appName.toString()),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Package Name'),
              trailing: Text(packageName.toString()),
            ),
          ),
        ],
      ),
    );
  }
}
