import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homix/home_screen.dart';
import 'package:homix/features/onboarding_screen/presentation/screens/onboarding_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
      );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _controller.forward();
    Future.delayed(Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(_fadeRoute(OnboardingScreen()));
    });
  }

  


  Route _fadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body:
         FadeTransition(
          opacity: _animation,
           child: Center(
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(
                  'HomiX',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.15,
                    fontWeight: FontWeight.bold,
                  ),
                  
                  ),
                Lottie.asset(
                  'assets/loading_1.json',
                  width: screenWidth * 0.6,
                  height: screenWidth * 0.6,
                  fit: BoxFit.contain,
                  ),
              ],
                     ),
           ),
         ),
      );
  }
}