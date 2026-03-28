import 'package:flutter/material.dart';
import 'package:task_manager/widgets/task_count_widget.dart';

import '../Data/models/task_status_model.dart';
class CountWidget extends StatelessWidget {
  const CountWidget({
    super.key,
    required List<TaskStatusModel> taskCount,
  }) : _taskCount = taskCount;

  final List<TaskStatusModel> _taskCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: _taskCount.length,
      itemBuilder: (context, index) {
        return Task_Count(value: _taskCount[index].countTask, taskTitle: _taskCount[index].status);
      },
      separatorBuilder: (context, index) {
        return SizedBox();
      },
    );
  }
}
