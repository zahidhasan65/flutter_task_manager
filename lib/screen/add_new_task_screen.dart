
import 'package:flutter/material.dart';

import '../widgets/app_bar_widget.dart';


class AddNewTaskScreen extends StatefulWidget {
  AddNewTaskScreen({super.key});
  static const String name='/AddNewTaskScreen';

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final GlobalKey<FormState>_formkey=GlobalKey<FormState>();

  final TextEditingController _titleTEcontroller=TextEditingController();
  final TextEditingController _dsicriptionTEcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Add New Task',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  ),

                  SizedBox(height: 16),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _titleTEcontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)
                      ),
                        labelText: 'Title',
                        hintText: 'Add a title here.'
                    ),
                  ), SizedBox(height: 16),
                  TextFormField(
                    maxLines: 7,
                    textInputAction: TextInputAction.next,
                    controller: _dsicriptionTEcontroller,
                    decoration: InputDecoration(
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)
                      ),

                        labelText: 'Discription',
                        hintText: 'Add discription here.'
                    ),
                  ), SizedBox(height: 16),
                  ElevatedButton(onPressed: () {

                  }, child: Text("Submit")),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _titleTEcontroller.dispose();
    _dsicriptionTEcontroller.dispose();

    super.dispose();
  }

}
