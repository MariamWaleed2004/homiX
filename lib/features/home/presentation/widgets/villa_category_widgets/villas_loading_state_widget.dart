import 'package:flutter/material.dart';
import 'package:homix/core/const.dart';
import 'package:shimmer/shimmer.dart';

class VillasLoadingStateWidget extends StatelessWidget {
  const VillasLoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);
    return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(width * 0.05),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: width * 0.025,
                  spreadRadius: width * 0.005,
                  offset: Offset(0, width * 0.01),
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(width * 0.05),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: width * 0.3,
                        height: height * 0.025,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(width * 0.05),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.012),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.only(left: width * 0.03),
                      child: Row(
                        children: List.generate(3, (index) {
                          return Container(
                            margin: EdgeInsets.only(right: width * 0.03),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(width * 0.05),
                                child: Container(
                                  height: height * 0.25,
                                  width: width * 0.65,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.0375),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: double.infinity,
                        height: height * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(width * 0.05),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01875,
                  ),
                  Column(
                    children: List.generate(3, (index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: height * 0.015),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(width * 0.05),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                              child: Container(
                                height: height * 0.125,
                                width: double.infinity,
                                margin: EdgeInsets.only(bottom: height * 0.012),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(width * 0.05),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          );;
  }
}