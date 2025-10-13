import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hub/constant.dart';
import 'package:travel_hub/core/utils/app_router.dart';
import 'package:travel_hub/features/hotels/presentation/widgets/custom_button.dart';

class HotelsScreen extends StatefulWidget {
  const HotelsScreen({super.key});

  @override
  State<HotelsScreen> createState() => _hotelsScreen();
}

class _hotelsScreen extends State<HotelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite,
        title: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Hotels",
                style: TextStyle(
                    color: kBlack,
                    fontSize: 24.sp
                ),
              ),
              Text(
                "Find your perfect stay",
                style: TextStyle(
                    color: kAssets,
                    fontSize: 16.sp
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: kWhite,
      body: Padding(
        padding: EdgeInsetsGeometry.all(16.r),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              elevation: 5.r,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              margin: EdgeInsets.all(5.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ClipRRect(
                  //   borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  //   child: Image.network(
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
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
                                    "Grand Palace Hotel",
                                    style: TextStyle(
                                        color: kBlack,
                                        fontSize: 16.sp
                                    ),
                                  ),
                                )
                            ),
                            Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "\$289",
                                    style: TextStyle(
                                        color: kPriceColor,
                                        fontSize: 16.sp
                                    ),
                                  ),
                                )
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Paris, France",
                                    style: TextStyle(
                                        color: kAssets,
                                        fontSize: 14.sp
                                    ),
                                  ),
                                )
                            ),
                            Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "per night",
                                    style: TextStyle(
                                        color: kAssets,
                                        fontSize: 14.sp
                                    ),
                                  ),
                                )
                            ),
                          ],
                        ),
                        CustomButton(
                          buttonText: "Book Now",
                          onPressed: (){
                            GoRouter.of(context).push(AppRouter.kBookView);

                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: 10,
        ),
      ),
    );
  }
}
