import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/home/presentation/cubit/property_cubit/property_cubit.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ApartmentsListWidget extends StatefulWidget {
  ApartmentsListWidget({super.key});

  @override
  State<ApartmentsListWidget> createState() => _ApartmentsListWidgetState();
}

class _ApartmentsListWidgetState extends State<ApartmentsListWidget> {
  final PageController _pageController = PageController();

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
  void initState() {
    super.initState();
    context.read<PropertyCubit>().getProperties();
  }

  @override
  Widget build(BuildContext context) {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);
    return BlocConsumer<PropertyCubit, PropertyState>(
      listener: (context, propertystate) {},
      builder: (context, propertyState) {
        if (propertyState is PropertyLoading) {
          return SkeletonLoader(
            builder: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: height * 0.36,
                  margin: EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.shade300,
                  ),
                ),
                Container(
                  height: height * 0.36,
                  margin: EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.shade300,
                  ),
                ),
              ],
            ),
          );
        } else if (propertyState is PropertyLoaded) {
          return Column(
            children: [
              ...propertyState.properties.map(
                (apartment) => Container(
                  // width: width * 0.7,
                  //height: height * 0.36,
                  margin: EdgeInsets.only(bottom: 15),
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
                                padding: const EdgeInsets.only(bottom: 8),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$${apartment.price}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite_border,
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
              )
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
