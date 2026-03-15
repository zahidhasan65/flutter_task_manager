import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/Data/Services/api_caller.dart';
import 'package:task_manager/screen/login_screen.dart';
import '../Data/utils/urls.dart';
import '../utils/validator.dart';


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
  bool _registerInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    validator: Validator.email,
                    textInputAction: TextInputAction.next,
                    controller: _emailTEcontroller,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'example@gmail.com',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    validator: Validator.firstName,
                    textInputAction: TextInputAction.next,
                    controller: _fstnameTEcontroller,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      hintText: 'Zahid',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    validator: Validator.lastName,
                    textInputAction: TextInputAction.next,
                    controller: _lstnameTEcontroller,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      hintText: 'Hasan',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    validator: Validator.phone,
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
                    obscureText: true,
                    validator: Validator.password,
                    textInputAction: TextInputAction.next,
                    controller: _passwordTEcontroller,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: '********',
                    ),
                  ),
                  SizedBox(height: 16),
                  Visibility(
                    visible: _registerInProgress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate())
                          _userRegister();

                      },
                      child: Text("Register"),
                    ),
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
                                Navigator.pushNamed(context, LoginScreen.name);
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

  Future<void> _userRegister() async {
    setState(() {
      _registerInProgress = true;
    });
    Map<String, dynamic> requistDataBody = {
      "email": _emailTEcontroller.text.trim(),
      "firstName": _fstnameTEcontroller.text.trim(),
      "lastName": _lstnameTEcontroller.text.trim(),
      "mobile": _phoneTEcontroller.text.trim(),
      "password": _passwordTEcontroller.text,
    };
    final ApiResponse response = await ApiCaller.postRequest(
      url: urls.registrationUrl,
      body: requistDataBody
    );
    if (response.isSuccess) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration Successful")),
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.name,
            (route) => false,
      );

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration Failed")),
      );
    }
    _registerInProgress= false;
    setState(() {

    });
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
