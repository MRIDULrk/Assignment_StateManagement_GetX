import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/network_Response.dart';
import 'package:task_manager_project/data/models/taskListWrapperModel.dart';
import 'package:task_manager_project/data/models/taskModel.dart';
import 'package:task_manager_project/data/networkUtilities/urls.dart';
import 'package:task_manager_project/data/network_caller/network_caller.dart';
import 'package:task_manager_project/ui/widgets/Profile_App_Bar.dart';
import 'package:task_manager_project/ui/widgets/Task_Item.dart';
import 'package:task_manager_project/ui/widgets/center_progress_indicator.dart';
import 'package:task_manager_project/ui/widgets/snackbarMessage.dart';



class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {

  bool _getProgressTaskInprogress = false;

  List<TaskModel> ProgressTaskList =[];


  @override
  void initState() {

    super.initState();
    _getProgressTaskList();
  }


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
              child: RefreshIndicator(
                onRefresh: ()async{
                  _getProgressTaskList();
                },
                child: Visibility(
                  visible: _getProgressTaskInprogress == false,
                  replacement: const CenterProgressIndicator(),

                  child: ListView.builder(
                    itemCount:ProgressTaskList.length,
                    itemBuilder: (context, index) {
                    return  TaskItem(
                    taskModel: ProgressTaskList[index],
                    onUpdateTask: () {
                      _getProgressTaskList();

                  },
                  );
                  }
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Future<void> _getProgressTaskList() async {

    _getProgressTaskInprogress = true;

    if (mounted) {
      setState(() {});
    }

    final  NetworkResponse response =
    await NetWorkCaller.getRequest(Urls.addProgressTask);

    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {

      TaskListWrapperModel taskListWrapperModel = TaskListWrapperModel.fromJson(response.responseData);
      ProgressTaskList = taskListWrapperModel.taskList ?? [];

    } else {

      if(mounted){
        showSnackBarMessage(
            context,response.erroMessage ?? 'Get Progress Task List Failed,Try Again!!');
      }

    }

    _getProgressTaskInprogress = false;

    if(mounted){
      setState(() {});
    }


  }


}
