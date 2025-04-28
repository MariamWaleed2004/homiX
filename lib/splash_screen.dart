import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/authentication/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:homix/features/authentication/presentation/cubit/credential_cubit/credential_cubit.dart';
import 'package:homix/features/home/presentation/screens/home_screen.dart';
import 'package:homix/features/onboarding_screen/presentation/screens/onboarding_screen.dart';
import 'package:homix/main_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
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
      Navigator.of(context).pushReplacementNamed(ScreenConst.onboardingScreen);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);

    return Scaffold(
        body: BlocConsumer<CredentialCubit, CredentialState>(
      listener: (context, credentialState) {
        if (credentialState is CredentialSuccess) {
          BlocProvider.of<AuthCubit>(context).loggedIn();
        }
        if (credentialState is CredentialFailure) {
          toast('Invalid Email and Password');
        }
      },
      builder: (context, credentailState) {
        if (credentailState is CredentialSuccess) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              if (authState is Authenticated) {
                return MainScreen(uid: authState.uid);
              } else {
                return _bodyWidget();
              }
            },
          );
        }
        return _bodyWidget();
      },
    ));
  }

  _bodyWidget() {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);

    return FadeTransition(
      opacity: _animation,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'HomiX',
              style: GoogleFonts.poppins(
                fontSize: width * 0.15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Lottie.asset(
              'assets/loading_1.json',
              width: width * 0.6,
              height: width * 0.6,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
