import 'package:flutter/material.dart';
import 'dart:typed_data';
import '../services/gemini_image_generator.dart';

class RecipeStepsScreen extends StatefulWidget {
  final List<String> recipeSteps;
  const RecipeStepsScreen({super.key, required this.recipeSteps});

  @override
  State<RecipeStepsScreen> createState() => _RecipeStepsScreenState();
}

class _RecipeStepsScreenState extends State<RecipeStepsScreen> {
  final HFImageGenerator _imageGenerator = HFImageGenerator();
  final Map<int, Uint8List?> _generatedImages = {};
  final Set<int> _loadingIndices = {};
  late List<String> cleanSteps;

  @override
  void initState() {
    super.initState();
    cleanSteps = widget.recipeSteps.where((s) {
      final text = s.trim().toLowerCase();
      return text.length > 5 && !text.contains("instructions");
    }).toList();

    _startSequentialGeneration();
  }

  Future<void> _startSequentialGeneration() async {
    for (int i = 0; i < cleanSteps.length; i++) {
      if (!mounted) return;

      setState(() => _loadingIndices.add(i));

      final image = await _imageGenerator.textToImage(cleanSteps[i]);

      if (mounted) {
        setState(() {
          _generatedImages[i] = image;
          _loadingIndices.remove(i);
        });
      }

      print("Waiting 25 seconds before next image...");
      await Future.delayed(const Duration(seconds: 10));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Automated Cooking Guide")),
      body: ListView.builder(
        itemCount: cleanSteps.length,
        itemBuilder: (context, index) {
          final image = _generatedImages[index];
          final isLoading = _loadingIndices.contains(index);

          return Card(
            margin: const EdgeInsets.all(12),
            child: Column(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: image != null
                      ? Image.memory(image, fit: BoxFit.cover)
                      : isLoading
                      ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                      ],
                    ),
                  )
                      : const Center(child: Text("Waiting in queue...")),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(cleanSteps[index], style: const TextStyle(fontSize: 16)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}