import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/favorites/presentation/cubit/favorites_cubit/favorites_cubit.dart';
import 'package:homix/features/home/presentation/cubit/property_cubit/property_cubit.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final PageController _pageController = PageController();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  // @override
  // void initState() {
  //   super.initState();
  //   context.read<FavoritesCubit>().loadFavorites(userId);
  // }

  @override
  Widget build(BuildContext context) {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Favorites",
      // style: TextStyle(
      //   fontSize: 20,
      //   fontWeight: FontWeight.bold,
      // ),
      //   ),
      //   centerTitle: true,
      //   elevation: 0,
      //   iconTheme: IconThemeData(color: Colors.black),
      // ),
      body: BlocConsumer<FavoritesCubit, FavoritesState>(
        listener: (context, favoritesState) {},
        builder: (context, favoritesState) {
          if (favoritesState is FavoritesLoading) {
            return SizedBox();
          } else if (favoritesState is FavoritesLoaded) {
            // return Center(child: Text("Loaded"));
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: Column(
                  children: [
                    Text(
                      "Favorites",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 7),
                        child: Text(
                          "${favoritesState.favorites.length} Items",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    ...favoritesState.favorites.map((apartment) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Container(
                            //width: width * 0.9,
                            // height: height * 0.2,
                            margin: EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: SizedBox(
                                      height: height * 0.18,
                                      width: width * 0.39,
                                      child: Image.network(
                                        apartment.image[0],
                                        width: width * 0.4,
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: Container(
                                              color: Colors.white,
                                              width: width * 0.39,
                                              height: height * 0.18,
                                            ),
                                          );
                                        },

                                        //height: height * 0.5,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.03,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            apartment.category,
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 121, 24, 15)),
                                          ),
                                          // SizedBox(
                                          //   height: height * 0.01,
                                          // ),
                                          Text(
                                            apartment.title,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            apartment.location,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.005,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 17,
                                              ),
                                              Text(
                                                apartment.rating.toString(),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * 0.01,
                                              ),
                                              Text(
                                                "(${apartment.totalReviews.toString()} reviews)",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          // SizedBox(height: height * 0.01),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("\$${apartment.price}",
                                                  style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              IconButton(
                                                icon: Icon(
                                                  favoritesState.favorites.any(
                                                          (fav) =>
                                                              fav.id ==
                                                              apartment.id)
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                ),
                                                onPressed: () {
                                                  final user = FirebaseAuth
                                                      .instance.currentUser;
                                                  if (user == null) {
                                                    return toast(
                                                        "User is null");
                                                  }

                                                  // مرّري بيانات الشقة كلها مش بس الـ id
                                                  context
                                                      .read<FavoritesCubit>()
                                                      .toggleFavoriteStatus(
                                                          user.uid,
                                                          apartment.id);
                                                },
                                              ),
                                            ],
                                          ),
                                          // Align(
                                          //   alignment: Alignment.bottomRight,
                                          //   child:
                                          // )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            );
          } else if (favoritesState is FavoritesFailure) {
            return Center(child: Text(favoritesState.errorMessage));
          }
          return const Center(
            child: Text("Failed"),
          );
        },
      ),
    );
  }
}
