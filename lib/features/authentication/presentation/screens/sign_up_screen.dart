import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/authentication/domain/entities/user_entity.dart';
import 'package:homix/features/authentication/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:homix/features/authentication/presentation/cubit/credential_cubit/credential_cubit.dart';
import 'package:homix/features/authentication/presentation/widgets/button_container_widget.dart';
import 'package:homix/features/authentication/presentation/widgets/check_box_widget.dart';
import 'package:homix/features/authentication/presentation/widgets/form_container_widget.dart';
import 'package:homix/main_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isSigningUp = false;
  bool _isChecked = false;
  bool _isCheckedError = false;

  bool _emailError = false;
  bool _passwordError = false;
  bool _nameError = false;
  bool _confirmPasswordError = false;
  bool _isPasswordField = false;
  bool _validateErrorMessage = false;
  bool isEmailVerified = false;

  // @override
  // void initState() {
  //   super.initState();
  //   isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
  // }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validatePassword(String password) {
    return password.length >= 8 // At least 8 characters
        &&
        RegExp(r'[A-Z]').hasMatch(password) // At least one uppercase letter
        &&
        RegExp(r'[0-9]').hasMatch(password) // At least one number
        &&
        RegExp(r'[!@#$%^&*(),.?":{}|<>]')
            .hasMatch(password); // At least one special character
  }

  bool _validateEmail(String email) {
    return email.contains("@");
  }

  bool _validateName(String name) {
    return name.trim().isNotEmpty;
  }

  bool _validateConfirmPassword(String confirmPassword) {
    return confirmPassword.trim().isNotEmpty;
  }

  String? _validateField(String? value, String fieldType) {
    if (fieldType == "email" && !_validateEmail(value!)) {
      _validateErrorMessage = true;
      if (_validateErrorMessage == true) {
        return "Please enter a valid email address.";
      }
    }

    if (fieldType == "password" && !_validatePassword(value!)) {
      return "Please enter a valid password";
      //"Password must be at least 8 characters long, contain an uppercase letter, a number, and a special character.";
    }

    if (fieldType == "name" && !_validateName(value!)) {
      return "Please enter a valid name.";
    }

    if (fieldType == "confirmPassword" &&
        _passwordController != null &&
        value != _passwordController!.text) {
      return "Password and confirm password do not match";
    }

    if (fieldType == "confirmPassword" && !_validateConfirmPassword(value!)) {
      return "Please enter a valid confirm password";
    }

    return null;
  }

  void _onTextChanged(String value, String field) {
    setState(() {
      if (field == "email" && _validateEmail(value)) {
        _emailError = false;
        _validateErrorMessage = false;
      }
      if (field == "password") _passwordError = false;

      if (field == "name") _nameError = false;
      if (field == "confirmPassword") _confirmPasswordError = false;
    });
  }

  void _onCheckBoxChanged(bool value) {
    setState(() {
      _isChecked = value;
      _isCheckedError = !value; // Hide error when checked
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
        body: BlocConsumer<CredentialCubit, CredentialState>(
      listener: (context, credentailState) {
        if (credentailState is CredentialLoading) {
          setState(() {
            _isSigningUp = true;
          });
        }

        if (credentailState is CredentialSuccess &&
            user != null &&
            !user.emailVerified
            ) {
          BlocProvider.of<AuthCubit>(context).loggedIn();
          Navigator.pushNamed(
              context, ScreenConst.verificationScreen);
          setState(() {
            _isSigningUp = false;
          });
        }

        if (credentailState is CredentialFailure) {
          setState(() {
            _isSigningUp = false;
          });
          toast('Invalid Email and Password');
        }
      },
      builder: (context, credentailState) {
        // if (credentailState is CredentialSuccess) {
        //   return BlocBuilder<AuthCubit, AuthState>(
        //     builder: (context, authState) {
        //       if (authState is Authenticated) {
        //         return MainScreen(uid: authState.uid);
        //       } else {
        //         return _bodyWidget();
        //       }
        //     },
        //   );
        // }
        return _bodyWidget();
      },
    ));
  }

  _bodyWidget() {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);
    return Form(
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
                  isError: _nameError,
                  controller: _nameController,
                  hintText: "Name",
                  isNameField: true,
                  //errorMessage: "Please enter a valid name",
                  onChanged: (value) => _onTextChanged(value, "name"),
                  validator: (value) => _validateField(value, "name"),
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
                  isError: _emailError,
                  // errorMessage: "",
                  onChanged: (value) => _onTextChanged(value, "email"),
                  validator: (value) => _validateField(value, "email"),
                  // (value) {
                  //   setState(() {
                  //     _emailError = value.isEmpty;
                  //   });
                  // },
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                child: FormContainerWidget(
                  isError: _passwordError,
                  controller: _passwordController,
                  hintText: "Password",
                  isPasswordField: true,
                  //errorMessage: "Please enter a valid password",
                  onChanged: (value) => _onTextChanged(value, "password"),
                  validator: (value) => _validateField(value, "password"),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                child: FormContainerWidget(
                  isError: _confirmPasswordError,
                  controller: _confirmPasswordController,
                  hintText: "Confirm Password",
                  isConfirmPasswordField: true,
                  isPasswordField: true,
                  //errorMessage: "Please enter a valid confirm password",
                  passwordController: _passwordController,
                  onChanged: (value) =>
                      _onTextChanged(value, "confirmPassword"),
                  validator: (value) =>
                      _validateField(value, "confirmPassword"),
                ),
              ),
              SizedBox(height: height * 0.01),
              // Padding(
              //   padding: const EdgeInsets.only(left: 8.0),
              //   child: Row(
              //     children: [
              //       Transform.scale(
              //           scale: 0.8,
              //           child: Align(
              //               alignment: Alignment.topLeft,
              //               child: CheckBoxWidget(

              //                 onChanged: _onCheckBoxChanged,
              //               ))),
              //       Text(
              //         "Accept Terms & Conditions",
              //         style: TextStyle(fontSize: 12),
              //       )
              //     ],
              //   ),
              // ),
              // if (_isCheckedError) // Show error if unchecked
              //   Align(
              //     alignment: Alignment.topLeft,
              //     child: Padding(
              //       padding: const EdgeInsets.only(left: 20.0),
              //       child: const Text(
              //           "You must accept the Terms & Conditions",
              //           style: TextStyle(color: Color.fromARGB(255, 192, 46, 36), fontSize: 12),
              //         ),
              //     ),
              //   ),

              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      minimumSize: Size(double.infinity, 50)),
                  onPressed: _isSigningUp
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            _signUpUser();
                          }
                        },
                  child: _isSigningUp == false
                      ? Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
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
                            LoadingAnimationWidget.fourRotatingDots(
                                color: Colors.white, size: 24),
                          ],
                        ),
                ),

                //  ButtonContainerWidget(
                //   color: _isSigningUp ? Colors.grey[300] : Colors.black,
                //    onTapListener: _isSigningUp
                //   ? null
                //   : () {
                //     if (_formKey.currentState!.validate()) {
                // _signUpUser();
                // }
                //   } ,
                //   child: _isSigningUp == false
                //       ? Text(
                //           'SignUp',
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontWeight: FontWeight.w600
                //           ),
                //         )
                //       : Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Text(
                //               'Signing Up',
                //               style: TextStyle(
                //                   color: _isSigningUp ? Colors.grey[500] : Colors.white,
                //                   fontWeight: FontWeight.w600),
                //             ),
                //             SizedBox(
                //               width: width * 0.01,
                //             ),
                //           LoadingAnimationWidget.fourRotatingDots(color: Colors.grey, size: 24),

                //           ],
                //         ),
                // ),
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
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 240, 239, 239),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      minimumSize: Size(width * 0.1, 50)),
                  onPressed: _isSigningUp ? null : _signUpWithGoogle,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          //height: height * 0.05,
                          width: width * 0.1,
                          child: Image.asset('assets/logo_.png')),
                      SizedBox(width: width * 0.02),
                      Text(
                        'Sign up with Google',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                // ButtonContainerWidget(
                //     color: const Color.fromARGB(255, 240, 239, 239),
                //   child:  Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [

                //     Container(
                //         //height: height * 0.05,
                //         width: width * 0.1,
                //         child: Image.asset('assets/logo_.png')),
                //     SizedBox(width: width * 0.02),
                //     Text('Sign up with Google'),
                //   ],
                // ),
                //     onTapListener: () {
                //      _signUpWithGoogle();
                //     },
                //   ),
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
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  )
                ],
              )
            ],
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
        _emailError = _emailController.text.isEmpty;
        _passwordError = _passwordController.text.isEmpty;
        _nameError = _nameController.text.isEmpty;
        _confirmPasswordError = _confirmPasswordController.text.isEmpty;
      });
      await BlocProvider.of<CredentialCubit>(context)
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

  void _signUpWithGoogle() {
    setState(() {
      _isSigningUp = true;
    });
    BlocProvider.of<CredentialCubit>(context).signUpWithGoogle(context);

    setState(() {
      _isSigningUp = false;
    });
  }
}
