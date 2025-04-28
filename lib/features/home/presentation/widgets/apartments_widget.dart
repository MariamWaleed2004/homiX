import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/favorites/presentation/cubit/favorites_cubit/favorites_cubit.dart';
import 'package:homix/features/home/presentation/cubit/property_cubit/property_cubit.dart';
import 'package:homix/features/home/presentation/screens/property_details_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ApartmentsWidget extends StatelessWidget {
  ApartmentsWidget({super.key});

  final PageController _pageController = PageController();

  final List<String> apartmentImages = [
    'assets/apartments/apartment_3.jpg',
    'assets/apartments/apartment_2.jpg',
    'assets/apartments/apartment_4.jpg',
    'assets/apartments/apartment_5.jpg',
  ];

  final List<String> apartmentCategories = [
    'Open Houses',
    'Dream Apartments',
    'Price Reduced',
    'New Projects',
  ];

  final List<String> apartmentCategoriesImages = [
    'assets/apartments/apartment_12.jpg',
    'assets/apartments/apartment_8.jpg',
    'assets/apartments/apartment_4.jpg',
    'assets/apartments/apartment_9.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);
    User? user = FirebaseAuth.instance.currentUser;
    bool isFavorites = false;

    return BlocConsumer<PropertyCubit, PropertyState>(
      listener: (context, propertystate) {},
      builder: (context, propertyState) {
        if (propertyState is PropertyLoading) {
          return SkeletonLoader(
            builder: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: height * 0.05,
                  margin: EdgeInsets.only(bottom: 19),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.shade300,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        height: height * 0.36,
                        width: width * 0.7,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        height: height * 0.36,
                        width: width * 0.7,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Container(
                  height: height * 0.065,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.shade300,
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: apartmentCategories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 18,
                      mainAxisSpacing: 18,
                      childAspectRatio: 2 / 2),
                  itemBuilder: (ctx, index) {
                    final category = apartmentCategories[index];
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage(apartmentCategoriesImages[index]),
                            fit: BoxFit.cover,
                          )),
                    );
                  },
                ),
              ],
            ),
          );
        } else if (propertyState is PropertyLoaded) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Most popular now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, ScreenConst.PopularApartmentsScreen);
                    },
                    child: Row(
                      children: [
                        Text(
                          "More offers",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: width * 0.01),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...propertyState.properties.map(
                      (apartment) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => PropertyDetailsScreen(
                                        property: apartment,
                                      )));
                        },
                        child: Container(
                          width: width * 0.7,
                          //height: height * 0.36,
                          margin: EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      SizedBox(
                                        height: height * 0.25,
                                        child: PageView.builder(
                                          controller: _pageController,
                                          itemCount: apartment.image.length,
                                          itemBuilder: (ctx, index) {
                                            return Image.network(
                                              apartment.image[index],
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Shimmer.fromColors(
                                                  baseColor:
                                                      Colors.grey.shade300,
                                                  highlightColor:
                                                      Colors.grey.shade100,
                                                  child: Container(
                                                    color: Colors.white,
                                                    width: double.infinity,
                                                    height: height * 0.25,
                                                  ),
                                                );
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Icon(
                                                  Icons.error,
                                                  color: Colors.red,
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: SmoothPageIndicator(
                                          controller: _pageController,
                                          count: apartment.image.length,
                                          effect: WormEffect(
                                            dotHeight: 6,
                                            dotWidth: 6,
                                            activeDotColor: Colors.white,
                                            dotColor: Colors.grey,
                                            spacing: 4,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          apartment.title,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
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
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.01,
                                            ),
                                            Text(
                                              "(${apartment.totalReviews.toString()} reviews)",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          apartment.location,
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        )),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "\$${apartment.price}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            isFavorites = !isFavorites;
                                            // if (isFavorites) {
                                            //   ScaffoldMessenger.of(context)
                                            //       .showSnackBar(
                                            //     SnackBar(
                                            //         content: Text(
                                            //             'Added to favorites')),
                                            //   );
                                            // } else {
                                            //   ScaffoldMessenger.of(context)
                                            //       .showSnackBar(
                                            //     SnackBar(
                                            //         content: Text(
                                            //             'Removed from favorites')),
                                            //   );
                                            // }
                                            final userId = user?.uid;
                                            final propertyId = apartment.id;
                                            if (userId != null) {
                                              context
                                                  .read<FavoritesCubit>()
                                                  .toggleFavorites(
                                                      userId, propertyId);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'User not logged in')),
                                              );
                                            }
                                          },
                                          icon: Icon(
                                            isFavorites
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                height: height * 0.065,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.black),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "2,000+",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Text(
                                "Unique places",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.01,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: height * 0.001,
              // ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: apartmentCategories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                    childAspectRatio: 2 / 2),
                itemBuilder: (ctx, index) {
                  final category = apartmentCategories[index];
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage(apartmentCategoriesImages[index]),
                          fit: BoxFit.cover,
                        )),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            //color: Colors.black
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              apartmentCategories[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
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
