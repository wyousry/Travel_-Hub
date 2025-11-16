import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://latoya-traumatic-delmer.ngrok-free.dev";

  static Future<dynamic> sendImage(File imageFile) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/predict'),
      );

      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );

      final streamed = await request.send();
      final response = await streamed.stream.bytesToString();

      final decodedResponse = jsonDecode(response);

      if (streamed.statusCode == 200) {

        return decodedResponse; 
      } else {
        return decodedResponse;
      }
    } catch (e) {
      return {"error": e.toString()};
    }
  }
}