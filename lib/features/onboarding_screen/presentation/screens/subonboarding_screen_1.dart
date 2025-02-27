import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class SubonboardingScreen1 extends StatelessWidget {
  const SubonboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: Container(
                    height: screenheight * 0.35,
                    width: screenWidth,
                    decoration: BoxDecoration(
              
                      // border: Border.all(color: Colors.black, width: 3),
                      // borderRadius: BorderRadius.circular(29),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        'assets/photo8.png',
                        fit: BoxFit.cover,
                        
                        ),
                        
                    ),
                  ),
                ),
            ),
              SizedBox(height: screenheight * 0.06),
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