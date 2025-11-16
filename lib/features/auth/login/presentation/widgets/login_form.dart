import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_hub/constant.dart';
import 'package:travel_hub/core/services/auth_services.dart';
import 'package:travel_hub/core/utils/app_router.dart';
import 'custom_text_field.dart';
import 'social_button.dart';
import 'sign_up_text.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  Future<void> signIn(
    BuildContext context,
    String email,
    String password,
  ) async {
    final authService = AuthService();

    try {
      final user = await authService.loginUser(email, password);
      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userEmail', user.email ?? '');
        await prefs.setString('userName', user.displayName ?? 'User');
        await prefs.setString('userUID', user.uid);

        GoRouter.of(context).pushReplacement(AppRouter.kNavigationView);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
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
      padding: EdgeInsetsDirectional.symmetric(
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
              label: "Email Address".tr(),
              controller: email,
              keyboard: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your email".tr();
                } else if (!value.contains("@")) {
                  return "Please enter a valid email".tr();
                }
                return null;
              },
            ),
            SizedBox(height: height * 0.02),
            CustomTextField(
              icon: Icons.lock_outline,
              label: "Password".tr(),
              obscureText: true,
              suffixIcon: Icons.visibility_off_outlined,
              controller: password,
              keyboard: TextInputType.visiblePassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your password".tr();
                } else if (value.length < 5) {
                  return "Please enter a strong password".tr();
                } else {
                  return null;
                }
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?".tr(),
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
                  "Sign In".tr(),
                  style: TextStyle(
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.w600,
                    color: kWhite,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            Text("or".tr(), style: TextStyle(color: kBlack)),
            SizedBox(height: height * 0.02),
            SocialButton(
              icon: Icons.g_mobiledata,
              text: "Continue with Google".tr(),
              color: kRed,
            ),
            SizedBox(height: height * 0.015),
            SocialButton(
              icon: Icons.facebook,
              text: "Continue with Facebook".tr(),
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
