import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hub/core/utils/app_router.dart';
import 'package:travel_hub/constant.dart';
import 'package:travel_hub/navigation/hotels/data/cubit/hotels_cubit.dart';
import 'package:travel_hub/navigation/hotels/data/cubit/hotels_state.dart';
import 'package:travel_hub/navigation/hotels/models/hotels_model.dart';
import 'custom_button.dart';

class HotelsList extends StatelessWidget {
  final HotelsSuccess state;

  const HotelsList({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.numHotels,
            itemBuilder: (context, index) {
              final hotel = state.hotels[index];
              return HotelCard(hotel: hotel);
            },
          ),

          // زر "See more"
          TextButton(
            onPressed: () {
              context.read<HotelsCubit>().loadMoreHotels();
            },
            child: Text(
              "See more",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}

class HotelCard extends StatelessWidget {
  final Hotels hotel;
  const HotelCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 5,
      color: theme.cardColor,
      shadowColor: isDark ? Colors.white54 : Colors.black26, 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      margin: EdgeInsetsDirectional.all(8.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HotelImage(imageUrl: hotel.imageUrl, stars: hotel.stars.toDouble()),
          Padding(
            padding: EdgeInsetsDirectional.all(12.r),
            child: Column(
              children: [
                _HotelInfoRow(
                  leftText: hotel.name,
                  rightText: "${hotel.pricePerNight} EGP",
                  leftColor: theme.textTheme.bodyMedium?.color ?? kBlack,
                  rightColor: theme.colorScheme.primary,
                ),
                SizedBox(height: 4.h),
                _HotelInfoRow(
                  leftText: hotel.city,
                  rightText: "per night",
                  leftColor: theme.textTheme.bodyMedium?.color?.withOpacity(0.7) ?? kAssets,
                  rightColor: theme.textTheme.bodyMedium?.color?.withOpacity(0.7) ?? kAssets,
                ),
                SizedBox(height: 10.h),
                CustomButton(
                  buttonText: "Book Now",
                  onPressed: () => GoRouter.of(context).push(AppRouter.kBookView),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HotelImage extends StatelessWidget {
  final String imageUrl;
  final double stars;
  const _HotelImage({required this.imageUrl, required this.stars});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Stack(
      alignment: Alignment.topRight,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          child: Image.network(
            imageUrl,
            height: 180.h,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin: EdgeInsetsDirectional.all(8.r),
          width: 62.w,
          height: 28.h,
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[900] : kWhite,
            borderRadius: BorderRadius.circular(50.r),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.white24 : Colors.black26,
                blurRadius: 3,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star_rate, color: Colors.amber, size: 18.sp),
              SizedBox(width: 3.w),
              Text(
                stars.toString(),
                style: TextStyle(color: theme.textTheme.bodyMedium?.color ?? kBlack),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HotelInfoRow extends StatelessWidget {
  final String leftText;
  final String rightText;
  final Color leftColor;
  final Color rightColor;

  const _HotelInfoRow({
    required this.leftText,
    required this.rightText,
    required this.leftColor,
    required this.rightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              leftText,
              style: TextStyle(color: leftColor, fontSize: 16.sp),
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              rightText,
              style: TextStyle(color: rightColor, fontSize: 16.sp),
            ),
          ),
        ),
      ],
    );
  }
}
