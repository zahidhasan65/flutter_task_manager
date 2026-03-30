import 'package:flutter/material.dart';

import '../Data/Services/api_caller.dart';
import '../Data/models/task_status_model.dart';
import '../utils/urls.dart';

class TaskCountController {
  static List<TaskStatusModel> taskCount = [];
  Future<void> getAllTaskCount() async {

    final ApiResponse response = await ApiCaller.getRequest(
      url: urls.taskStatusCountUrl,
    );
    if (response.isSuccess) {
      List<TaskStatusModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskStatusModel.fromjson(jsonData));
      }
      taskCount = list;
    }
  }
}