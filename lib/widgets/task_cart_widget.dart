import 'package:flutter/material.dart';
import 'package:task_manager/Data/Services/api_caller.dart';
import 'package:task_manager/Data/models/get_task_model.dart';

import '../utils/urls.dart';

class TaskCartWidget extends StatefulWidget {
  final GetTaskModel taskModel;
 final VoidCallback refreshList;

  const TaskCartWidget({super.key, required this.taskModel, required this.refreshList});

  @override
  State<TaskCartWidget> createState() => _TaskCartWidgetState();
}

class _TaskCartWidgetState extends State<TaskCartWidget> {
  bool _updateTaskStatusInProgress= false;
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
                "Title: ${widget.taskModel.title}",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              ),
              SizedBox(height: 7),
              Text(widget.taskModel.description),
              SizedBox(height: 7),
              Text('Date: ${widget.taskModel.createdDate}'),

              Row(
                children: [
                  Chip(
                    label: Text(
                      widget.taskModel.status,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                  ),
                  Visibility(
                      visible: !_updateTaskStatusInProgress,
                      replacement: CircularProgressIndicator(),
                      child: IconButton(onPressed: _changeTaskStatusDialog, icon: Icon(Icons.edit))),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeTaskStatusDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Change Task Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              ListTile(
                onTap:() {
                  _changeTaskStatus('New');
                },
                title: Text('New'),
                trailing: widget.taskModel.status == 'New'
                    ? Icon(Icons.done)
                    : null,
              ),
              ListTile(
                onTap:() {
                  _changeTaskStatus('Progress');
                },
                title: Text('Progress'),
                trailing: widget.taskModel.status == 'Progress'
                    ? Icon(Icons.done)
                    : null,
              ),
              ListTile(
                onTap:() {
                  _changeTaskStatus(''
                      'Cancelled');
                },
                title: Text('Cancelled'),
                trailing: widget.taskModel.status == 'Cancelled'
                    ? Icon(Icons.done)
                    : null,
              ),
              ListTile(
                onTap:() {
                  _changeTaskStatus('Completed');
                },
                title: Text('Completed'),
                trailing: widget.taskModel.status == 'Completed'
                    ? Icon(Icons.done)
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }
  Future<void>_changeTaskStatus(String status, )async{
    print("ID: ${widget.taskModel.id}");

    Navigator.pop(context);
    if(status==widget.taskModel.status)
      return;
    _updateTaskStatusInProgress= true;
    setState(() {

    });

    final ApiResponse response= await ApiCaller.getRequest(url: urls.updateTaskstatusUrl(widget.taskModel.id,  status));
    if(response.isSuccess){
      widget.refreshList();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Task Status Updated Successfully")));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.errorMsg.toString())));
    }
    _updateTaskStatusInProgress= false;
    setState(() {

    });

    }



}
