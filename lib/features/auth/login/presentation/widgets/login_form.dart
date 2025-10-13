import 'package:flutter/material.dart';
import 'package:travel_hub/constant.dart';
import 'custom_text_field.dart';
import 'social_button.dart';
import 'sign_up_text.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.03,
      ),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(width * 0.05),
      ),
      child: Column(
        children: [
          const CustomTextField(
            icon: Icons.email_outlined,
            label: "Email Address",
          ),
          SizedBox(height: height * 0.02),
          const CustomTextField(
            icon: Icons.lock_outline,
            label: "Password",
            obscureText: true,
            suffixIcon: Icons.visibility_off_outlined,
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
              onPressed: () {},
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
    );
  }
}
