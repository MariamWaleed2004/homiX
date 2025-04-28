import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/authentication/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:homix/features/authentication/presentation/cubit/credential_cubit/credential_cubit.dart';
import 'package:homix/features/authentication/presentation/widgets/button_container_widget.dart';
import 'package:homix/features/authentication/presentation/widgets/check_box_widget.dart';
import 'package:homix/features/authentication/presentation/widgets/form_container_widget.dart';
import 'package:homix/main_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
   final GoogleSignIn _googleSignIn = GoogleSignIn();


  bool _emailError = false;
  bool _passwordError = false;
  bool _isSigningIn = false;
  bool _validateErrorMessage = false;




    bool _validatePassword(String password) {
    return password.isNotEmpty;
  }

  bool _validateEmail(String email) {
    final regex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,6}$');
    return regex.hasMatch(email);
}


    String? _validateField(String? value, String fieldType) {
    if (fieldType == "email" && !_validateEmail(value!)) {
        return "Please enter a valid email address.";
    }

    if (fieldType == "password" && !_validatePassword(value!)) {
      return "Please enter a valid password";
    }

    
    return null;
  }


  void _onTextChanged(String value, String field) {
  setState(() {
    final error = _validateField(value, field);

    switch (field) {
      case "email":
        _emailError = error != null;
        _validateErrorMessage = error != null;
        break;
      case "password":
        _passwordError = error != null;
        break;


    }
  });
}

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: 
      BlocConsumer<CredentialCubit, CredentialState>(
          listener: (context, credentialState) {

            if(credentialState is CredentialLoading) {
              setState(() {
                _isSigningIn = true;
              });
            }

            if(credentialState is CredentialSuccess) {
              BlocProvider.of<AuthCubit>(context).loggedIn();
              setState(() {
                _isSigningIn = false;
              });
            }
            if(credentialState is CredentialFailure) {
               setState(() {
                _isSigningIn = false;
              });
            }
          },
          builder: (context, credentailState) {
            if(credentailState is CredentialSuccess) {
              return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
                  if(authState is Authenticated) {
                    return MainScreen(uid: authState.uid);
                  } else {
                    return _bodyWidget();
                  }
                },
                );
            }
            return _bodyWidget();
          },
        )
    );
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
                  'Sign In To Your Account',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Welcome Back! Please enter your details',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: FormContainerWidget(
                    inputType: TextInputType.emailAddress,
                    controller: _emailController,
                    isError: _emailError,
                    hintText: "Email",
                    onChanged: (value) => _onTextChanged(value, "email"),
                    validator: (value) => _validateField(value, "email"),
      
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: FormContainerWidget(
                    controller: _passwordController,
                    isError: _passwordError,
                    hintText: "Password",
                    isPasswordField: true,
                    validator: (value) => _validateField(value, "password"),
      
                  ),
                ),
                
                SizedBox(height: height * 0.001),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                     TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ScreenConst.forgotPasswordScreen);
                      },
                       child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.001,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: 
                  
                   ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      minimumSize: Size(double.infinity, 50)
                    ),
                    onPressed: _isSigningIn
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                    _signInUser();
                    }
                    } ,
                    child:  _isSigningIn == false
                        ? Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Signing In',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: width * 0.01,
                              ),
                            LoadingAnimationWidget.fourRotatingDots(color: Colors.white, size: 24),

                            ],
                          ),
                    ),


                  // ButtonContainerWidget(
                  //     color: _isSigningIn ? Colors.grey[300] : Colors.black,
                  //     onTapListener: _isSigningIn
                  //   ? null
                  //   : () {
                  //       if (_formKey.currentState!.validate()) {
                  //   _signInUser();
                  //   }
                  //   } ,
                  //     child: _isSigningIn == false
                  //         ? Text(
                  //             'Sign In',
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.w600
                  //             ),
                  //           )
                  //         : Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Text(
                  //                 'Signing In',
                  //                 style: TextStyle(
                  //                     color: _isSigningIn ? Colors.grey[600] : Colors.white,
                  //                     fontWeight: FontWeight.w600),
                  //               ),
                  //               SizedBox(
                  //                 width: width * 0.02,
                  //               ),
                  //               LoadingAnimationWidget.fourRotatingDots(color: Colors.grey, size: 24),
                  //             ],
                  //           ),
                      
                  //   ),
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
                  child: ButtonContainerWidget(
                      color: const Color.fromARGB(255, 240, 239, 239),
                      child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                            //height: height * 0.05,
                            width: width * 0.1,
                            child: Image.asset('assets/logo_.png')),
                        SizedBox(width: width * 0.02),
                        Text('Sign in with Google'),
                      ],
                    ),
                      onTapListener: () {
                       _signInWithGoogle();
                      },
                    ),
                


                  
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   style: ElevatedButton.styleFrom(
                  //     foregroundColor: Colors.black,
                  //     shadowColor: Colors.transparent,
                      // side: BorderSide(
                      //   color: Colors.grey,
                      // ),
                  //     minimumSize: const Size(double.infinity, 50),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(0),
                  //     ),
                  //     textStyle: const TextStyle(
                  //       fontSize: 15,
                  //     ),
                  //   ),
                    // child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [

                    //     Container(
                    //         //height: height * 0.05,
                    //         width: width * 0.1,
                    //         child: Image.asset('assets/logo_.png')),
                    //     SizedBox(width: width * 0.02),
                    //     Text('Sign in with Google'),
                    //   ],
                    // ),
                  // ),
                ),

                // ButtonContainerWidget(
                //       color: const Color.fromARGB(255, 240, 239, 239),
                //       child:   Text('Sign out with Google'),
                //       onTapListener: () {
                //         BlocProvider.of<AuthCubit>(context).loggedOut();
                //        //_googleSignIn.signOut();
                //       },
                //     ),
                SizedBox(height: height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                        context, ScreenConst.signUpScreen, (route) => false);
                      },
                      child: Text('Sign up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
    );
  }


  void _signInUser() async {
    try {
      setState(() {
      _isSigningIn = true;
    });
    await BlocProvider.of<CredentialCubit>(context).signInUser(
      context: context,
        email: _emailController.text, 
        password: _passwordController.text
        ).then((value) => _clear());
    } on FirebaseAuthException 
  catch (e) {
    print("Error: $e");

  }
  }

  _clear() {
    setState(() {
      _emailController.clear();
      _passwordController.clear();
      _isSigningIn = false;
    });
  }


  void _signInWithGoogle() {
    setState(() {
      _isSigningIn = true;
    });
    BlocProvider.of<CredentialCubit>(context).signInWithGoogle(context);
    setState(() {
      _isSigningIn = false;
    });
  }

  
}
