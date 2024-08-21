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



class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {

  bool _getCancelledTaskInprogress = false;

  List<TaskModel> CancelledTaskList=[];


  @override
  void initState() {

    super.initState();
    _getCancelledTaskList();
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
                  _getCancelledTaskList();
                },
                child: Visibility(
                  visible: _getCancelledTaskInprogress ==false,
                  replacement: const CenterProgressIndicator(),
                  child: ListView.builder(
                      itemCount:CancelledTaskList.length,
                      itemBuilder: (context, index) {
                        return  TaskItem(
                          taskModel: CancelledTaskList[index],
                          onUpdateTask: () {
                            _getCancelledTaskList();

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

  Future<void> _getCancelledTaskList() async {

    _getCancelledTaskInprogress = true;

    if (mounted) {
      setState(() {});
    }

    final  NetworkResponse response =
    await NetWorkCaller.getRequest(Urls.addCancelledTask);

    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {

      TaskListWrapperModel taskListWrapperModel = TaskListWrapperModel.fromJson(response.responseData);
      CancelledTaskList = taskListWrapperModel.taskList ?? [];

    } else {

      if(mounted){
        showSnackBarMessage(
            context,response.erroMessage ?? 'Get Cancelled Task List Failed,Try Again!!');
      }

    }

    _getCancelledTaskInprogress = false;

    if(mounted){
      setState(() {});
    }


  }



}
