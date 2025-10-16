import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_hub/constant.dart';

class HotelsHeader extends StatelessWidget {
  const HotelsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Text(
         "Find your perfect stay",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kAssets,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
