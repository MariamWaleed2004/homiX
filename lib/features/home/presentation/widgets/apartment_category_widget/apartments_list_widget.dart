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
            margin: EdgeInsets.only(bottom: height * 0.018),
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.064),
            color: Colors.grey.shade300,
            ),
          ),
          Container(
            height: height * 0.36,
            margin: EdgeInsets.only(bottom: height * 0.018),
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.064),
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
            margin: EdgeInsets.only(bottom: height * 0.018),
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(width * 0.051), 
            ),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                topLeft: Radius.circular(width * 0.051),
                topRight: Radius.circular(width * 0.051),
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
                  padding: EdgeInsets.only(bottom: height * 0.0097), 
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: apartment.image.length,
                    effect: WormEffect(
                    dotHeight: height * 0.0072, 
                    dotWidth: width * 0.015, 
                    activeDotColor: Colors.white,
                    dotColor: Colors.grey,
                    spacing: width * 0.010, 
                    ),
                  ),
                  )
                ],
                )),
              Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.0256, 
                vertical: height * 0.0145 
              ),
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
                      fontSize: width * 0.038), 
                  ),
                  Row(
                    children: [
                    Icon(
                      Icons.star,
                      size: width * 0.0436, 
                    ),
                    Text(
                      apartment.rating.toString(),
                      style: TextStyle(
                      fontSize: width * 0.0256, 
                      fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Text(
                      "(${apartment.totalReviews.toString()} reviews)",
                      style: TextStyle(
                      fontSize: width * 0.0256,
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
                      color: Colors.grey, fontSize: width * 0.0307), 
                  )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text(
                    "\$${apartment.price}",
                    style: TextStyle(
                    fontSize: width * 0.0461, 
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                    Icons.favorite_border,
                    size: width * 0.051, 
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
