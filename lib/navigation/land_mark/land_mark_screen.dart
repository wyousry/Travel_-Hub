import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hub/core/custom_app_bar.dart';
import 'package:travel_hub/core/utils/app_router.dart';
import 'package:travel_hub/navigation/land_mark/data/cubit/land_mark_cubit.dart';
import 'package:travel_hub/navigation/land_mark/data/cubit/land_mark_state.dart';

class LandMarkScreen extends StatefulWidget {
  const LandMarkScreen({super.key});

  @override
  State<LandMarkScreen> createState() => _LandMarkScreenState();
}

class _LandMarkScreenState extends State<LandMarkScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "Places to Visit".tr(),
        bottomWidget: Text(
          "Discover amazing destinations".tr(),
          style: TextStyle(color: textColor?.withOpacity(0.7), fontSize: 16.sp),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: BlocBuilder<LandMarkCubit, LandMarkState>(
          builder: (context, state) {
            if (state is LandMarkLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LandMarkError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              );
            } else if (state is LandMarkSuccess) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.numMarks,
                      itemBuilder: (context, index) {
                        final landMark = state.landMark[index];

                        return GestureDetector(
                          onTap: () {
                            GoRouter.of(context).push(
                              AppRouter.kLandMarkDetailsView,
                              extra: landMark,
                            );
                          },
                          child: Card(
                            color: theme.cardColor,
                            margin: EdgeInsets.all(5.r),
                            elevation: 6.r,
                            shadowColor: theme.brightness == Brightness.dark
                                ? Colors.white24
                                : Colors.black26,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(24.r),
                                      ),
                                      child: CachedNetworkImage(
                                        height: 180.h,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        imageUrl: landMark.mainImage,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(12.r),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            landMark.name,
                                            style: TextStyle(
                                              color:
                                                  theme.brightness ==
                                                      Brightness.dark
                                                  ? Colors.white
                                                  : Colors.white,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            landMark.location,
                                            style: TextStyle(
                                              color:
                                                  theme.brightness ==
                                                      Brightness.dark
                                                  ? Colors.white70
                                                  : Colors.white.withOpacity(
                                                      0.9,
                                                    ),
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                Padding(
                                  padding: EdgeInsets.all(12.r),
                                  child: Text(
                                    landMark.shortInfo,
                                    style: TextStyle(
                                      color: theme.textTheme.bodyMedium?.color
                                          ?.withOpacity(0.8),
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    TextButton(
                      onPressed: () {
                        context.read<LandMarkCubit>().loadMoreMarks();
                      },
                      child: Text(
                        "See more".tr(),
                        style: TextStyle(color: theme.colorScheme.primary),
                      ),
                    ),

                    SizedBox(height: 15.h),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
