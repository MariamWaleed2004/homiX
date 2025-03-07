import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/authentication/domain/entities/user_entity.dart';
import 'package:homix/features/authentication/presentation/cubit/credential_cubit/credential_cubit.dart';
import 'package:homix/features/authentication/presentation/widgets/button_container_widget.dart';
import 'package:homix/features/authentication/presentation/widgets/check_box_widget.dart';
import 'package:homix/features/authentication/presentation/widgets/form_container_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool _isSigningUp = false;
  bool _isChecked = false;

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Create Your Account',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(height: 5),
                Text(
                  'Welcome! Please enter your details',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: height * 0.03),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: FormContainerWidget(
                    controller: _nameController,
                    hintText: "Name",
                    isNameField: true,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: FormContainerWidget(
                    controller: _emailController,
                    hintText: "Email",
                    isEmailField: true,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: FormContainerWidget(
                    controller: _passwordController,
                    hintText: "Password",
                    isPasswordField: true,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: FormContainerWidget(
                    controller: _confirmPasswordController,
                    hintText: "Confirm Password",
                    isConfirmPasswordField: true,
                    passwordController: _passwordController,
                  ),
                ),
                SizedBox(height: height * 0.01),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Transform.scale(
                          scale: 0.8,
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: CheckBoxWidget(
                                onChanged: (value) {
                                  setState(() {
                                    _isChecked = value;
                                  });
                                },
                              ))),
                      Text(
                        "Accept Terms & Conditions",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: ButtonContainerWidget(
                    color: Colors.black,
                    child: _isSigningUp == false
                        ? Text(
                            'SignUp',
                            style: TextStyle(
                              color: Colors.white,
                              //fontWeight: FontWeight.w600
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Signing Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: width * 0.01,
                              ),
                              CircularProgressIndicator(),
                            ],
                          ),
                    onTapListener: () {
                      if (!_isChecked) {
                        toast("You must accept the Terms & Conditions");
                        return;
                      } if(_formKey.currentState!.validate()) {
                        _signUpUser();
                      }
                      // if (_nameController.text.isNotEmpty &&
                      //     _emailController.text.isNotEmpty &&
                      //     _passwordController.text.isNotEmpty &&
                      //     _confirmPasswordController.text.isNotEmpty) {
                      //     } else { 
                      //       toast("Please fill in all fields");
                      //     }
                    },
                  ),
                ),
                SizedBox(height: height * 0.02),
                Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                      ),
                      Text(
                        'OR',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 240, 239, 239),
                      foregroundColor: Colors.black,
                      shadowColor: Colors.transparent,
                      side: BorderSide(
                        color: Colors.grey,
                      ),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            //height: height * 0.05,
                            width: width * 0.1,
                            child: Image.asset('assets/logo_.png')),
                        SizedBox(width: width * 0.02),
                        Text('Sign up with Google'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, ScreenConst.signInScreen, (route) => false);
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signUpUser() async {
    //final userUid = FirebaseAuth.instance.currentUser!.uid;

    try {
      setState(() {
        _isSigningUp = true;
      });
      BlocProvider.of<CredentialCubit>(context)
          .signUpUser(
            user: UserEntity(
                uid: '',
                name: _nameController.text,
                email: _emailController.text,
                password: _passwordController.text,
                confirmPassword: _confirmPasswordController.text),
          )
          .then((value) => _clear());
    } catch (e) {
      setState(() {
        _isSigningUp = false;
      });
      toast("Sign up failed. Please try again.");
    }
  }

  _clear() {
    setState(() {
      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
      _isSigningUp = false;
    });
  }
}
