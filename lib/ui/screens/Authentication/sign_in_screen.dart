import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/login_model.dart';
import 'package:task_manager_project/data/models/network_Response.dart';
import 'package:task_manager_project/data/networkUtilities/urls.dart';
import 'package:task_manager_project/data/network_caller/network_caller.dart';
import 'package:task_manager_project/ui/controllers/auth_controller.dart';
import 'package:task_manager_project/ui/screens/Authentication/sign_up_screen.dart';
import 'package:task_manager_project/ui/screens/Navigation_Screen/Main_Bottom_Nav_Screen.dart';
import 'package:task_manager_project/ui/utility/app_colors.dart';
import 'package:task_manager_project/ui/utility/app_constants.dart';
import 'package:task_manager_project/ui/widgets/background_widget.dart';
import 'package:task_manager_project/ui/widgets/snackbarMessage.dart';

import 'Email_Verification_Screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEcontroller = TextEditingController();
  final TextEditingController _passwordTEcontroller = TextEditingController();


  bool _inProgressSignIn = false;


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 120),
                    Text(
                      'Get Started With',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _emailTEcontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),

                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Your Email.';
                        }

                        if (AppConstants.emailRegExp.hasMatch(value!) == false) {
                          return 'Enter a valid email address';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 8),

                    TextFormField(
                      controller: _passwordTEcontroller,
                      decoration: const InputDecoration(
                        hintText: 'PassWord'),

                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Your Password.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    Visibility(
                      visible: _inProgressSignIn==false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          onTapNextButton();
                        },
                        child: const Icon(Icons.arrow_circle_right_rounded),
                      ),
                    ),
                    const SizedBox(height: 32),

                    Center(
                      child: Column(
                        children: [
                          TextButton(
                              onPressed: () {
                                onTapForgotPasswordButton();
                              },
                              child: const Text('Forgot Password?')),
                          buildSignUpSection(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignUpSection() {
    return RichText(
      text: TextSpan(
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
          text: 'Do Not Have an Account? ',
          children: [
            TextSpan(
                text: 'Sign Up',
                style: const TextStyle(color: AppColors.themeColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    onTapSignUpButton();
                  }),
          ]),
    );
  }

  void onTapNextButton() {


    if (_formKey.currentState!.validate()) {

      _signIn();

    }

  }

  Future<void> _signIn() async {

    _inProgressSignIn = true;

    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> requestInput = {

      "email": _emailTEcontroller.text.trim(),
      "password": _passwordTEcontroller.text,

    };

   final  NetworkResponse response =
    await NetWorkCaller.postRequest(Urls.login,body:requestInput);

    _inProgressSignIn = false;

    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {

      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveUserAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.userModel!);

      if (mounted) {

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainBottomNavScreen(),
            ));

      }
    } else {

      if(mounted){
        showSnackBarMessage(
            context, response.erroMessage ?? 'Invalid Credentials!!');
      }

    }
  }





  void onTapSignUpButton() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        ));
  }

  void onTapForgotPasswordButton() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EmailVerificationScreen(),
        ));
  }

  @override
  void dispose() {
    _emailTEcontroller.dispose();
    _passwordTEcontroller.dispose();
    super.dispose();
  }
}
