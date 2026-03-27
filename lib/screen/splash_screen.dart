import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/screen/main_screen.dart';
import '../controller/auth_controller.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name='/splashScreen';
  @override

  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  bool buttonVisible = false;
  bool isLogin = false;
  void initState() {
    super.initState();
    checkedLogin();
    show_button();
  }
  Future<void> checkedLogin()async{
    isLogin= await AuthController.isUserAlreadLoggedin();
    if(isLogin){

      await AuthController.getUserData();
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainScreen.name,
            (route)=>false,
      );
    }

  }

  Future<void> show_button() async {
    await Future.delayed(Duration(seconds: 2), () {
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
            child: Column(
              children: [
                SizedBox(height: 120),
                SvgPicture.asset(
                  "assets/images/undraw_process_0wew.svg",
                  height: 400,
                ),
                SizedBox(height: 50),
                AnimatedOpacity(
                  opacity: buttonVisible ? 1 : 0,
                  duration: Duration(seconds: 1),
                  child: ElevatedButton(
                    onPressed: () async {
                      {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          LoginScreen.name,
                          (route) => false,
                        );
                      }
                    },
                    child: Text(isLogin?"Welcome Back":"Get Started"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
