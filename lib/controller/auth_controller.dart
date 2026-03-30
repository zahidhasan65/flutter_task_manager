import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/Data/models/user_models.dart';

class AuthController {
  static final String _accessTokenkey = 'token';
  static final String _accessUserKey = 'user';

  static String? userToken;
  static UserModels? userModel;
  static Future<void> saveUserData(UserModels model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenkey, token);
    await sharedPreferences.setString(
      _accessUserKey,
      jsonEncode(model.toJson()),
    );
    userToken = token;
    userModel = model;

  }

  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenkey);
    if (token != null) {
      String? model = sharedPreferences.getString(_accessUserKey);
      userModel = UserModels.fromJson(jsonDecode(model!));
      userToken = token;
    }
  }

  static Future<bool> isUserAlreadLoggedin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenkey);
    return token != null;
  }

  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
