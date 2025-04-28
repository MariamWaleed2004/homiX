import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/home/data/models/property_model.dart';
import 'package:homix/features/home/domain/entities/property_entity.dart';
import 'package:homix/features/home/presentation/cubit/property_cubit/property_cubit.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final PropertyEntity property;
  const PropertyDetailsScreen({super.key, required this.property});

  @override
  _PropertyDetailsScreenState createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);

    return Scaffold(
      body: BlocConsumer<PropertyCubit, PropertyState>(
        listener: (context, state) {},
        builder: (context, propertyState) {
          if (propertyState is PropertyLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: height / 2.5,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          itemCount: widget.property.image.length,
                          itemBuilder: (ctx, index) {
                            return Image.network(
                              widget.property.image[index],
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
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.error,
                                  color: Colors.red,
                                );
                              },
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: widget.property.image.length,
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.property.category,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 20,
                            ),
                            Text(
                              widget.property.rating.toString(),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            Text(
                              "(${widget.property.totalReviews.toString()} reviews)",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.property.title,
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.property.location,
                          style: TextStyle(color: Colors.grey[700]),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Icon(Icons.bed),
                                  )),
                              SizedBox(
                                width: width * 0.01,
                              ),
                              Text(
                                "${widget.property.rooms} Rooms",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Icon(Icons.shower),
                                  )),
                              SizedBox(
                                width: width * 0.01,
                              ),
                              Text(
                                "${widget.property.bathrooms} Bath",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child:
                                        Icon(PhosphorIconsRegular.boundingBox),
                                  )),
                              SizedBox(
                                width: width * 0.01,
                              ),
                              Text(
                                "${widget.property.areaSqft} Sqft",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Listing Agents",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: height * 0.06,
                              width: width * 0.14,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(35)),
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Text(
                              widget.property.agentName,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Icon(
                                  PhosphorIconsRegular.chatCircleDots,
                                  size: 32,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.05,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Icon(
                                  Icons.call,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Overview",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.property.overview,
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: TextButton(
                      onPressed: () {},
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "See on maps",
                              style: TextStyle(color: Colors.black),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          if (propertyState is PropertyFailure) {
            return Center(
              child: Text(
                propertyState.errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          return Column();
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          color: Colors.grey,
          width: 1,
        ))),
        height: height * 0.1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Price",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    "\$${widget.property.price.toString()}",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: Size(180, 50),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Buy Now",
                    style: TextStyle(fontSize: 18),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
