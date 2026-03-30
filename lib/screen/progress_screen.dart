import 'package:flutter/material.dart';
import '../Data/Services/api_caller.dart';
import '../Data/models/get_task_model.dart';
import '../utils/urls.dart';
import '../widgets/task_cart_widget.dart';
class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});
  static const String name='/ProgressScreen';

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  bool _progressTaskInProgress = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllProgressTask();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Visibility(
            visible: _progressTaskInProgress==false,
            replacement: Center(
              child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(strokeWidth:5 ,)),
            ),
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount:_progressTask.length ,
              itemBuilder: (context, index) {
                return TaskCartWidget(taskModel: _progressTask[index], refreshList: () {
                  getAllProgressTask();
                }, color: Colors.orange);
              },
              separatorBuilder: (context, index) {
                return SizedBox();
              },
            ),
          ),
    );
  }

  List<GetTaskModel> _progressTask = [];
  Future<void> getAllProgressTask() async {
    _progressTaskInProgress = true;
    setState(() {});
    final ApiResponse response = await ApiCaller.getRequest(
      url: urls.getTaskListUrl("Progress"),
    );
    if (response.isSuccess) {
      List<GetTaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(GetTaskModel.fromjson(jsonData));
      }
      _progressTask = list;
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response.errorMsg.toString())));
    }
   _progressTaskInProgress = false;
    setState(() {
    });
  }
}
