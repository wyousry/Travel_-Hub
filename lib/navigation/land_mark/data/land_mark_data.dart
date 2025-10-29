import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:travel_hub/navigation/land_mark/models/land_mark_model.dart';



class EgLandMark {
  static Future<List<LandMark>> getLandMark() async {
    final response = await rootBundle.loadString(
      "assets/data/egypt_landmarks_final.json",
    );
    final decoded = jsonDecode(response);
    final List landMark = decoded;
    return landMark.map((e) => LandMark.fromJson(e)).toList();
  }
}
