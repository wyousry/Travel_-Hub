import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://latoya-traumatic-delmer.ngrok-free.dev"; 

  static Future<String> sendImageToModel(File imageFile) async {
    final request = http.MultipartRequest('POST', Uri.parse('$baseUrl/predict'));
    request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();
    final resBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final data = jsonDecode(resBody);
      return data['article'] ?? "No article found.";
    } else {
      return "Error: ${response.statusCode}";
    }
  }
}
