import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_ai_app/services/gemini_image_generator.dart';
import 'dart:typed_data';

class RecipeStepsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecipeStepsScreenState();
}

class _RecipeStepsScreenState extends State<RecipeStepsScreen> {

  final GeminiImageGenerator geminiImageGenerator = GeminiImageGenerator();

  int leftDiceNumber = 1;
  int rightDiceNumber = 1;

  String response = "";

  Uint8List? imageBytes;


  void changeDiceFace() {
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1;
      rightDiceNumber = Random().nextInt(6) + 1;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
          onPressed: () async {
            final bytes = await geminiImageGenerator.textToImage("Wash and core the apples, then finely slice them. Slice the apricots.");
            setState(() {
              imageBytes = bytes;
            });
            },
        child: imageBytes == null
            ? Text("Generate Image")
            : Image.memory(imageBytes!),
      )
    );
  }

  }

