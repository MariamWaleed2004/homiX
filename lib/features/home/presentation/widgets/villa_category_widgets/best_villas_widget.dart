import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/favorites/presentation/cubit/favorites_cubit/favorites_cubit.dart';
import 'package:homix/features/home/domain/entities/property_entity.dart';
import 'package:shimmer/shimmer.dart';

class BestVillasWidget extends StatelessWidget {
  final List<PropertyEntity> villa;
  const BestVillasWidget({super.key, required this.villa});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(20.r),
          child: Text(
            "Best Villas",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Row(
              children: [
                ...villa.map((villa) => Container(
                      margin: EdgeInsets.only(right: 12.w),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: SizedBox(
                              height: 200.h,
                              width: 260.w,
                              child: Image.network(
                                villa.image[0],
                                width: 160.w,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                      color: Colors.white,
                                      width: 160.w,
                                      height: 200.h,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10.h,
                            right: 10.w,
                            child: Container(
                              height: 35.h,
                              width: 35.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child:
                                  BlocBuilder<FavoritesCubit, FavoritesState>(
                                builder: (context, state) {
                                  final isFavorite = state is FavoritesLoaded &&
                                      state.favorites.any((p) {
                                        return p.id == villa.id;
                                      });

                                  return IconButton(
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                    ),
                                    onPressed: () {
                                      final user =
                                          FirebaseAuth.instance.currentUser;
                                      if (user == null) {
                                        return toast("User is null");
                                      }

                                      // مرّري بيانات الشقة كلها مش بس الـ id
                                      context
                                          .read<FavoritesCubit>()
                                          .toggleFavoriteStatus(
                                              user.uid, villa.id);
                                    },
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                  );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10.h,
                            left: 4.w,
                            right: 4.w,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [Colors.black54, Colors.transparent],
                                ),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(villa.title,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Text("\$${villa.price}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.location_on,
                                                size: 12.sp,
                                                color: Colors.white),
                                            Text(villa.location,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.sp,
                                                )),
                                          ],
                                        ),
                                        // Text(villa.location,
                                        // style: TextStyle(
                                        //   color: Colors.white,
                                        //   fontSize: 12,
                                        // )),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 16.sp,
                                              color: Colors.yellow,
                                            ),
                                            Text(
                                              villa.rating.toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(width: 4.w)

                                            // Text(
                                            //   "(${villa.totalReviews.toString()} reviews)",
                                            //   style: TextStyle(
                                            //     color: Colors.white,
                                            //     fontSize: 10,
                                            //     fontWeight:
                                            //         FontWeight.w500,
                                            //   ),
                                            // ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
