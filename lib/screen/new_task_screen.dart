import 'package:flutter/material.dart';
import 'package:task_manager/screen/add_new_task_screen.dart';
import 'package:task_manager/widgets/task_cart_widget.dart';

import '../widgets/task_count_widget.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (context, index) {
                return Task_Count(value: 10, taskTitle: 'New Task');
              },
              separatorBuilder: (context, index) {
                return SizedBox();
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: 20,
              itemBuilder: (context, index) {
                return TaskCartWidget();
              },
              separatorBuilder: (context, index) {
                return SizedBox();
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewTaskScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


