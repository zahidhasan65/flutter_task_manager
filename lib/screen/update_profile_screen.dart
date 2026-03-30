
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/Data/Services/api_caller.dart';
import 'package:task_manager/Data/models/user_models.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/utils/validator.dart';

import 'package:task_manager/widgets/app_bar_widget.dart';
import '../utils/urls.dart';
import '../widgets/image_piker_widget.dart';
import 'main_screen.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});
  static const String name='/UpdateProfile()';


  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailTEcontroller = TextEditingController();
  final TextEditingController _fstnameTEcontroller = TextEditingController();
  final TextEditingController _lstnameTEcontroller = TextEditingController();
  final TextEditingController _phoneTEcontroller = TextEditingController();
  final TextEditingController _passwordTEcontroller = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
 XFile? _selectedImage;
  bool _updateUderDataInProgress=false;
  Future<void> _pickImage() async {
    XFile? profileImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (profileImage != null) {

      setState(() { _selectedImage = profileImage;});
    }
  }
  @override
  void initState() {
    super.initState();
    _emailTEcontroller.text=AuthController.userModel!.email;
    _fstnameTEcontroller.text=AuthController.userModel!.firstName;
    _lstnameTEcontroller.text=AuthController.userModel!.lastName;
    _phoneTEcontroller.text=AuthController.userModel!.mobile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(updateScreen: true,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode:AutovalidateMode.onUserInteraction,
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Text(
                    'Update Your Profile',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: _pickImage,
                    child: ImagePiker(imageName: _selectedImage?.name,),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    enabled: false,
                    textInputAction: TextInputAction.next,
                    controller: _emailTEcontroller,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'example@gmail.com',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    validator: Validator.firstName,
                    textInputAction: TextInputAction.next,
                    controller: _fstnameTEcontroller,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      hintText: 'Zahid',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    validator: Validator.lastName,
                    textInputAction: TextInputAction.next,
                    controller: _lstnameTEcontroller,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      hintText: 'Hasan',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(validator: Validator.phone,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    controller: _phoneTEcontroller,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      hintText: '0174971......',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    validator: (value){
                      if(value != null && value.isNotEmpty&& value.length<6 ){
                        return 'Enter a valid password';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    controller: _passwordTEcontroller,
                    decoration: InputDecoration(
                      labelText: 'Password(Optional)',
                      hintText: '********',
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _onTapUpdatedButton();
                     Navigator.pop(context, true);
                    },
                    child: Text("Update"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void  _onTapUpdatedButton(){
    if(_formkey.currentState!.validate()){
      updateUserData();

    }

  }
  Future<void>updateUserData()async{
    _updateUderDataInProgress=true;
    Map<String,dynamic>updateRequestData={
      "email":_emailTEcontroller.text,
      "firstName":_fstnameTEcontroller.text.trim(),
      "lastName":_lstnameTEcontroller.text.trim(),
      "mobile":_phoneTEcontroller.text.trim(),
    };
    if(_passwordTEcontroller.text.isNotEmpty){
      updateRequestData["password"]=_passwordTEcontroller.text;
  };
    if(_selectedImage!=null){
      final bytes=await _selectedImage!.readAsBytes();
      updateRequestData["photo"]=base64Encode(bytes);
    };
    final ApiResponse response=await ApiCaller.postRequest(url: urls.updateUserDataUrl, body: updateRequestData);
    if(response.isSuccess){
     final ApiResponse updatedresponse=await ApiCaller.getRequest(url: urls.profileDetailsUrl);
     final updatedUserData=updatedresponse.responseData['data'][0];
     await AuthController.saveUserData(UserModels.fromJson(updatedUserData), AuthController.userToken!);

    }

  }

  @override
  void dispose() {
    _emailTEcontroller.dispose();
    _passwordTEcontroller.dispose();
    _fstnameTEcontroller.dispose();
    _lstnameTEcontroller.dispose();
    _phoneTEcontroller.dispose();
    super.dispose();
  }
}
