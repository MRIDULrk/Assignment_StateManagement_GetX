import 'package:flutter/material.dart';

import 'package:task_manager_project/ui/utility/app_colors.dart';

import '../Task_Screen/Cancelled_Task_Screen.dart';
import '../Task_Screen/Completed_Task_Screen.dart';
import '../Task_Screen/In_Progress_Task_Screen.dart';
import '../Task_Screen/New_Task_Screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {

  int _selectedIndex = 0;

  final List<Widget> screens = const
  [
    NewTaskScreen(),
    CompletedTaskScreen(),
    InProgressTaskScreen(),
    CancelledTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: screens[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _selectedIndex,

        onTap: (index){
          _selectedIndex = index;

          if(mounted) {

            setState(() {});

          }


        },
        selectedItemColor: AppColors.themeColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,

        items: const
        [
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'New Task'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Completed'),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'In Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.close), label: 'Cancelled'),
        ],

      ),


    );
  }
}
