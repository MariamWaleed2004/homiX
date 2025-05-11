import 'package:flutter/material.dart';
import 'package:homix/core/const.dart';

class LandsCategoriesWidget extends StatelessWidget {
  const LandsCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);
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
                "Your Lands",
                style: TextStyle(
                  fontSize: width * 0.09,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: Text(
                  "Choose your category",
                  style: TextStyle(fontSize: width * 0.04, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              margin: EdgeInsets.only(bottom: height * 0.007),
              height: height * 0.25,
              width: width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                image: DecorationImage(
                  image: AssetImage("assets/lands/lands.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Color.fromRGBO(0, 0, 0, 0.3), BlendMode.darken),
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(width * 0.08),
                    topRight: Radius.circular(width * 0.08),
                    bottomLeft: Radius.circular(width * 0.08)),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.15, vertical: height * 0.03),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                      color: const Color.fromARGB(255, 50, 49, 49),
                      borderRadius: BorderRadius.circular(width * 0.08),
                    ),
                    //height: height * 0.05,
                    //width: width * 0.5,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.04, vertical: height * 0.007),
                      child: Row(
                        children: [
                          Icon(Icons.location_on,
                              size: 16, color: Colors.white),
                          SizedBox(width: width * 0.01),
                          Text(
                            "Residential Lands",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    //margin: EdgeInsets.only(right: width * 0.01),
                    height: height * 0.25,
                    width: width / 2.36,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      image: DecorationImage(
                        image: AssetImage("assets/lands/lands2.webp"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Color.fromRGBO(0, 0, 0, 0.3), BlendMode.darken),
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(width * 0.08),
                          topRight: Radius.circular(width * 0.08),
                          bottomLeft: Radius.circular(width * 0.08)),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.01, vertical: height * 0.03),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                            color: const Color.fromARGB(255, 50, 49, 49),
                            borderRadius: BorderRadius.circular(width * 0.08),
                          ),
                          //height: height * 0.05,
                          //width: width * 0.5,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.048,
                                vertical: height * 0.007),
                            child: Row(
                              children: [
                                Icon(Icons.location_on,
                                    size: 16, color: Colors.white),
                                SizedBox(width: width * 0.01),
                                Text(
                                  "Commercial",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: width * 0.02),
                Expanded(
                  child: Container(
                    //margin: EdgeInsets.only(right: width * 0.01),
                    height: height * 0.25,
                    width: width / 2.36,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      image: DecorationImage(
                        image: AssetImage("assets/lands/lands4.jpg"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Color.fromRGBO(0, 0, 0, 0.3), BlendMode.darken),
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(width * 0.08),
                          topRight: Radius.circular(width * 0.08),
                          bottomLeft: Radius.circular(width * 0.08)),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.01, vertical: height * 0.03),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                            color: const Color.fromARGB(255, 50, 49, 49),
                            borderRadius: BorderRadius.circular(width * 0.08),
                          ),
                          //height: height * 0.05,
                          //width: width * 0.5,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.05,
                                vertical: height * 0.007),
                            child: Row(
                              children: [
                                Icon(Icons.location_on,
                                    size: 16, color: Colors.white),
                                SizedBox(width: width * 0.01),
                                Text(
                                  "Agricultural",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
