import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_project/data/models/network_Response.dart';
import 'package:task_manager_project/data/models/user_model.dart';
import 'package:task_manager_project/data/networkUtilities/urls.dart';
import 'package:task_manager_project/data/network_caller/network_caller.dart';
import 'package:task_manager_project/ui/controllers/auth_controller.dart';
import 'package:task_manager_project/ui/widgets/Profile_App_Bar.dart';
import 'package:task_manager_project/ui/widgets/background_widget.dart';
import 'package:task_manager_project/ui/widgets/center_progress_indicator.dart';
import 'package:task_manager_project/ui/widgets/snackbarMessage.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController emailTEcontroller = TextEditingController();
  final TextEditingController firstNameTEcontroller = TextEditingController();
  final TextEditingController lastNameTEcontroller = TextEditingController();
  final TextEditingController mobileTEcontroller = TextEditingController();
  final TextEditingController passwordTEcontroller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  XFile? selectedImage;

  bool updateProfileInProgress= false;

  @override
  void initState() {
    super.initState();

    final UserData = AuthController.userData!;
    emailTEcontroller.text = UserData.email ?? '';
    firstNameTEcontroller.text = UserData.firstName ?? '';
    lastNameTEcontroller.text = UserData.lastName ?? '';
    mobileTEcontroller.text = UserData.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context, true),
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 48),
                  Text('Update Profile',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  buildPhotoPickerWidget(),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: emailTEcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: firstNameTEcontroller,
                    decoration: const InputDecoration(
                      hintText: 'First Name',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: lastNameTEcontroller,
                    decoration: const InputDecoration(
                      hintText: 'Last Name',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: mobileTEcontroller,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: 'Mobile',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: passwordTEcontroller,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: updateProfileInProgress == false,
                    replacement:const CenterProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: () {
                        updateProfile();

                      },
                      child: const Icon(Icons.arrow_forward_outlined),
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

  Widget buildPhotoPickerWidget() {
    return GestureDetector(
      onTap: () {
        profileImagePicker();

      },
      child: Container(
        width: double.maxFinite,
        height: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Container(
              width: 100,
              height: 48,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  color: Colors.grey),
              alignment: Alignment.center,
              child: const Text(
                'Photo',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
                child: Text(
              selectedImage?.name ?? 'No Image Selected',
              maxLines: 1,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ))
          ],
        ),
      ),
    );
  }

  Future<void> profileImagePicker() async {
    final imagePicker = ImagePicker();
    final XFile? result =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (result != null) {
      selectedImage = result;
      if (mounted) {
        setState(() {});
      }
    }
  }


  Future<void> updateProfile()async{
    updateProfileInProgress= true;

    String encodedPhoto = AuthController.userData?.photo ?? '';

    if(mounted){
      setState(() {});
    }

    Map<String,dynamic> requestBody ={
      "email": emailTEcontroller.text ,
      "firstName": firstNameTEcontroller.text.trim() ,
      "lastName":lastNameTEcontroller.text.trim() ,
      "mobile": mobileTEcontroller.text.trim(),

    };


    if(passwordTEcontroller.text.isNotEmpty){
      requestBody['password'] = passwordTEcontroller.text;
    }

    if(selectedImage!= null){
      File file = File(selectedImage!.path);
      encodedPhoto = base64Encode(file.readAsBytesSync());

      requestBody['photo']= encodedPhoto;


    }
    final NetworkResponse response =
    await NetWorkCaller.postRequest(Urls.updateProfile,body: requestBody);
    if(response.isSuccess){
      UserModel userModel = UserModel(
        email: emailTEcontroller.text,
        firstName: firstNameTEcontroller.text,
        lastName: lastNameTEcontroller.text,
        mobile: mobileTEcontroller.text,
        photo: encodedPhoto,

      );

      await AuthController.saveUserData(userModel);

      if(mounted){
        showSnackBarMessage(context,'Profile Updated!!!');
      }

    }else{

      if(mounted){
        showSnackBarMessage(context,
            response.erroMessage ??  'Profile Update Failed,Try Again');
      }


    }


    updateProfileInProgress= false;


    if(mounted){
      setState(() {});
    }





  }
}
