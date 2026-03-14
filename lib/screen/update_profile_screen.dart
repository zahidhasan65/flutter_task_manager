
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:task_manager/widgets/app_bar_widget.dart';
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
  Future<void> _pickImage() async {
    XFile? profileImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (profileImage != null) {

      setState(() { _selectedImage = profileImage;});
    }
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
                    textInputAction: TextInputAction.next,
                    controller: _emailTEcontroller,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'example@gmail.com',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _fstnameTEcontroller,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      hintText: 'Zahid',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _lstnameTEcontroller,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      hintText: 'Hasan',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
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
                    textInputAction: TextInputAction.next,
                    controller: _passwordTEcontroller,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: '********',
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                        (route) => false,
                      );
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
