import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageAnalyzeScreen extends StatefulWidget {
  final String base64image;

  const ImageAnalyzeScreen({super.key, required this.base64image});

  @override
  _ImageAnalyzeScreenState createState() => _ImageAnalyzeScreenState();
}

class _ImageAnalyzeScreenState extends State<ImageAnalyzeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Analysis")),
      body: Center(
        child: Text(widget.base64image.substring(0, 25)),
      ),
    );
  }
}