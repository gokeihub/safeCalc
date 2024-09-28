import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChangeLogPage extends StatefulWidget {
  const ChangeLogPage({super.key});

  @override
  ChangeLogPageState createState() => ChangeLogPageState();
}

class ChangeLogPageState extends State<ChangeLogPage> {
  String markdownData = '';

  @override
  void initState() {
    super.initState();
    loadMarkdown();
  }

  void loadMarkdown() async {
    String data = await rootBundle.loadString('CHANGELOG.md');
    setState(() {
      markdownData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chanage History'),
      ),
      body: Markdown(
        data: markdownData,
      ),
    );
  }
}
