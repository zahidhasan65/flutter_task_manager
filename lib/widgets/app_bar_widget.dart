import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/screen/login_screen.dart';
import '../screen/update_profile_screen.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, this.updateScreen});
  final bool? updateScreen;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(65);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  final image=AuthController.userModel!.photo;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          GestureDetector(
            onTap: () async {
              if (widget.updateScreen ?? false) {
                return;
              }
              final result = await Navigator.pushNamed(
                context,
                UpdateProfile.name,
              );
              if (result == true) {
                setState(() {});
              }
            },
            child: CircleAvatar(
              radius: 25,
              child: image!.isNotEmpty? (Image.memory(base64Decode(image!.split('.').last) )
              
              ):
              Icon(Icons.person)
              ,
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AuthController.userModel?.fullName ?? " ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                AuthController.userModel?.email ?? " ",
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: signOut,
          icon: Icon(
            Icons.logout,
            size: 32,
            color: Colors.black.withOpacity(.7),
          ),
        ),
      ],
      backgroundColor: Colors.blue,
    );
  }

  Future<void> signOut() async {
    await AuthController.clearUserData();
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginScreen.name,
      (predicate) => false,
    );
  }
}
