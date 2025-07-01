import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/favorites/presentation/cubit/favorites_cubit/favorites_cubit.dart';
import 'package:homix/features/home/data/models/property_model.dart';
import 'package:homix/features/home/presentation/cubit/property_cubit/property_cubit.dart';
import 'package:homix/features/home/presentation/screens/property_details_screen.dart';
import 'package:homix/features/home/presentation/widgets/apartment_category_widget/grid_apartments_categories_widget.dart';
import 'package:homix/features/home/presentation/widgets/apartment_category_widget/most_popular_apartment_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ApartmentsWidget extends StatefulWidget {
  ApartmentsWidget({super.key});

  @override
  State<ApartmentsWidget> createState() => _ApartmentsWidgetState();
}

class _ApartmentsWidgetState extends State<ApartmentsWidget> {
  final PageController _pageController = PageController();

  final List<String> apartmentCategories = [
    'Duplex Houses',
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

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: BlocConsumer<PropertyCubit, PropertyState>(
        listener: (context, propertystate) {},
        builder: (context, propertyState) {
          if (propertyState is PropertyLoading) {
            return SkeletonLoader(
              builder: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: height * 0.05,
                    margin: EdgeInsets.only(bottom: height * 0.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.067),
                      color: Colors.grey.shade300,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: width * 0.03),
                          height: height * 0.36,
                          width: width * 0.7,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(width * 0.053),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: width * 0.03),
                          height: height * 0.36,
                          width: width * 0.7,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(width * 0.053),
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
                      borderRadius: BorderRadius.circular(width * 0.067),
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
                        crossAxisSpacing: width * 0.048,
                        mainAxisSpacing: height * 0.0225,
                        childAspectRatio: 2 / 2),
                    itemBuilder: (ctx, index) {
                      final category = apartmentCategories[index];
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(width * 0.04),
                            image: DecorationImage(
                              image:
                                  AssetImage(apartmentCategoriesImages[index]),
                              fit: BoxFit.cover,
                            )),
                      );
                    },
                  ),
                ],
              ),
            );
            // ------------------------------  Loaded State -----------------------------------
          } else if (propertyState is PropertyLoaded) {
            final apartments = propertyState.properties
                .where((apartment) => apartment.category == "Apartment")
                .toList();

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.only(bottom: height * 0.09),
                child: Column(
                  children: [
                    // ------------------------------ Most Popular Now -----------------------------------

                    MostPopularApartmentWidget(apartment: apartments),

                    SizedBox(
                      height: height * 0.03,
                    ),

                    // ------------------------------            ---------------------------------------------
                    Container(
                      height: height * 0.065,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.06),
                          color: Colors.black),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.04,
                            vertical: height * 0.0038),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "1,000+",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context,
                                      ScreenConst.PopularApartmentsScreen);
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Apartments For Rent",
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
                    SizedBox(
                      height: height * 0.03,
                    ),
             // ------------------------------     GridApartmentsCategoriesWidget      ---------------------------------------------

                    GridApartmentsCategoriesWidget(),
                  ],
                ),
              ),
            );
            // ------------------------------    Failure State    ---------------------------------------------
            
          } else if (propertyState is PropertyFailure) {
            return Center(child: Text(propertyState.errorMessage));
          }
          return const Center(
            child: Text("Failed"),
          );
        },
      ),
    );
  }
}
