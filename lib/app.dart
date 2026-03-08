import 'package:flutter/material.dart';
import 'package:task_manager/screen/add_new_task_screen.dart';
import 'package:task_manager/screen/forgot_password_screen.dart';
import 'package:task_manager/screen/login_screen.dart';
import 'package:task_manager/screen/main_screen.dart';
import 'package:task_manager/screen/new_task_screen.dart';
import 'package:task_manager/screen/password_screen.dart';
import 'package:task_manager/screen/pin_verification_screen.dart';
import 'package:task_manager/screen/signup_screen.dart';
import 'package:task_manager/screen/splash_screen.dart';
import 'package:task_manager/screen/update_profile_screen.dart';
class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreen.name,
     routes: {
       SplashScreen.name:(_)=>SplashScreen(),
       AddNewTaskScreen.name:(_)=>AddNewTaskScreen(),
       ForgotPasswordScreen.name:(_)=>ForgotPasswordScreen(),
       LoginScreen.name:(_)=>LoginScreen(),
       MainScreen.name:(_)=>MainScreen(),
       NewTaskScreen.name:(_)=>NewTaskScreen(),
       PasswordScreen.name:(_)=>PasswordScreen(),
       PinVerificationScreen.name:(_)=>PinVerificationScreen(),
       SignupScreen.name:(_)=>SignupScreen(),
       UpdateProfile.name:(_)=>UpdateProfile(),


     },

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: Colors.grey.shade100,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22
            ),
            minimumSize: Size( double.infinity,50),
            backgroundColor: Colors.blue.shade500,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(16))
          )
      ),

      )
    );
  }
}
