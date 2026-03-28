import 'package:flutter/material.dart';
import 'package:task_manager/screen/add_new_task_screen.dart';
import 'package:task_manager/widgets/task_cart_widget.dart';

import '../Data/Services/api_caller.dart';
import '../Data/models/task_status_model.dart';
import '../utils/urls.dart';
import '../widgets/count_widget.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});
  static const String name = '/NewTaskScreen';

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _taskStatusCountInProgress = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllTaskCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: Visibility(
              visible: _taskStatusCountInProgress==false,
              replacement: SizedBox(

                 width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(19.0),
                    child: CircularProgressIndicator(strokeWidth: 7,),
                  ))
              ,
              child: CountWidget(taskCount: _taskCount),
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
          Navigator.pushNamed(context, AddNewTaskScreen.name);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  List<TaskStatusModel> _taskCount = [];

   Future<void> getAllTaskCount() async {
    _taskStatusCountInProgress = true;
    setState(() {});
    final ApiResponse response = await ApiCaller.getRequest(
      url: urls.taskStatusCount,
    );
    if (response.isSuccess) {
      List<TaskStatusModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskStatusModel.fromjson(jsonData));
      }
      _taskCount = list;
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response.errorMsg.toString())));
    }
    _taskStatusCountInProgress = false;
    setState(() {
    });
  }
}

