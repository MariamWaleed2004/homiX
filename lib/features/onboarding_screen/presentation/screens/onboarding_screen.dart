import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/onboarding_screen/presentation/widgets/subonboarding_widget_1.dart';
import 'package:homix/features/onboarding_screen/presentation/widgets/subonboarding_widget_2.dart';
import 'package:homix/features/onboarding_screen/presentation/widgets/subonboarding_widget_3.dart';
import 'package:homix/features/onboarding_screen/presentation/widgets/subonboarding_widget_4.dart';
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
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
              child: Text(
                'HomiX',
                style: GoogleFonts.poppins(
                  fontSize: width * 0.07,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              children: [
                SubonboardingWidget1(),
                SubonboardingWidget2(),
                SubonboardingWidget3(),
                SubonboardingWidget4(),
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: SmoothPageIndicator(
              controller: pageController,
              count: 4,
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.black,
                dotColor: Colors.grey,
                dotHeight: 10,
                dotWidth: 10,
                expansionFactor: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
