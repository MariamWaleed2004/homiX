import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppSizes {
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}



class ScreenConst {
  static const String signInScreen = 'signInScreen';
  static const String signUpScreen = 'signUpScreen';
  static const String onboardingScreen = 'onboardingScreen';
  static const String splashScreen = 'splashScreen';
  static const String testScreen = 'testScreen';
  static const String verificationScreen = 'verificationScreen';
  static const String mainScreen = 'mainScreen';
  static const String forgotPasswordScreen = 'forgotPasswordScreen';
  static const String PopularApartmentsScreen = 'popularApartmentsScreen';
  static const String PropertyDetailsScreen = 'propertyDetailsScreen';


}


class FirebaseConst {
  static const String users = 'users';

}


void toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 15.0);
}