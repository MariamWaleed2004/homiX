import 'package:flutter/material.dart';
import 'package:homix/features/authentication/presentation/widgets/test_widget.dart';



class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _emailError = false;
  bool _passwordError = false;

  void _validateForm() {
    setState(() {
      _emailError = _emailController.text.isEmpty;
      _passwordError = _passwordController.text.isEmpty;
    });

    if (!_emailError && !_passwordError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form submitted successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              controller: _emailController,
              labelText: "Email",
              isError: _emailError,
              errorMessage: "Email cannot be empty",
              onChanged: (value) {
                setState(() {
                  _emailError = value.isEmpty;
                });
              },
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: _passwordController,
              labelText: "Password",
              isError: _passwordError,
              errorMessage: "Password cannot be empty",
              isPassword: true,
              onChanged: (value) {
                setState(() {
                  _passwordError = value.isEmpty;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _validateForm,
              child: Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
