import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/utility/app_colors.dart';
import 'package:task_manager_project/ui/widgets/background_widget.dart';

import 'Pin_Verification_Screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEcontroller = TextEditingController();

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
                    'Your Email Address',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'A 6 Digit Verification Pin Will be Sent to Your Email Address.',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailTEcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {

                      OnTapConfirmationButton();

                    },
                    child: Icon(Icons.arrow_circle_right_rounded),
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
    Navigator.pop(context);
  }

  void OnTapConfirmationButton() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PinVerificationScreen(),
        ));
  }

  @override
  void dispose() {
    _emailTEcontroller.dispose();

    super.dispose();
  }
}
