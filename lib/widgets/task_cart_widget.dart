import 'package:flutter/material.dart';
class TaskCartWidget extends StatelessWidget {
  const TaskCartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title: This is title",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: 7),
              Text(
                "hy i am zahid hasan. i am a student if daffodil international university in deparnment of computer science and engneering",
              ),
              SizedBox(height: 7),
              Text('Date: 12/10/2003'),

              Row(
                children: [
                  Chip(
                    label: Text(
                      'New Task',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  Spacer(),
                  IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}