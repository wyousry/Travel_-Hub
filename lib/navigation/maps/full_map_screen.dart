import 'package:flutter/material.dart';

class FullMapScreen extends StatelessWidget {
  const FullMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width >= 600;
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(isWide ? 24 : 16),
          child: Text(
            "🗺️ This is the full map view",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: isWide ? 18 : 16),
          ),
        ),
      ),
    );
  }
}
