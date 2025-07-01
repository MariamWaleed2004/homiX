import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/favorites/presentation/cubit/favorites_cubit/favorites_cubit.dart';
import 'package:homix/features/home/domain/entities/property_entity.dart';
import 'package:shimmer/shimmer.dart';

class RecommendVillasWidget extends StatelessWidget {
  final List<PropertyEntity> villa;

  const RecommendVillasWidget({super.key, required this.villa});

  @override
  Widget build(BuildContext context) {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);
    return Column(
      children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
          "Recommend for you",
          style: TextStyle(
            fontSize: width * 0.05,
            fontWeight: FontWeight.bold,
          ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
            "View All",
            style: TextStyle(color: Colors.grey[500]),
            ))
        ],
        ),
      ),
      SizedBox(
        height: height * 0.012,
      ),
      ...villa.map(
        (villa) => Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Container(
          margin: EdgeInsets.only(bottom: height * 0.012),
          decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(width * 0.05),
          boxShadow: [
            BoxShadow(
            color: Colors.black12,
            blurRadius: width * 0.008,
            offset: Offset(0, height * 0.006),
            ),
          ],
          ),
          child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.012, horizontal: width * 0.013),
          child: Row(
            children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(width * 0.05),
              child: SizedBox(
              height: height * 0.12,
              width: width * 0.21,
              child: Image.network(
                villa.image[0],
                width: width * 0.42,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                  color: Colors.white,
                  width: width * 0.21,
                  height: height * 0.12,
                  ),
                );
                },
              ),
              ),
            ),
            SizedBox(
              width: width * 0.03,
            ),
            Expanded(
              child: Padding(
              padding: EdgeInsets.only(right: width * 0.026),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(
                  villa.title,
                  style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  villa.location,
                  style: TextStyle(
                  fontSize: width * 0.032,
                  color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Row(
                    children: [
                    Icon(
                      Icons.star,
                      size: width * 0.043,
                    ),
                    Text(
                      villa.rating.toString(),
                      style: TextStyle(
                      fontSize: width * 0.03,
                      fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Text(
                      "(${villa.totalReviews.toString()} reviews)",
                      style: TextStyle(
                      fontSize: width * 0.03,
                      fontWeight: FontWeight.w500,
                      ),
                    ),
                    ],
                  ),
                  BlocBuilder<FavoritesCubit, FavoritesState>(
                    builder: (context, state) {
                    final isFavorite =
                      state is FavoritesLoaded &&
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

                      context
                        .read<FavoritesCubit>()
                        .toggleFavoriteStatus(
                          user.uid, villa.id);
                      },
                    );
                    },
                  )
                  ],
                ),
                ],
              ),
              ),
            )
            ],
          ),
          ),
        ),
        ),
      ),
      ],
    );
  }
}
