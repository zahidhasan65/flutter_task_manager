
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/Data/Services/api_caller.dart';
import 'package:task_manager/screen/pin_verification_screen.dart';
import 'package:task_manager/utils/validator.dart';

import '../utils/urls.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({super.key});
  static const String name = '/ForgotPasswordScreen';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController _emailTEcontroller = TextEditingController();
  bool _forgotPasswordInProgress=false;

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
                  SizedBox(height: 200),
                  Text(
                    'Forgot Your Password',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "A six-digit verification code will be send to your email address for reset your password.",
                    style: TextStyle(fontSize: 18),
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
                  Visibility(
                    visible: !_forgotPasswordInProgress,
                    replacement: CircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: () {
                        _onTapCode();

                      },
                      child: Text("Code"),
                    ),
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
  void _onTapCode(){
    if(_formkey.currentState!.validate()){
      _forgotPass();
    }
  }

  Future<void> _forgotPass()async{
    _forgotPasswordInProgress=true;
    setState(() {
    });

    final ApiResponse response=await ApiCaller.getRequest(url: urls.forgotPassUrl(_emailTEcontroller.text.trim()));
if(response.isSuccess){
  Navigator.pushNamed(
      context,
      PinVerificationScreen.name
  );
}
else{
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.errorMsg.toString())));
}

    _forgotPasswordInProgress=false;
    setState(() {
    });
  }

  @override
  void dispose() {
    _emailTEcontroller.dispose();
    super.dispose();
  }
}
