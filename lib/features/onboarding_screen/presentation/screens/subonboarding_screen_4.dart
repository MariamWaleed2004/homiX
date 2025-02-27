import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homix/features/onboarding_screen/presentation/widgets/button_widget.dart';

class SubonboardingScreen4 extends StatelessWidget {
  const SubonboardingScreen4({super.key});

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
                  padding: const EdgeInsets.only(top: 80.0, right: 20.0, left: 20.0),
                  child: Container(
                    height: screenheight * 0.3,
                    decoration: BoxDecoration(
              
                      // border: Border.all(color: Colors.black, width: 3),
                      // borderRadius: BorderRadius.circular(29),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        'assets/photo9.png',
                        fit: BoxFit.cover,
                        ),
                    ),
                  ),
                ),
            ),
               SizedBox(
            height: screenheight * 0.07,
          ),
           Text(
            "Get started now !",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
         
          SizedBox(
            height: screenheight * 0.01,
          ),
            Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: Text(
              'Explore the best properties around you!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
            SizedBox(
            height: screenheight * 0.1,
          ),
         
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white, 
                  minimumSize: const Size(150,45),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(25),
                  ),
                  textStyle: const TextStyle(
                  fontSize: 15,),
                ),
                child: const Text('Sign In'),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white, 
                  minimumSize: const Size(150,45), 
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(25), 
                  ),
                  textStyle: const TextStyle(
                  fontSize: 15,),
                ),
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
