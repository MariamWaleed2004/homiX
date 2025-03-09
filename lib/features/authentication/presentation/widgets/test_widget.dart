import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isError;
  final String errorMessage;
  final bool isPassword;
  final Function(String) onChanged;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.isError,
    required this.errorMessage,
    required this.onChanged,
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword,
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: widget.isError ? widget.errorMessage : null,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.isError ? Colors.red : Colors.grey),
        ),
      ),
      onChanged: widget.onChanged,
    );
  }
}
