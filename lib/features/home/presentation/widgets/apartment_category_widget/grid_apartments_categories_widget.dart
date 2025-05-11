import 'package:flutter/material.dart';
import 'package:homix/core/const.dart';

class GridApartmentsCategoriesWidget extends StatelessWidget {
  const GridApartmentsCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);

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

    return Column(
      children: [
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
                  borderRadius: BorderRadius.circular(width * 0.04),
                  image: DecorationImage(
                    image: AssetImage(apartmentCategoriesImages[index]),
                    fit: BoxFit.cover,
                  )),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.04),
                      //color: Colors.black
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(width * 0.013),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        apartmentCategories[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.048,
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
  }
}
