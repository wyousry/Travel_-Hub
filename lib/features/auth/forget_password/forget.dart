import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hub/constant.dart';
import 'package:travel_hub/core/utils/app_router.dart';
import 'package:travel_hub/core/utils/assets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _loading = false;

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  Future<void> _resetPassword() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      _showMessage('Please enter your email');
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      GoRouter.of(context).go(AppRouter.kSuccess);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showMessage("This email doesn't exist");
      } else if (e.code == 'invalid-email') {
        _showMessage("Invalid email format");
      } else {
        _showMessage("Something went wrong, try again later");
      }
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(gradient: linearGradient),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24,),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        GoRouter.of(context).go(AppRouter.kLoginView);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                     Expanded(
                      child: Center(
                        child: Text(
                          'Forgot your password ?',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                     SizedBox(width: 48.w),
                  ],
                ),
                const SizedBox(height: 60),
                Center(
                  child: Container(
                    width: width * 0.26,
                    height: width * 0.26,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: loginGradient,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(width * 0.07),
                      child: Image.asset(
                        AssetsData.loginLogo,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                 SizedBox(height: 80.h),
                 Center(
                  child: Text(
                    'Enter your email address',
                    style: TextStyle(fontSize: 24.sp, color: kWhite),
                  ),
                ),
                 SizedBox(height: 20.h),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Email',
                    contentPadding:  EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: kWhite),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:  BorderSide(
                        color: kWhite,
                        width: 1.2.w,
                      ),
                    ),
                    filled: true,
                    fillColor: kWhite,
                  ),
                ),
                 SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _resetPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPriceColor,
                      foregroundColor: kWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      elevation: 0,
                    ),
                    child: _loading
                        ? const CircularProgressIndicator(color: kWhite)
                        :  Text(
                            'Reset Password',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
