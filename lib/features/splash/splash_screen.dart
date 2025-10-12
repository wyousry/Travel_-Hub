import 'package:flutter/material.dart';
import 'package:travel_hub/features/splash/widgets/splash_view_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashViewBody(),
    );
  }
}
