import 'package:flutter/material.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool buttonVisible = false;

  void initState() {
    super.initState();
    show_button();
  }
Future<void> show_button()async{
    await  Future.delayed(Duration(seconds: 2), () {
      setState(() {
        buttonVisible = true;
      });
    });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: SafeArea(
            child: AnimatedOpacity(
              opacity: buttonVisible ? 1 : 0,
              duration: Duration(seconds: 1),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (contex) => LoginScreen()),
                  );
                },
                child: Text("Get Started"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
