import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/widgets/Profile_App_Bar.dart';
import 'package:task_manager_project/ui/widgets/Task_Item.dart';



class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 8,left: 8,right: 8),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                   // return const TaskItem();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
