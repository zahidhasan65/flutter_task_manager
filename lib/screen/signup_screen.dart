import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/screen/login_screen.dart';
import 'main_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  static const String name = '/SignupScreen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailTEcontroller = TextEditingController();
  final TextEditingController _fstnameTEcontroller = TextEditingController();
  final TextEditingController _lstnameTEcontroller = TextEditingController();
  final TextEditingController _phoneTEcontroller = TextEditingController();
  final TextEditingController _passwordTEcontroller = TextEditingController();
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
                  SizedBox(height: 70),
                  Text(
                    'Join With Us',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _emailTEcontroller,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'example@gmail.com',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _fstnameTEcontroller,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      hintText: 'Zahid',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _lstnameTEcontroller,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      hintText: 'Hasan',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    controller: _phoneTEcontroller,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      hintText: '0174971......',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _passwordTEcontroller,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: '********',
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        MainScreen.name,
                        (route) => false,
                      );
                    },
                    child: Text("Register"),
                  ),
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
    _emailTEcontroller.dispose();
    _passwordTEcontroller.dispose();
    _fstnameTEcontroller.dispose();
    _lstnameTEcontroller.dispose();
    _phoneTEcontroller.dispose();
    super.dispose();
  }
}
