import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'image_analyze_screen.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  String imagePath = '';
  String base64ImageString = '';

  // Future<String> imageBytestoBase64(FFUploadedFile uploadedFile) async {
  //   // Add your function code here!
  //   if (uploadedFile.bytes == null) {
  //     throw Exception('No file bytes found.');
  //   }
  //   return base64Encode(uploadedFile.bytes!);
  // }


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
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ImageAnalyzeScreen(base64image: base64ImageString),
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