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
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Padding(
        padding: EdgeInsets.all(width * 0.05),
        child: Text(
        "Best Villas",
        style: TextStyle(
          fontSize: width * 0.05,
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
      SizedBox(
        height: height * 0.012,
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
        padding: EdgeInsets.only(left: width * 0.03),
        child: Row(
          children: [
          ...villa.map((villa) => Container(
              margin: EdgeInsets.only(right: width * 0.03),
              child: Stack(
              children: [
                ClipRRect(
                borderRadius: BorderRadius.circular(width * 0.05),
                child: SizedBox(
                  height: height * 0.25,
                  width: width * 0.65,
                  child: Image.network(
                  villa.image[0],
                  width: width * 0.41,
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
                      width: width * 0.41,
                      height: height * 0.25,
                    ),
                    );
                  },
                  ),
                ),
                ),
                Positioned(
                top: height * 0.0125,
                right: width * 0.025,
                child: Container(
                  height: height * 0.044,
                  width: width * 0.09,
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width * 0.05),
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
                bottom: height * 0.0125,
                left: width * 0.01,
                right: width * 0.01,
                child: Container(
                  decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black54, Colors.transparent],
                  ),
                  borderRadius: BorderRadius.circular(width * 0.05),
                  ),
                  child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.025, vertical: height * 0.0125),
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
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold,
                        )),
                      Text("\$${villa.price}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.04,
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
                          size: width * 0.03,
                          color: Colors.white),
                        Text(villa.location,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.03,
                          )),
                        ],
                      ),
                      Row(
                        children: [
                        Icon(
                          Icons.star,
                          size: width * 0.04,
                          color: Colors.yellow,
                        ),
                        Text(
                          villa.rating.toString(),
                          style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.025,
                          fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: width * 0.01)
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
