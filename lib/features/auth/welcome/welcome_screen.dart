import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hub/constant.dart';
import 'package:travel_hub/core/utils/app_router.dart';
import 'package:travel_hub/features/auth/welcome/future_item.dart';

class TravelWelcomeScreen extends StatelessWidget {
  const TravelWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(gradient: loginGradient),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: width * 0.06,
              vertical: height * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.025),
                Container(
                  padding: EdgeInsets.all(width * 0.05),
                  decoration: BoxDecoration(
                    color: kWhite.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.flight_takeoff,
                    size: width * 0.12,
                    color: kWhite,
                  ),
                ),
                SizedBox(height: height * 0.03),
                Text(
                  'TravelMate',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: width * 0.07,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  'Discover. Explore. Experience.',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: width * 0.04,
                  ),
                ),
                SizedBox(height: height * 0.045),
                const FeatureItem(
                  icon: Icons.location_on,
                  title: 'Discover Amazing Places',
                  description:
                      'Find hidden gems and popular destinations worldwide',
                ),
                SizedBox(height: height * 0.025),
                const FeatureItem(
                  icon: Icons.camera_alt,
                  title: 'AI-Powered Recognition',
                  description:
                      'Identify landmarks instantly with our smart camera',
                ),
                SizedBox(height: height * 0.025),
                const FeatureItem(
                  icon: Icons.person,
                  title: 'Personalized Experience',
                  description:
                      'Get recommendations tailored to your preferences',
                ),
                const Spacer(),
                Text(
                  'Ready to start your journey?',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: width * 0.04,
                  ),
                ),
                SizedBox(height: height * 0.006),
                Text(
                  'Join millions of travelers exploring the world',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: width * 0.035,
                  ),
                ),
                SizedBox(height: height * 0.03),
                ElevatedButton(
                  onPressed: () {
                  GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPriceColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width * 0.03),
                    ),
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: width * 0.25,
                      vertical: height * 0.018,
                    ),
                  ),
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w600,
                      color: kWhite,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
