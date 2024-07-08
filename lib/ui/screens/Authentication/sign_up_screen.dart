import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/network_Response.dart';
import 'package:task_manager_project/data/networkUtilities/urls.dart';
import 'package:task_manager_project/data/network_caller/network_caller.dart';
import 'package:task_manager_project/ui/utility/app_colors.dart';
import 'package:task_manager_project/ui/utility/app_constants.dart';
import 'package:task_manager_project/ui/widgets/background_widget.dart';
import 'package:task_manager_project/ui/widgets/snackbarMessage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEcontroller = TextEditingController();
  final TextEditingController _FirstNameTEcontroller = TextEditingController();
  final TextEditingController _LastNameTEcontroller = TextEditingController();
  final TextEditingController _MobileTEcontroller = TextEditingController();
  final TextEditingController _passwordTEcontroller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _showPassword = false;
  bool _inProgressRegistration = false;

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
                      'Join With Us',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailTEcontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: 'Email'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Your Email.';
                        }

                        if (AppConstants.emailRegExp.hasMatch(value!) ==
                            false) {
                          return 'Enter a valid email address';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _FirstNameTEcontroller,
                      decoration: InputDecoration(
                        hintText: 'First Name',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Your First Name.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _LastNameTEcontroller,
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Your Last Name.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _MobileTEcontroller,
                      keyboardType: TextInputType.number,
                      decoration:  InputDecoration(
                        hintText: 'Mobile',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Your Mobile.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordTEcontroller,
                      obscureText: !_showPassword,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              _showPassword = !_showPassword;

                              if (mounted) {
                                setState(() {});
                              }
                            },
                            icon: Icon(_showPassword
                                ? Icons.remove_red_eye
                                : Icons.visibility_off),
                          )),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Your Password.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    Visibility(

                      visible: _inProgressRegistration==false,
                      replacement: Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {

                            _regesterUser();

                          }
                        },
                        child: Icon(Icons.arrow_circle_right_rounded),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: buildBackToSignInMethod(),
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

  RichText buildBackToSignInMethod() {
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

  Future<void> _regesterUser() async {
    _inProgressRegistration = true;

    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> requestInput = {
      "email": _emailTEcontroller.text.trim(),
      "firstName": _FirstNameTEcontroller.text.trim(),
      "lastName": _LastNameTEcontroller.text.trim(),
      "mobile": _MobileTEcontroller.text.trim(),
      "password": _passwordTEcontroller.text,
      "photo": ""
    };

    NetworkResponse response =
        await NetWorkCaller.postRequest(Urls.registration, body: requestInput);

       _inProgressRegistration=false;

    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      clearTextField();

      if (mounted) {
        showSnackBarMessage(context, 'Registration Successfull');
      }
    } else {

      if(mounted){
        showSnackBarMessage(
            context, response.erroMessage ?? 'Registration Failed');
      }

    }
  }

  void clearTextField() {
    _emailTEcontroller.clear();
    _FirstNameTEcontroller.clear();
    _LastNameTEcontroller.clear();
    _MobileTEcontroller.clear();
    _passwordTEcontroller.clear();
  }

  void OnTapSignInButton() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailTEcontroller.dispose();
    _FirstNameTEcontroller.dispose();
    _LastNameTEcontroller.dispose();
    _MobileTEcontroller.dispose();
    _passwordTEcontroller.dispose();
    super.dispose();
  }
}
