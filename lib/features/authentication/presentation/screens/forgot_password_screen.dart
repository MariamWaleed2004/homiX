import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/authentication/presentation/widgets/form_container_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final TextEditingController _emailController = TextEditingController();
  bool _emailError = false;



  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
        context: context, 
        builder: (context) {
        return AlertDialog(
          content: Text(
            "Password reset link sent! check your email",
            textAlign: TextAlign.center,

          ),
        );
      }
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context, 
        builder: (context) {
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
        double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter Your email and we will send you a password reset link",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
                ),
                 SizedBox(
                height: height * 0.02,
              ),
                FormContainerWidget(
                  controller: _emailController,
                  inputType: TextInputType.emailAddress,
                  hintText: "Email",
                  isError: _emailError,
                  ),
                   SizedBox(
                height: height * 0.02,
              ),
              ElevatedButton(
                onPressed: passwordReset,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                ),
                child: Text("Reset Password"),
                )
            ],
          ),
      ),
      
    );
  }
}