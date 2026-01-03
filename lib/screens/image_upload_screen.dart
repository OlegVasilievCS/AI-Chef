import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/image_analysis_service.dart';
import 'image_analyze_screen.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  String imagePath = '';
  String base64ImageString = '';


  Future <String> _fetchImageAnalysis(String base64String) async {

    ImageAnalysisService imageAnalysisService = ImageAnalysisService();
    String analysis = await imageAnalysisService.getAnalysis(base64String);

    return analysis;

    }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chef Image Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      imagePath = image.path;
                    });
                    final bytes = await image.readAsBytes();
                    base64ImageString = base64Encode(bytes);
                  }
                },
                child: const Text('Pick Image'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image = await picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    setState(() {
                      imagePath = image.path;
                    });
                  }
                },
                child: const Text('Capture Photo'),
            ),
            const SizedBox(height: 20),
            if (imagePath.isNotEmpty)
              Image.file(
                File(imagePath),
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ElevatedButton(
              onPressed: () async {
                String ingredient_list = await _fetchImageAnalysis(base64ImageString);

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ImageAnalyzeScreen(base64imageList: ingredient_list)
                  ),
                );
                print("Test Oleg" + base64ImageString);
                print("Test Oleg End");
              },
              child: const Text('Analyze Photo'),
            ),
          ],
        ),
      ),
    );
  }
}