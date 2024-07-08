import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/screens/Authentication/splash_screen.dart';
import 'package:task_manager_project/ui/utility/app_colors.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});


  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: TaskManagerApp.navigatorKey,
      home: const SplashScreen(),
      theme: LightThemeData(),

    );
  }

  ThemeData LightThemeData(){
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,

        hintStyle: TextStyle(
          color: AppColors.hintTextColor,
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide.none
        ),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),

          titleSmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          )


      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.themeColor,
          padding: const EdgeInsets.symmetric(vertical: 12),
          foregroundColor: AppColors.white,
          fixedSize: const Size.fromWidth(double.maxFinite),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )

        ),
      ),

    );
  }
}
