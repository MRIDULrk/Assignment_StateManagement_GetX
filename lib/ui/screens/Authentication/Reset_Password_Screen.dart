import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/network_Response.dart';
import 'package:task_manager_project/data/networkUtilities/urls.dart';
import 'package:task_manager_project/data/network_caller/network_caller.dart';
import 'package:task_manager_project/ui/screens/Authentication/sign_in_screen.dart';
import 'package:task_manager_project/ui/utility/app_colors.dart';
import 'package:task_manager_project/ui/widgets/background_widget.dart';
import 'package:task_manager_project/ui/widgets/center_progress_indicator.dart';
import 'package:task_manager_project/ui/widgets/snackbarMessage.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  State<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  bool resetPasswordInProgress = false;


  final TextEditingController _PasswordlTEcontroller = TextEditingController();
  final TextEditingController _ConfirmPasswordlTEcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 120),
                  Text(
                    'Set Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Minimum length password 8 character with letter and number combination.',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _PasswordlTEcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _ConfirmPasswordlTEcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration:const InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                  ),



                  const SizedBox(height: 16),

                  Visibility(
                    visible: resetPasswordInProgress == false,
                    replacement:const CenterProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: () {

                        if(_PasswordlTEcontroller.text == _ConfirmPasswordlTEcontroller.text){

                          resetPassword(_PasswordlTEcontroller.text);

                        }else {

                          if(mounted){
                            showSnackBarMessage(
                                context,'Password Mismatched,Try Again!!');
                          }

                          setState(() {});
                        }

                      },
                      child:const Text('Confirm'),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: buildSignInButtonMethod(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  RichText buildSignInButtonMethod() {
    return RichText(
      text: TextSpan(
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w600,
            fontSize: 16,
            letterSpacing: 0.4,
          ),
          text: 'Have Account? ',
          children: [
            TextSpan(
                text: 'Sign In',
                style: TextStyle(color: AppColors.themeColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    OnTapSignInButton();
                  }),
          ]),
    );
  }

  void OnTapSignInButton() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
            (route) => false);
  }


  Future<void> resetPassword(String password) async {

    resetPasswordInProgress = true;

    if (mounted) {
      setState(() {});
    }

    Map<String,dynamic> inputParams ={
      "email": widget.email,
      "OTP": widget.otp,
      "password": password,
    };


    final  NetworkResponse response =
    await NetWorkCaller.postRequest(Urls.recoverResetPass,body: inputParams);

    resetPasswordInProgress = false;

    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {

      if(mounted){
        showSnackBarMessage(
            context,'Password Reset Successful!!');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SignInScreen()),
                (route) => false);
      }

    } else {

      if(mounted){
        showSnackBarMessage(
            context,'Password Reset Failed,Try Again!!');
      }

    }


  }

}
