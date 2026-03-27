import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/Data/Services/api_caller.dart';
import 'package:task_manager/screen/main_screen.dart';
import 'package:task_manager/screen/signup_screen.dart';
import '../Data/models/user_models.dart';
import '../controller/auth_controller.dart';
import '../utils/urls.dart';
import '../utils/validator.dart';
import 'forgot_password_screen.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  static const String name='/LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController _emailTEcontroller = TextEditingController();

  final TextEditingController _passwordTEcontroller = TextEditingController();
  bool _loginInProgress=false;

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
                    'Get Started With',
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

                  TextFormField(
                    validator: Validator.password,
                    controller: _passwordTEcontroller,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: '********',
                    ),
                  ),
                  SizedBox(height: 16),
                  Visibility(
                    visible: _loginInProgress==false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate())
                        userLogin();

                      },
                      child: Text("Login"),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,

                            ForgotPasswordScreen.name,
                        );
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 1),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        text: "Don't have an account?  ",
                        children: [
                          TextSpan(
                            text: "  Sign Up",
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(
                                  context,
                                 SignupScreen.name
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

Future<void> userLogin()async{
  _loginInProgress=true;
  setState(() {

  });
  Map<String,dynamic> loginDataBody=
  {
      "email":_emailTEcontroller.text.trim(),
      "password":_passwordTEcontroller.text
  };

  final ApiResponse response=await ApiCaller.postRequest(url: urls.loginUrl, body: loginDataBody);
  if(response.isSuccess&&response.responseData['status']=='success'){
    UserModels model=UserModels.fromJson(response.responseData['data']);
    String token=response.responseData['token'];
    await AuthController.saveUserData(model, token);
    Navigator.pushNamedAndRemoveUntil(
      context, MainScreen.name,
          (route)=>false,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Login Successful")),
    );
  }
  else{
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.errorMsg?? 'Login Fail')),
    );

  }

  _loginInProgress=false;
  setState(() {

  });
  print("dome");
  
}
  @override
  void dispose() {
    _emailTEcontroller.dispose();
    _passwordTEcontroller.dispose();
    super.dispose();
  }
}
