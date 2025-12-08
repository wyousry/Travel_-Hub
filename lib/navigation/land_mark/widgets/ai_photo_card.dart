import 'package:flutter/material.dart';
import 'package:travel_hub/constant.dart';

class AiPhotoCard extends StatelessWidget {
  final VoidCallback onPressed;

  const AiPhotoCard({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xfff7f8ff),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "AI Photo Description",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            "Take a photo and get an AI-powered\n"
            "description with audio narration",
            style: TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 16),

          gradientButton(onTap: onPressed),
        ],
      ),
    );
  }
}



Widget gradientButton({required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
      decoration: BoxDecoration(
        gradient: buttonGradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.camera_alt, color: kWhite, size: 18),
          SizedBox(width: 6),
          Text(
            "Take Photo",
            style: TextStyle(
              color: kWhite,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
  );
}
