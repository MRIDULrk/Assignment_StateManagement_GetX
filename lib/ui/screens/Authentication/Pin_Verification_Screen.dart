import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_project/data/models/network_Response.dart';
import 'package:task_manager_project/data/networkUtilities/urls.dart';
import 'package:task_manager_project/data/network_caller/network_caller.dart';

import 'package:task_manager_project/ui/utility/app_colors.dart';
import 'package:task_manager_project/ui/widgets/background_widget.dart';
import 'package:task_manager_project/ui/widgets/center_progress_indicator.dart';
import 'package:task_manager_project/ui/widgets/snackbarMessage.dart';

import 'Reset_Password_Screen.dart';
import 'sign_in_screen.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {

  final TextEditingController _pinTEcontroller = TextEditingController();

  bool otpVerificationInProgress = false;

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
                    'Pin Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'A 6 Digit Verification Pin Has Been Sent to Your Email Address.',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 16),
                  buildPinCodeTextField(),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: otpVerificationInProgress==false,
                    replacement: const CenterProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: () {
                        OnTapVerifyInButton();
                      },
                      child: Text('Verify'),
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

  Widget buildPinCodeTextField() {
    return PinCodeTextField(
      length: 6,
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        selectedFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        inactiveColor: Colors.transparent,
        selectedColor: AppColors.themeColor,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      controller: _pinTEcontroller,
      appContext: context,
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

  void OnTapVerifyInButton() {

    verifyOTP(_pinTEcontroller.text.trim());


  }

  Future<void> verifyOTP(String otp) async {

    otpVerificationInProgress = true;


    if (mounted) {
      setState(() {});
    }

    final  NetworkResponse response =
    await NetWorkCaller.getRequest(Urls.recoverVerifyOTP(widget.email, otp));

    otpVerificationInProgress = false;

    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess && response.responseData['status']=='success') {

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  ResetPasswordScreen(email: 'email',otp: otp),
          ));


    } else {

      if(mounted){
        showSnackBarMessage(
            context,response.erroMessage ?? 'Pin Verification Failed,Try Again!!');
      }

    }


  }

}
