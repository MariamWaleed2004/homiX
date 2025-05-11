import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/favorites/presentation/cubit/favorites_cubit/favorites_cubit.dart';
import 'package:homix/features/home/domain/entities/property_entity.dart';
import 'package:shimmer/shimmer.dart';

class NearbyLandsWidget extends StatelessWidget {
  final List<PropertyEntity> land;

  const NearbyLandsWidget({super.key, required this.land});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    double height = mediaQuery.size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(width * 0.08),
            topRight: Radius.circular(width * 0.08),
            bottomLeft: Radius.circular(width * 0.08)),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.02),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Nearby your location",
                style: TextStyle(
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            ...land.map(
              (land) => Container(
                margin: EdgeInsets.only(bottom: height * 0.01),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 50, 49, 49),
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(width * 0.08),
                  //   topRight: Radius.circular(width * 0.08),
                  //   bottomLeft: Radius.circular(width * 0.08)
                  //),
                  borderRadius: BorderRadius.circular(width * 0.05),
                  border: Border.all(
                    color: const Color.fromARGB(255, 152, 151, 151),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: width * 0.01,
                      offset: Offset(0, height * 0.005),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.01, horizontal: width * 0.02),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(width * 0.05),
                        child: SizedBox(
                          height: height * 0.12,
                          width: width * 0.2,
                          child: Image.network(
                            land.image[0],
                            width: width * 0.4,
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
                                  width: width * 0.2,
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
                          padding: EdgeInsets.only(right: width * 0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                land.title,
                                style: TextStyle(
                                    fontSize: width * 0.045,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                land.location,
                                style: TextStyle(
                                  fontSize: width * 0.035,
                                  color: Colors.grey,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: width * 0.045,
                                        color: Colors.yellow,
                                      ),
                                      Text(
                                        land.rating.toString(),
                                        style: TextStyle(
                                          fontSize: width * 0.03,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.01,
                                      ),
                                      Text(
                                        "(${land.totalReviews.toString()} reviews)",
                                        style: TextStyle(
                                          fontSize: width * 0.03,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  BlocBuilder<FavoritesCubit, FavoritesState>(
                                    builder: (context, state) {
                                      final isFavorite =
                                          state is FavoritesLoaded &&
                                              state.favorites.any((p) {
                                                return p.id == land.id;
                                              });

                                      return IconButton(
                                        icon: Icon(
                                          isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.white,
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
                                                  user.uid, land.id);
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
            SizedBox(
              height: height * 0.02,
            ),
            Text("View all",
                style: TextStyle(fontSize: width * 0.045, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
