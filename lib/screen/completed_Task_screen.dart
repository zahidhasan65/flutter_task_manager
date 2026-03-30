import 'package:flutter/material.dart';
import '../Data/Services/api_caller.dart';
import '../Data/models/get_task_model.dart';
import '../utils/urls.dart';
import '../widgets/task_cart_widget.dart';
class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});
  static const String name='/CompletedTaskScreen';

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _completedTaskInProgress = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCompletedTask();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Visibility(
        visible: _completedTaskInProgress==false,
        replacement: Center(
          child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(strokeWidth:5 ,)),
        ),
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemCount:_completedTask.length ,
          itemBuilder: (context, index) {
            return TaskCartWidget(taskModel: _completedTask[index], refreshList: () {
              getAllCompletedTask();
            },color: Colors.green);
          },
          separatorBuilder: (context, index) {
            return SizedBox();
          },
        ),
      ),
    );
  }

  List<GetTaskModel> _completedTask = [];
  Future<void> getAllCompletedTask() async {
    _completedTaskInProgress= true;
    setState(() {});
    final ApiResponse response = await ApiCaller.getRequest(
      url: urls.getTaskListUrl('Completed'),
    );
    if (response.isSuccess) {
      List<GetTaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(GetTaskModel.fromjson(jsonData));
      }
      _completedTask = list;
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response.errorMsg.toString())));
    }
    _completedTaskInProgress= false;
    setState(() {
    });
  }
}
