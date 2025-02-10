import 'dart:convert';
import 'package:http/http.dart' as http;

class UrlShortenerService {
  final String _baseURL = "https://ushort-ldis.onrender.com";


  Future<String?> shortenUrl(String originalUrl, {String? customShortCode}) async {
    if (originalUrl.isEmpty) {
      return "Please enter a valid URL!";
    }

    try {
      Uri apiUrl = Uri.parse(_baseURL + "/shorten");

      Map<String, String> requestBody = {"originalUrl": originalUrl};
      if (customShortCode != null && customShortCode.isNotEmpty) {
        requestBody["customShortCode"] = customShortCode;
      }

      final response = await http.post(
        apiUrl,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: requestBody,
      );

      print("Raw Server Response: ${response.body}"); // Print raw response

      return response.body; // Return the raw response instead of decoding
    } catch (e) {
      return "Failed to connect to server: $e";
    }
  }
}
