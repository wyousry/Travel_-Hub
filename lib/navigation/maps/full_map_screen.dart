import 'package:flutter/material.dart';
import 'package:travel_hub/core/custom_app_bar.dart';

class FullMapScreen extends StatelessWidget {
  const FullMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Map",
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all( 24),
          child: Text(
            "This is the full map view",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
