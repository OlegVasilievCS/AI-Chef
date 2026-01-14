import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class HFImageGenerator {
  final String baseUrl = "https://router.huggingface.co/hf-inference/models";
  final String modelId = "stabilityai/stable-diffusion-xl-base-1.0";
  String get apiKey => dotenv.env['HF_API_KEY'] ?? "";

  final Map<String, Uint8List> _cache = {};

  Future<Uint8List?> textToImage(String prompt) async {
    if (_cache.containsKey(prompt)) return _cache[prompt];

    final url = Uri.parse("$baseUrl/$modelId");
    try {
      print("Starting generation for: ${prompt.substring(0, 20)}...");

      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
          "x-use-cache": "false",
        },
        body: jsonEncode({
          "inputs": prompt,
          "parameters": {"width": 1024, "height": 1024, "wait_for_model": true}
        }),
      ).timeout(const Duration(seconds: 90));

      if (response.statusCode == 200) {
        _cache[prompt] = response.bodyBytes;
        return response.bodyBytes;
      }
      return null;
    } catch (e) {
      print("Generation failed: $e");
      return null;
    }
  }
}