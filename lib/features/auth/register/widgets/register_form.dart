import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_hub/constant.dart';
import 'package:travel_hub/core/utils/app_router.dart';

import '../../login/presentation/widgets/custom_text_field.dart';
import '../../login/presentation/widgets/sign_in_text.dart';
import '../../login/presentation/widgets/social_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  bool _loading = false;

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  Future<void> _setLoading(bool v) async {
    if (!mounted) return;
    setState(() => _loading = v);
  }

 Future<void> signUp(BuildContext context) async {
  if (_loading) return;
  await _setLoading(true);

  try {

    final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.text.trim(),
      password: password.text.trim(),
    );

   
    await FirebaseFirestore.instance.collection('users').doc(cred.user!.uid).set({
      'name': name.text.trim(),
      'email': email.text.trim(),
      'phone': phone.text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    if (name.text.trim().isNotEmpty) {
      await cred.user?.updateDisplayName(name.text.trim());
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Account created successfully!")),
    );

    GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
  } on FirebaseAuthException catch (e) {
    String message;
    if (e.code == 'email-already-in-use') {
      message = 'This email is already registered.';
    } else if (e.code == 'weak-password') {
      message = 'Your password is too weak.';
    } else if (e.code == 'invalid-email') {
      message = 'Please enter a valid email.';
    } else {
      message = 'Registration failed. Please try again.';
    }
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  } finally {
    await _setLoading(false);
  }
}

  /*Future<void> signInWithGoogle(BuildContext context) async {
    if (_loading) return;
    await _setLoading(true);

    try {
      if (kIsWeb) {
        final provider = GoogleAuthProvider();
        final userCredential = await FirebaseAuth.instance.signInWithPopup(provider);
    
        } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) {
       
          await _setLoading(false);
          return;
        }

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signed in with Google successfully!")),
      );
      GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('FirebaseAuth: ${e.message}')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Google Sign-In failed: $e')));
      }
    } finally {
      await _setLoading(false);
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
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
                icon: Icons.person,
                label: "Full Name",
                controller: name,
                keyboard: TextInputType.name,
                validator: (value) =>
                    value == null || value.isEmpty ? "Please enter your name" : null,
              ),
              SizedBox(height: height * 0.02),
              CustomTextField(
                icon: Icons.email_outlined,
                label: "Email Address",
                controller: email,
                keyboard: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Please enter your email";
                  if (!value.contains("@")) return "Please enter a valid email";
                  return null;
                },
              ),
              SizedBox(height: height * 0.02),
              CustomTextField(
                icon: Icons.phone_android_outlined,
                label: "Phone",
                controller: phone,
                keyboard: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Please enter your phone";
                  if (!RegExp(r'^01[0-9]{9}$').hasMatch(value)) {
                    return 'Please enter a valid Egyptian phone number';
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
                validator: (value) {
                  if (value == null || value.isEmpty) return "Please enter your password";
                  if (value.length < 6) return "Password must be at least 6 characters";
                  return null;
                },
              ),
              SizedBox(height: height * 0.02),
              CustomTextField(
                icon: Icons.lock_outline,
                label: "Confirm Password",
                obscureText: true,
                suffixIcon: Icons.visibility_off_outlined,
                controller: confirmPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Please confirm your password";
                  if (value != password.text) return "Passwords don’t match";
                  return null;
                },
              ),
              SizedBox(height: height * 0.05),

      
              SizedBox(
                width: double.infinity,
                height: height * 0.065,
                child: ElevatedButton(
                  onPressed: _loading
                      ? null
                      : () {
                          if (key.currentState!.validate()) {
                            signUp(context);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPriceColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width * 0.03),
                    ),
                  ),
                  child: _loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Text(
                          "Create Account",
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

          
              SocialButton(
                icon: Icons.g_mobiledata,
                text: "Continue with Google",
                color: kRed,
                onPressed: _loading ? null : () => signUp(context),
              ),

              SizedBox(height: height * 0.015),

         
              SocialButton(
                icon: Icons.facebook,
                text: "Continue with Facebook",
                color: kBackgroundColor,
                onPressed: () {
                },
              ),
              SizedBox(height: height * 0.015),
              const SignInText(),
            ],
          ),
        ),
      ),
    );
  }
}
