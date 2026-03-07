import 'package:flutter/material.dart';

import '../screen/update_profile_screen.dart';
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          GestureDetector(
              onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProfile()));
              },
              child: CircleAvatar(radius: 25)),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Zahid hasan",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                "example@gmail.com",
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications,
            size: 32,
            color: Colors.black.withOpacity(.7),
          ),
        ),
      ],
      backgroundColor: Colors.blue,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(65);
}
