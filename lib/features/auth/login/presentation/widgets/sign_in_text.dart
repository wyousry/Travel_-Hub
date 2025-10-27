import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hub/constant.dart';
import 'package:travel_hub/core/utils/app_router.dart';
class SignInText extends StatelessWidget {
  const SignInText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account? ", style: TextStyle(color: kBlack)),
        GestureDetector(
          onTap: () {GoRouter.of(context).pushReplacement(AppRouter.kLoginView);},
          child: const Text(
            "Sign In",
            style: TextStyle(
              color: kBackgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
