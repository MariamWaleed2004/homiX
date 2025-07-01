import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/favorites/presentation/cubit/favorites_cubit/favorites_cubit.dart';
import 'package:homix/features/home/domain/entities/property_entity.dart';
import 'package:homix/features/home/presentation/screens/property_details_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MostPopularApartmentWidget extends StatefulWidget {
  final List<PropertyEntity> apartment;

  const MostPopularApartmentWidget({super.key, required this.apartment});

  @override
  State<MostPopularApartmentWidget> createState() =>
      _MostPopularApartmentWidgetState();
}

class _MostPopularApartmentWidgetState
    extends State<MostPopularApartmentWidget> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Most popular now",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: width * 0.053,
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
                      fontSize: width * 0.035,
                    ),
                  ),
                  SizedBox(width: width * 0.01),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: width * 0.045,
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
              ...widget.apartment
                  .where((apartment) =>
                      apartment.homeDisplay == "yes" &&
                      apartment.category == "Apartment")
                  .map(
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
                        margin: EdgeInsets.only(right: width * 0.03),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(width * 0.053),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(width * 0.053),
                                  topRight: Radius.circular(width * 0.053),
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
                                                baseColor: Colors.grey.shade300,
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
                                      padding: EdgeInsets.only(
                                          bottom: height * 0.01),
                                      child: SmoothPageIndicator(
                                        controller: _pageController,
                                        count: apartment.image.length,
                                        effect: WormEffect(
                                          dotHeight: width * 0.016,
                                          dotWidth: width * 0.016,
                                          activeDotColor: Colors.white,
                                          dotColor: Colors.grey,
                                          spacing: width * 0.01,
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.025,
                                  vertical: height * 0.015),
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
                                          fontSize: width * 0.045,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: width * 0.045,
                                          ),
                                          Text(
                                            apartment.rating.toString(),
                                            style: TextStyle(
                                              fontSize: width * 0.027,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.01,
                                          ),
                                          Text(
                                            "(${apartment.totalReviews.toString()} reviews)",
                                            style: TextStyle(
                                              fontSize: width * 0.027,
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
                                          color: Colors.grey,
                                          fontSize: width * 0.032,
                                        ),
                                      )),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\$${apartment.price}",
                                        style: TextStyle(
                                          fontSize: width * 0.053,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      BlocBuilder<FavoritesCubit,
                                          FavoritesState>(
                                        builder: (context, state) {
                                          final isFavorite =
                                              state is FavoritesLoaded &&
                                                  state.favorites.any((p) {
                                                    print(
                                                        'apartment.id = ${apartment.id}, favorite.id = ${p.id}');
                                                    return p.id == apartment.id;
                                                  });

                                          return IconButton(
                                            icon: Icon(
                                              isFavorite
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              size: width * 0.06,
                                            ),
                                            onPressed: () {
                                              final user = FirebaseAuth
                                                  .instance.currentUser;
                                              if (user == null) {
                                                return toast("User is null");
                                              }
                                              context
                                                  .read<FavoritesCubit>()
                                                  .toggleFavoriteStatus(
                                                      user.uid, apartment.id);
                                            },
                                          );
                                        },
                                      )
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
      ],
    );
  }
}
