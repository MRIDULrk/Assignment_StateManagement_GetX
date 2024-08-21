import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/data/models/network_Response.dart';

import 'package:task_manager_project/data/models/taskModel.dart';
import 'package:task_manager_project/data/models/task_count_by_status_model.dart';
import 'package:task_manager_project/data/models/task_count_by_status_wrapper_model.dart';
import 'package:task_manager_project/data/networkUtilities/urls.dart';
import 'package:task_manager_project/data/network_caller/network_caller.dart';
import 'package:task_manager_project/ui/controllers/New_Task_Controller.dart';
import 'package:task_manager_project/ui/screens/Task_Screen/Add_New%20Task_Screen.dart';
import 'package:task_manager_project/ui/utility/app_colors.dart';
import 'package:task_manager_project/ui/widgets/Profile_App_Bar.dart';
import 'package:task_manager_project/ui/widgets/Task_Item.dart';
import 'package:task_manager_project/ui/widgets/Task_Summary_Card.dart';
import 'package:task_manager_project/ui/widgets/center_progress_indicator.dart';
import 'package:task_manager_project/ui/widgets/snackbarMessage.dart';


class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

 bool _TaskCountInProgress = false;

  List<TaskCountByStatusModel> taskCountList =[];

  @override
  void initState() {

    super.initState();
    _initialCall();
  }


  void _initialCall(){

    _taskCount();
    Get.find<NewTaskController>().getNewTaskList();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 8,left: 8,right: 8),
        child: Column(
          children: [
            buildSummarySection(),
            const SizedBox(height: 10),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _initialCall();

                },
                child: GetBuilder<NewTaskController>(
                  builder: (newTaskController) {
                    return Visibility(
                      visible: newTaskController.getNewTaskInprogress == false,
                      replacement: const CenterProgressIndicator(),
                      child: ListView.builder(
                          itemCount: newTaskController.newTaskList.length,
                          itemBuilder: (context, index) {
                            return TaskItem(
                              taskModel: newTaskController.newTaskList[index],
                              onUpdateTask: () {
                                _initialCall();
                              },
                            );
                          }),
                    );
                  }
                ),
              ),
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        onPressed: () {
          _onTapAddButton();
        },
        child: const Icon(Icons.add),
      ),

    );
  }

  void _onTapAddButton(){
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddNewTaskScreen(),
        ));
  }


  Widget buildSummarySection() {
    return  SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: taskCountList.map((e){
          return TaskSummaryCard(
              title: e.sId ?? 'UnDefined',
              count: e.sum.toString(),
          );
        }).toList(),
      ),
    );
  }

  Future<void> _taskCount() async {

    _TaskCountInProgress = true;

    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
    await NetWorkCaller.getRequest(Urls.taskStatusCount);

    if(mounted){
      setState(() {});
    }


    if (response.isSuccess) {

      TaskCountByStatusWrapperModel taskCountByStatusWrapperModel = TaskCountByStatusWrapperModel.fromJson(response.responseData);
      taskCountList = taskCountByStatusWrapperModel.taskCountByStatusList?? [];


    } else {

      if(mounted){
        showSnackBarMessage(
            context,response.erroMessage ?? 'Task Counter Failed,Try Again!!');
      }

    }

    _TaskCountInProgress = false;

    if(mounted){
      setState(() {});
    }


  }

}


