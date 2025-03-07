import 'package:flutter/material.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:homix/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:homix/features/onboarding_screen/presentation/screens/onboarding_screen.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;

    switch(settings.name) {
 
      case ScreenConst.signInScreen: {
        return _fadeRoute(SignInScreen());
      }
      case ScreenConst.signUpScreen: {
        return _fadeRoute(SignUpScreen());
      }
      case ScreenConst.onboardingScreen: {
        return _fadeRoute(OnboardingScreen());
      }
    
       
      default: NoScreenFound();
    }
  }
  static PageRouteBuilder _fadeRoute(Widget page) {
  return PageRouteBuilder(
    
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    }
    );
}
}



dynamic routeBuilder(Widget child) {
  return MaterialPageRoute(builder: (ctx) => child);
}


class NoScreenFound extends StatelessWidget {
  const NoScreenFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page not found'),
      ),
      body: Center(
        child: Text('Page not found'),
      ),
    );
  }
}