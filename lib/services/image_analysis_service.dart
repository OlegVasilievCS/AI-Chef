import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ImageAnalysisService {
  final String _apiKey = dotenv.env['GEMINI_API_KEY'] ?? "";

  final String _baseUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent";


  Future<String> getAnalysis(String base64string) async {
    if (_apiKey.isEmpty) return "Error: API Key not found";

    try {
      final response = await http.post(
        Uri.parse("$_baseUrl?key=$_apiKey"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {
                  "inline_data": {
                    "mime_type": "image/jpeg",
                    "data": base64string
                  }
                },
                {"text": "Caption this image but only return a list of food ingredients found in the image. Do not refer to "
                    "the request itself, only return a list of items. Do not use any symbols."}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['candidates'][0]['content']['parts'][0]['text'];
      } else {
        return "Error: ${response.statusCode} - ${response.body}";
      }
    } catch (e) {
      return "Exception: $e";
    }
  }
}