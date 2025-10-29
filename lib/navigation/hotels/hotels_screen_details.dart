import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hub/constant.dart';
import 'package:travel_hub/core/utils/app_router.dart';
import 'package:travel_hub/navigation/hotels/models/hotels_model.dart';
import 'package:travel_hub/navigation/hotels/presentation/widgets/custom_button.dart';

class HotelsScreenDetails extends StatelessWidget {
  final Hotels hotels;
  const HotelsScreenDetails(this.hotels, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 85.w),
            Text(
              "Hotel Details",
              style: TextStyle(color: kBlack, fontSize: 16.sp),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 16.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.r),
                child: Image.network(hotels.imageUrl, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            hotels.name,
                            style: TextStyle(color: kBlack, fontSize: 16.sp),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "${hotels.reviewsCount}",
                            style: TextStyle(color: kAssets, fontSize: 16.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            hotels.city,
                            style: TextStyle(color: kAssets, fontSize: 14.sp),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "reviews",
                            style: TextStyle(color: kAssets, fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.star_rate, color: kStar),
                      SizedBox(width: 3.w),
                      Text(
                        "${hotels.stars}",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              elevation: 5.r,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About",
                      style: TextStyle(color: kBlack, fontSize: 18.sp),
                    ),
                    Text(
                      hotels.description,
                      style: TextStyle(color: kAssets, fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 5.r,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Facilities",
                      style: TextStyle(color: kBlack, fontSize: 18.sp),
                    ),
                    ...List.generate(hotels.facilities.length, (index) {
                      return Row(
                        children: [
                          Icon(Icons.check, color: KCheck),
                          Text(
                            " ${hotels.facilities[index]}",
                            style: TextStyle(color: kAssets, fontSize: 16.sp),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 5.r,
              color: kBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              "Price per night",
                              style: TextStyle(color: kWhite, fontSize: 14.sp),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "${hotels.pricePerNight} EGP",
                              style: TextStyle(color: kWhite, fontSize: 16.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomButton(
                      buttonText: "Book Now",
                      buttonColor: kWhite,
                      textColor: kBackgroundColor,
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.kBookView);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
