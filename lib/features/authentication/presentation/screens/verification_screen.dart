import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homix/core/const.dart';
import 'package:homix/main_screen.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  Timer? _emailVerificationTimer;
  bool isEmailVerified = false;
  User? currentUser = FirebaseAuth.instance.currentUser;


  @override
  void initState() {
    super.initState();
    _startEmailVerificationCheck();
  }

  void _startEmailVerificationCheck() {
    _emailVerificationTimer =
      Timer.periodic(Duration(seconds: 3), (timer) async {
      User? user = FirebaseAuth.instance.currentUser;
      await user?.reload();
      user = FirebaseAuth.instance.currentUser;

      if (user != null && user.emailVerified) {
        timer.cancel();
        setState(() {
          isEmailVerified = true;
        });

        // Navigate to main screen or home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen(uid: user!.uid)),
        );
      }
    });
  }

  @override
  void dispose() {
    _emailVerificationTimer?.cancel();
    super.dispose();
  }


  Future<void> resendVerificationEmail() async {
  try {
    await currentUser!.sendEmailVerification();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Verification email sent!')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to send email: $e')),
    );
  }
}




  @override
  Widget build(BuildContext context) {
      User? user = FirebaseAuth.instance.currentUser;

    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Verification Email"),
      ),
      body: Center(
        child: isEmailVerified
            ? const Text("Email verified! Redirecting...")
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.email,
                      size: 80,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "A verification email has been sent to",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "${user!.email}",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive the email?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: resendVerificationEmail,
                          child: const Text(
                            "Resend Email",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
