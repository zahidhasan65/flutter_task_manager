import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class PasswordScreen extends StatefulWidget {
  PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final GlobalKey<FormState>_formkey=GlobalKey<FormState>();

  final TextEditingController _newpasswordTEcontroller=TextEditingController();

  final TextEditingController _confirmpasswordTEcontroller=TextEditingController();



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
                    'Reset password',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 16),

                  Text( "Make sure it is strong and secure and length should not be less then 6 and more then 8.",style: TextStyle(
                      fontSize: 18
                  ),),
                  SizedBox(height: 16),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _newpasswordTEcontroller,
                    decoration: InputDecoration(
                        labelText: 'New Password',
                        hintText: '*********'
                    ),
                  ), SizedBox(height: 16),
                  SizedBox(height: 16),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _confirmpasswordTEcontroller,
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: '*********'
                    ),
                  ), SizedBox(height: 16),
                  ElevatedButton(onPressed: () {}, child: Text("Reset")),
                  SizedBox(height: 5),

                  SizedBox(height: 16),
                  Center(
                    child: RichText(text: TextSpan(
                        style: TextStyle(color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                        text: "Already have an account? ",
                        children: [TextSpan(
                          text: "  Sign In",style: TextStyle(color: Colors.blue,
                        ),
                          recognizer: TapGestureRecognizer()..onTap=(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

                          },
                        )]


                    )),
                  )
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
    _newpasswordTEcontroller.dispose();
    _confirmpasswordTEcontroller.dispose();
    super.dispose();
  }

}
