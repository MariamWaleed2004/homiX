import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homix/core/const.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';



class SubonboardingWidget1 extends StatelessWidget {
  const SubonboardingWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    double width = AppSizes.screenWidth(context);
    double height =  AppSizes.screenHeight(context);
    return Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: Container(
                    height: height * 0.35,
                    width: width,
                    decoration: BoxDecoration(
              
                      // border: Border.all(color: Colors.black, width: 3),
                      // borderRadius: BorderRadius.circular(29),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Icon(PhosphorIconsFill.mapPin, size: 250,)
                      // Image.asset(
                      //   'assets/photo8.png',
                      //   fit: BoxFit.cover,
                        
                      //   ),
                        
                    ),
                  ),
                ),
            ),
              SizedBox(height: height * 0.05),
              Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                child: Text(
                  'Enjoy a smooth browsing experience to find the perfect property for you !',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    
                  ),
                  textAlign: TextAlign.center,
                  ),
              ),
                
          ],
        ),
      );
      
    
  }
}