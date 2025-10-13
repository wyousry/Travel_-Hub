import 'package:flutter/material.dart';
import 'package:travel_hub/constant.dart';
import '../widgets/login_header.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: linearGradient),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.08,
            vertical: size.height * 0.08,
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LoginHeader(),
              SizedBox(height: 30),
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
