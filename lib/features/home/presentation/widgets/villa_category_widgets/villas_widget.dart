import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/favorites/presentation/cubit/favorites_cubit/favorites_cubit.dart';
import 'package:homix/features/home/data/models/property_model.dart';
import 'package:homix/features/home/presentation/cubit/property_cubit/property_cubit.dart';
import 'package:homix/features/home/presentation/screens/property_details_screen.dart';
import 'package:homix/features/home/presentation/widgets/villa_category_widgets/best_villas_widget.dart';
import 'package:homix/features/home/presentation/widgets/villa_category_widgets/recommend_villas_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class VillasWidget extends StatefulWidget {
  VillasWidget({super.key});

  @override
  State<VillasWidget> createState() => _VillasWidgetState();
}

class _VillasWidgetState extends State<VillasWidget> {
  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      context.read<FavoritesCubit>().loadFavorites(user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);
    User? user = FirebaseAuth.instance.currentUser;

    return BlocConsumer<PropertyCubit, PropertyState>(
      listener: (context, propertystate) {},
      builder: (context, propertyState) {
// ----------------------------------------------- Loading State ----------------------------------------------------

        if (propertyState is PropertyLoading) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.r,
                  spreadRadius: 2.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.r),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 120.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: Row(
                        children: List.generate(3, (index) {
                          return Container(
                            margin: EdgeInsets.only(right: 12.w),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: Container(
                                  height: 200.h,
                                  width: 260.w,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.r),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: double.infinity,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Column(
                    children: List.generate(3, (index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 12.w),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Container(
                                height: 100.h,
                                width: double.infinity,
                                margin: EdgeInsets.only(bottom: 10.h),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        }
// ----------------------------------------------- Loaded State ----------------------------------------------------

        else if (propertyState is PropertyLoaded) {
          final bestVillas = propertyState.properties
              .where((villa) => villa.category == "Villa")
              .toList();

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.r,
                  spreadRadius: 2.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(bottom: 70.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  ---------------------------- Best Villas widget ----------------------------
                    BestVillasWidget(villa: bestVillas),
                    SizedBox(height: 30.h),
                    // ---------------------------- Recommend for you widget ----------------------------
                    RecommendVillasWidget(villa: bestVillas)
                  ]),
            ),
          );
        } else if (propertyState is PropertyFailure) {
          return Center(child: Text(propertyState.errorMessage));
        }
        return const Center(
          child: Text("Failed"),
        );
      },
    );
  }
}





