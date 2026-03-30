import 'package:flutter/material.dart';
import 'package:task_manager/Data/models/get_task_model.dart';
import 'package:task_manager/controller/task_count_controller.dart';
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
  bool _newTaskInProgress = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllTaskCount();
    getAllNewTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          count_task_status_widget( taskCount: TaskCountController.taskCount, taskStatusCountInProgress: _taskStatusCountInProgress,),
          Expanded(
            child: Visibility(
              visible: _newTaskInProgress==false,
              replacement: Center(
                child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(strokeWidth:5 ,)),
              ),
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount:_newTask.length ,
                itemBuilder: (context, index) {
                  return TaskCartWidget(taskModel: _newTask[index], refreshList: () {
                    getAllNewTask();
                    getAllTaskCount();
                  }, color: Colors.blue,);
                },
                separatorBuilder: (context, index) {
                  return SizedBox();
                },
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(
            context,
            AddNewTaskScreen.name,
          );

          if (result == true) {
            getAllNewTask();
            getAllTaskCount();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Task Added Successfully")),
            );
          }
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
      url: urls.taskStatusCountUrl,
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

  List<GetTaskModel> _newTask = [];
   Future<void> getAllNewTask() async {
    _newTaskInProgress = true;
    setState(() {});
    final ApiResponse response = await ApiCaller.getRequest(
      url: urls.getTaskListUrl('New'),
    );
    if (response.isSuccess) {
      List<GetTaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(GetTaskModel.fromjson(jsonData));
      }
      _newTask = list;
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response.errorMsg.toString())));
    }
    _newTaskInProgress = false;
    setState(() {
    });
  }
}

class count_task_status_widget extends StatelessWidget {
  const count_task_status_widget({
    super.key,
    required bool taskStatusCountInProgress,
    required List<TaskStatusModel> taskCount,
  }) : _taskStatusCountInProgress = taskStatusCountInProgress, _taskCount = taskCount;

  final bool _taskStatusCountInProgress;
  final List<TaskStatusModel> _taskCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: CountWidget(taskCount: _taskCount),
    );
  }
}

