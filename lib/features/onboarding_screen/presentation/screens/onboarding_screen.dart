import 'package:flutter/material.dart';
import 'package:homix/features/onboarding_screen/presentation/screens/subonboarding_screen_1.dart';
import 'package:homix/features/onboarding_screen/presentation/screens/subonboarding_screen_2.dart';
import 'package:homix/features/onboarding_screen/presentation/screens/subonboarding_screen_3.dart';
import 'package:homix/features/onboarding_screen/presentation/screens/subonboarding_screen_4.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  int _currentIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
               onPageChanged: onPageChanged,
              children: [
                SubonboardingScreen1(),
                SubonboardingScreen2(),
                SubonboardingScreen3(),
                SubonboardingScreen4(),
              ],
             
              
            ),
          ),
           SizedBox(height: screenheight * 0.02),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: SmoothPageIndicator(
                              controller: pageController,
                              count: 4, // عدد الصفحات
                              effect: ExpandingDotsEffect(
                                activeDotColor: Colors.black, // لون النقطة الحالية
                                dotColor: Colors.grey, // لون النقاط الأخرى
                                dotHeight: 10,
                                dotWidth: 10,
                                expansionFactor: 2, // النقطة النشطة بتكبر
                              ),
                            ),
                ),
        ],
      ),
      
      
    );
  }
}