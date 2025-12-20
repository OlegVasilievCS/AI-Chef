import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class GeminiImageGenerator {
  final String baseUrl = "https://image.pollinations.ai/prompt";

  Future<Uint8List?> textToImage(String prompt) async {
    try {
      final formattedPrompt = prompt.replaceAll(' ', '_');
      final url = "$baseUrl/$formattedPrompt?width=1024&height=1024&nologo=true";

      print("Trying Pollinations with URL: $url");

      final response = await http.get(Uri.parse(url))
          .timeout(const Duration(seconds: 90));

      print("Pollinations response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("Image generated successfully with Pollinations!");
        return response.bodyBytes;
      } else {
        print("Pollinations error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Pollinations request failed: $e");
      return null;
    }
  }
}