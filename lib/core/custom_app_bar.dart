import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_hub/constant.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? bottomWidget; 
  final bool centerTitle;
  final Color backgroundColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.bottomWidget,
    this.centerTitle = true,
    this.backgroundColor = kWhite,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: centerTitle,
      title: Column(
        crossAxisAlignment: centerTitle ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: kBlack,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (bottomWidget != null) ...[
            SizedBox(height: 4.h),
            bottomWidget!,
          ],
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.h);
}
