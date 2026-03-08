import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/screen/password_screen.dart';

import 'login_screen.dart';

class PinVerificationScreen extends StatefulWidget {
  PinVerificationScreen({super.key});
  static const String name = '/PinVerificationScreen';

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController _codeTEcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 200),
                  Text(
                    'Pin verification',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "We have sent a verification code to example@gmail.com.",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Enter the code bellow to verify your account..",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _codeTEcontroller,
                    decoration: InputDecoration(
                      labelText: 'Verification Code',
                      hintText: 'Enter code that sent to your email',
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                          PasswordScreen.name
                      );
                    },
                    child: Text("Verify"),
                  ),
                  SizedBox(height: 5),

                  SizedBox(height: 16),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        text: "Already have an account? ",
                        children: [
                          TextSpan(
                            text: "  Sign In",
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(
                                  context,
                                    LoginScreen.name
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _codeTEcontroller.dispose();

    super.dispose();
  }
}
