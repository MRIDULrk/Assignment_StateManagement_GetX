import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/controllers/auth_controller.dart';
import 'package:task_manager_project/ui/screens/Authentication/sign_in_screen.dart';
import 'package:task_manager_project/ui/screens/Navigation_Screen/Update_Profile_Screen.dart';

import '../utility/app_colors.dart';
import 'Network_Cached_Image.dart';

AppBar profileAppBar(context, [bool fromUpdateProfile = false]) {
  return AppBar(
    backgroundColor: AppColors.themeColor,
    leading: const Padding(
      padding: EdgeInsets.all(5.0),
      child: CircleAvatar(
        child: NetworkCachedImage(
          url: '',
        ),
      ),
    ),
    title: GestureDetector(
      onTap: () {
        if (fromUpdateProfile == true) {
          return;
        }

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UpdateProfileScreen(),
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AuthController.userData?.fullName ?? '',
            style:const TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            AuthController.userData?.email ?? '',
            style:const TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
          )
        ],
      ),
    ),
    actions: [
      IconButton(
        onPressed: () async{
          AuthController.clearAllData();

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SignInScreen()),
              (route) => false);
        },
        icon: const Icon(Icons.logout),
      )
    ],
  );
}
