import 'package:flutter/material.dart';

class FormContainerWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final bool? isEmailField;
  final bool? isNameField;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final TextInputType? inputType;
  final bool? isConfirmPasswordField;
  final TextEditingController? passwordController;
  final TextEditingController? confirmPasswordController;
  final Function(String)? onChanged;
  //final String? errorMessage;
  final bool isError;

  const FormContainerWidget({
    this.controller,
    this.fieldKey,
    this.isPasswordField,
    this.isEmailField,
    this.isNameField,
    this.onSaved,
    this.validator,
    this.hintText,
    this.inputType,
    this.isConfirmPasswordField,
    this.passwordController,
    this.confirmPasswordController,
    this.onChanged,
    //this.errorMessage,
    required this.isError,
  });

  @override
  State<FormContainerWidget> createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {
  bool _obscureText = true;
  bool _passwordIsValid = false;
  bool _emailIsValid = false;
  bool _nameIsValid = false;
  bool _isValid = false;
  bool _hasTyped = false;
  //String? _errorMessage;



  //  bool _validateInput(String value) {
  //   if (widget.isPasswordField == true) {
  //     return value.length >= 8 &&
  //         RegExp(r'[A-Z]').hasMatch(value) &&
  //         RegExp(r'[0-9]').hasMatch(value) &&
  //         RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
          
  //   } else if (widget.isConfirmPasswordField == true) {
  //     return value == widget.passwordController?.text;
      
  //   } 
   
  //   else if (widget.isEmailField == true) {
  //     return value.contains("@");

  //   } else if (widget.isNameField == true) {
  //     return value.trim().isNotEmpty;
  //   }
  //   return true;
  // }

  // void _onChanged(String value) {
  //   setState(() {
  //     _hasTyped = true;
  //     _isValid = _validateInput(value); 
  //     _errorMessage = null; 
  //   });
  // }

  // String? _validateField(String? value) {
    //  if (widget.isNameField == true && !_validateInput(value!)) {
    //   return "Please enter a valid name.";
    // }

  //   if (widget.isEmailField == true && !_validateInput(value!)) {
  //     return "Please enter a valid email address.";
  //   }
  //   if (widget.isPasswordField == true && !_validateInput(value!)) {
  //     return "Password must be at least 8 characters long, contain an uppercase letter, a number, and a special character.";
  //   }
    // if (widget.isConfirmPasswordField == true &&
    //     widget.passwordController != null &&
    //     value != widget.passwordController!.text) {
    //   return "Password and confirm password do not match";
    // }

  //   return null;
    
  // }

  // bool _validatePassword(String password) {
  //   return password.length >= 8 // At least 8 characters
  //       &&
  //       RegExp(r'[A-Z]').hasMatch(password) // At least one uppercase letter
  //       &&
  //       RegExp(r'[0-9]').hasMatch(password) // At least one number
  //       &&
  //       RegExp(r'[!@#$%^&*(),.?":{}|<>]')
  //           .hasMatch(password); // At least one special character
  // }

  // bool _validateEmail(String email) {
  //   return email.contains("@");
  // }

  // bool _validateName(String name) {
  //   return name.trim().isNotEmpty;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextFormField(
        controller: widget.controller,
        key: widget.fieldKey,
        obscureText: widget.isPasswordField == true ? _obscureText : false,
       validator: widget.validator,
       
      //  (value) {
      //   if (widget.isEmailField == true && !_validateInput(value!)) {
      //     return "Please enter a valid email address.";
      //   }
      //   if (widget.isPasswordField == true && !_validateInput(value!)) {
      //     return "Password must be at least 8 characters long, contain an uppercase, a number, ans a special character.";
      //   }
      //   if (widget.isConfirmPasswordField != null && widget.passwordController != null) {
      //     if (value != widget.passwordController!.text) {
      //       return "Password and confirm password do not match";
      //     }
        
      //   }
      
      // },
        keyboardType: widget.inputType,
        onChanged: widget.onChanged,
        // (value) {
        //   setState(() {
        //     _hasTyped = true;
        //     // _isValid = _validateInput(value);
        //     if (widget.isPasswordField == true) {
        //       _passwordIsValid = _validatePassword(value);
        //     } else if (widget.isConfirmPasswordField == true) {
        //       _passwordIsValid = value == widget.passwordController?.text;
        //     } else if (widget.isEmailField == true) {
        //       _emailIsValid = _validateEmail(value);
        //     } else if (widget.isNameField == true) {
        //       _nameIsValid = _validateName(value);
        //     }
        //     _errorMessage = null;
        //   });
        // },
        decoration: InputDecoration(
          filled: false,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey),
          
         // errorText: widget.isError ? widget.errorMessage : null,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: widget.isPasswordField == true || widget.isConfirmPasswordField == true
                ? Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: _obscureText == false ? Colors.black : Colors.grey,
                  )
                : Text(''),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(0)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.isError ? Colors.red : Colors.grey,
                //  _hasTyped 
                //  ? (_isValid ? Colors.green : Colors.red)
                //  : Colors.grey,
                // widget.isNameField == true
                //     ? (_nameIsValid ? Colors.green : Colors.red)
                //     : widget.isPasswordField == true
                //     ? (_passwordIsValid ? Colors.green : Colors.red)
                //     : widget.isConfirmPasswordField == true
                //     ? (_passwordIsValid ? Colors.green : Colors.red)
                //     : widget.isEmailField == true
                //     ? (_emailIsValid ? Colors.green : Colors.red)
                //     : Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:widget.isError ? Colors.red : Colors.grey,
              //  _hasTyped 
              //    ?(_isValid ? Colors.green : Colors.red)
              //    : Colors.grey,
              // widget.isNameField == true
              //     ? (_nameIsValid ? Colors.green : Colors.red)
              //     : widget.isPasswordField == true
              //     ? (_passwordIsValid ? Colors.green : Colors.red)
              //     : widget.isConfirmPasswordField == true
              //     ? (_passwordIsValid ? Colors.green : Colors.red)
              //     : widget.isEmailField == true
              //     ? (_emailIsValid ? Colors.green : Colors.red)
              //     : Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(0),
          ),
        ),
      ),
    );
  }
}
