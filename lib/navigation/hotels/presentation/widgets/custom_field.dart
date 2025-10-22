import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_hub/constant.dart';

class CustomField extends StatelessWidget {
  final String title;
  final double width;
  final String? hint;
  final IconData? icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final TextInputType? keyboard;
  const CustomField({
    super.key,
    required this.title,
    required this.width,
    this.hint,
    this.icon,
    required this.controller,
    required this.validator,
    this.onTap,
    this.keyboard
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: kBlack, fontSize: 14.r),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8.r, horizontal: 4.r),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(14.r),
          //   color: Color(0xffF3F3F5),
          //   boxShadow: [
          //     BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 1),
          //   ],
          // ),
          child: TextFormField(
            controller: controller,
            validator: validator,
            cursorColor: kGrey,
            cursorWidth: 1.5.w,
            onTap: onTap,
            keyboardType: keyboard,
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: BorderSide(color: kAssets),
              ),
              prefixIcon: Icon(icon, color: kAssets, size: 20.r),
              hintText: hint,
              hintStyle: TextStyle(color: kAssets),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
