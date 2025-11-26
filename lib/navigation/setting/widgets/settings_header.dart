import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_hub/core/utils/assets.dart';

class SettingsHeader extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const SettingsHeader({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  State<SettingsHeader> createState() => _SettingsHeaderState();
}

class _SettingsHeaderState extends State<SettingsHeader> {
  String? userName;
  String? userEmail;
  File? localImage;
  String? savedImageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> pickAndUploadImage() async {
    try {
      final ImagePicker picker = ImagePicker();

      final source = await showModalBottomSheet<ImageSource>(
        context: context,
        builder: (BuildContext sheetContext) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: Text('Camera'.tr()),
                  onTap: () => Navigator.pop(sheetContext, ImageSource.camera),
                ),
                ListTile(
                  leading: const Icon(Icons.photo),
                  title: Text('Gallery'.tr()),
                  onTap: () => Navigator.pop(sheetContext, ImageSource.gallery),
                ),
              ],
            ),
          );
        },
      );

      if (source == null) return;

      final XFile? pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (pickedFile == null) return;

      setState(() {
        localImage = File(pickedFile.path);
      });

      final user = FirebaseAuth.instance.currentUser;

      if (user == null) return;

      final storageRef = FirebaseStorage.instance
          .ref()
          .child("profile_images")
          .child("${user.uid}.jpg");

      await storageRef.putFile(localImage!);

      final downloadURL = await storageRef.getDownloadURL();

      await user.updatePhotoURL(downloadURL);
      await user.reload();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("profileImage", downloadURL);

      setState(() {
        savedImageUrl = downloadURL;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Profile picture has been updated successfully".tr()),
        ),
      );
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'User Name';
      userEmail = prefs.getString('userEmail') ?? 'user@email.com';
      savedImageUrl = prefs.getString("profileImage");
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsetsDirectional.all(20.r),
      color: theme.appBarTheme.backgroundColor,
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 35.r,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: localImage != null
                    ? FileImage(localImage!)
                    : savedImageUrl != null
                    ? NetworkImage(savedImageUrl!)
                    : null,

                child: (localImage == null && savedImageUrl == null)
                    ? Icon(Icons.person, size: 35.r)
                    : null,
              ),
              InkWell(
                onTap: pickAndUploadImage,
                child: Container(
                  width: 25.w,
                  height: 25.h,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 18.r,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 15.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName ?? '',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  userEmail ?? '',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: widget.onToggleTheme,
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 12.h,
                vertical: 8.h,
              ),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.grey[200],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(
                    isDark
                        ? Icons.light_mode_outlined
                        : Icons.dark_mode_outlined,
                    size: 20.w,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    isDark ? "light_mode".tr() : "dark_mode".tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
