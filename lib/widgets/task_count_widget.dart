import 'package:flutter/material.dart';
class Task_Count extends StatelessWidget {
  final value;
  String taskTitle;
  Task_Count({
    super.key,required this.value, required this.taskTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(value.toString(),style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
            Text(taskTitle,style: TextStyle(fontSize: 16),),
          ],
        ),
      ),
    );
  }
}