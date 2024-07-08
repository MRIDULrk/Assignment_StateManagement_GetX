import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_project/ui/controllers/auth_controller.dart';
import 'package:task_manager_project/ui/screens/Authentication/sign_in_screen.dart';
import 'package:task_manager_project/ui/screens/Navigation_Screen/Main_Bottom_Nav_Screen.dart';

import 'package:task_manager_project/ui/utility/asset_paths.dart';
import 'package:task_manager_project/ui/widgets/background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    _moveToNext();

  }

  Future<void> _moveToNext() async {
    await Future.delayed(const Duration(seconds: 4));

    bool isUserLoggedIn = await AuthController.checkAuthState();

    if(mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => isUserLoggedIn? const MainBottomNavScreen() : const SignInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundWidget(
        child: Center(
          child: SvgPicture.asset(
        AssetsPath.appLogoSVG,
        width: 140,
      )),
    ));
  }
}
