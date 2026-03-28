import 'package:flutter/material.dart';
import '../Data/Services/api_caller.dart';
import '../Data/models/get_task_model.dart';
import '../utils/urls.dart';
import '../widgets/task_cart_widget.dart';
class CancelledScreen extends StatefulWidget {
  const CancelledScreen({super.key});
  static const String name='/CancelledScreen';

  @override
  State<CancelledScreen> createState() => _CancelledScreenState();
}

class _CancelledScreenState extends State<CancelledScreen> {
  bool _cancellTaskInProgress = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCancellTask();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Visibility(
        visible: _cancellTaskInProgress==false,
        replacement: Center(
          child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(strokeWidth:5 ,)),
        ),
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemCount:_cancellTask.length ,
          itemBuilder: (context, index) {
            return TaskCartWidget(taskModel: _cancellTask[index], refreshList: () {
              getAllCancellTask();
            },);
          },
          separatorBuilder: (context, index) {
            return SizedBox();
          },
        ),
      ),
    );
  }

  List<GetTaskModel> _cancellTask = [];
  Future<void> getAllCancellTask() async {
    _cancellTaskInProgress= true;
    setState(() {});
    final ApiResponse response = await ApiCaller.getRequest(
      url: urls.cancellTaskListUrl,
    );
    if (response.isSuccess) {
      List<GetTaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(GetTaskModel.fromjson(jsonData));
      }
      _cancellTask = list;
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response.errorMsg.toString())));
    }
    _cancellTaskInProgress = false;
    setState(() {
    });
  }
}
