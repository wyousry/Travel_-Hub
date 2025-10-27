import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_hub/constant.dart';
import 'package:travel_hub/core/utils/app_router.dart';

import 'custom_text_field.dart';
import 'social_button.dart';
import 'sign_up_text.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  Future<void> signIn(BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      GoRouter.of(context).pushReplacement(AppRouter.kHomeView);

    } on FirebaseAuthException catch (e) {
      String message;

      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      } else {
        message = 'Login failed. Please try again.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();
    final key = GlobalKey<FormState>();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.07,
        vertical: height * 0.03,
      ),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(width * 0.05),
      ),
      child: Form(
        key: key,
        child: Column(
          children: [
            CustomTextField(
              icon: Icons.email_outlined,
              label: "Email Address",
              controller: email,
              keyboard: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your email";
                } else if (!value.contains("@")) {
                  return "Please enter a valid email";
                }
                return null;
              },
            ),
            SizedBox(height: height * 0.02),
            CustomTextField(
              icon: Icons.lock_outline,
              label: "Password",
              obscureText: true,
              suffixIcon: Icons.visibility_off_outlined,
              controller: password,
              keyboard: TextInputType.visiblePassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your password";
                } else if (value.length < 5) {
                  return "Please enter a strong password";
                } else {
                  return null;
                }
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(color: kBackgroundColor),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: height * 0.065,
              child: ElevatedButton(
                onPressed: () {
                  if (key.currentState!.validate()) {
                    signIn(context, email.text.trim(), password.text.trim());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPriceColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width * 0.03),
                  ),
                ),
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.w600,
                    color: kWhite,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            const Text("or", style: TextStyle(color: kBlack)),
            SizedBox(height: height * 0.02),
            const SocialButton(
              icon: Icons.g_mobiledata,
              text: "Continue with Google",
              color: kRed,
            ),
            SizedBox(height: height * 0.015),
            const SocialButton(
              icon: Icons.facebook,
              text: "Continue with Facebook",
              color: kBackgroundColor,
            ),
            SizedBox(height: height * 0.015),
            const SignUpText(),
          ],
        ),
      ),
    );
  }
}
