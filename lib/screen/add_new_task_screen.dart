import 'package:flutter/material.dart';
import 'package:task_manager/Data/Services/api_caller.dart';
import 'package:task_manager/utils/validator.dart';

import '../utils/urls.dart';
import '../widgets/app_bar_widget.dart';
import 'new_task_screen.dart';

class AddNewTaskScreen extends StatefulWidget {
  AddNewTaskScreen({super.key});
  static const String name = '/AddNewTaskScreen';

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController _titleTEcontroller = TextEditingController();
  final TextEditingController _dsicriptionTEcontroller =
      TextEditingController();
  bool _addTaskInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Add Task',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  ),

                  SizedBox(height: 16),
                  TextFormField(
                    validator: Validator.title,
                    textInputAction: TextInputAction.next,
                    controller: _titleTEcontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      labelText: 'Title',
                      hintText: 'Add a title here.',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    validator: Validator.discription,
                    maxLines: 7,
                    textInputAction: TextInputAction.next,
                    controller: _dsicriptionTEcontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),

                      labelText: 'Discription',
                      hintText: 'Add discription here.',
                    ),
                  ),
                  SizedBox(height: 16),
                  Visibility(
                    visible: _addTaskInProgress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                      onPressed: () {

                        onTapAddButton();

                      },
                      child: Text("Submit"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTapAddButton() {

    if (_formkey.currentState!.validate()) {
      addNewTask();
    }
  }

  Future<void> addNewTask() async {
    _addTaskInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "title": _titleTEcontroller.text.trim(),
      "description": _dsicriptionTEcontroller.text.trim(),
      "status": "New",
    };
    final ApiResponse response = await ApiCaller.postRequest(
      url: urls.addNewTaskUrl,
      body: requestBody,
    );
    if (response.isSuccess) {
      clearTextfield();
      Navigator.pop(context,true);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Somthing Wrong")));
    }
    _addTaskInProgress = false;
    setState(() {});
  }

  void clearTextfield() {
    _titleTEcontroller.clear();
    _dsicriptionTEcontroller.clear();
  }

  @override
  void dispose() {
    _titleTEcontroller.dispose();
    _dsicriptionTEcontroller.dispose();

    super.dispose();
  }
}
