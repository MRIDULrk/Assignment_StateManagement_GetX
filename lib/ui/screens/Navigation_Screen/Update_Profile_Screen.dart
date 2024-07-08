import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/widgets/Profile_App_Bar.dart';
import 'package:task_manager_project/ui/widgets/background_widget.dart';

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

                  ElevatedButton(
                    onPressed: () {},
                    child: const Icon(Icons.arrow_forward_outlined),
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
    return Container(
      width: double.maxFinite,
      height: 48,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      alignment: Alignment.centerLeft,
      child: Container(
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
              fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
