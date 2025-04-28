import 'package:flutter/material.dart';
import 'package:homix/core/const.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SubonboardingWidget4 extends StatelessWidget {
  const SubonboardingWidget4({super.key});

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
                  padding: const EdgeInsets.only(top: 80.0, right: 20.0, left: 20.0),
                  child: Container(
                    height: height * 0.3,
                    decoration: BoxDecoration(
              
                      // border: Border.all(color: Colors.black, width: 3),
                      // borderRadius: BorderRadius.circular(29),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Icon(PhosphorIconsRegular.rocket, size: 250,)
                      // Image.asset(
                      //   'assets/photo9.png',
                      //   fit: BoxFit.cover,
                      //   ),
                    ),
                  ),
                ),
            ),
               SizedBox(
            height: height * 0.07,
          ),
           Text(
            "Get started now !",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
         
          SizedBox(
            height: height * 0.01,
          ),
            Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: Text(
              'Explore the best properties around you',
              style: TextStyle(
               // fontWeight: FontWeight.bold, 
                fontSize: 15, 
                color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
            SizedBox(
            height: height * 0.1,
          ),
         
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) =>  SignInScreen(),
                  // transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  //   return FadeTransition(opacity: animation,
                  //   child: child,);
                    
                  // },
                  // ));
                  Navigator.of(context).pushNamed(ScreenConst.signInScreen);
                },
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
                onPressed: () {
                  // Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) =>  SignUpScreen(),
                  // transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  //   return FadeTransition(opacity: animation,
                  //   child: child,);
                  // },
                  // ));
                  Navigator.of(context).pushNamed(ScreenConst.signUpScreen);

                },
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
