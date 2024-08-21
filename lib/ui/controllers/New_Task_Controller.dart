import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:task_manager_project/data/models/network_Response.dart';
import 'package:task_manager_project/data/models/taskListWrapperModel.dart';
import 'package:task_manager_project/data/models/taskModel.dart';
import 'package:task_manager_project/data/networkUtilities/urls.dart';
import 'package:task_manager_project/data/network_caller/network_caller.dart';

class NewTaskController extends GetxController{

  bool _getNewTaskInprogress = false;

  bool get getNewTaskInprogress =>_getNewTaskInprogress;

  String _errorMassage ='';

  String get errorMassage=> _errorMassage;

  List<TaskModel> _taskList = [];
  List<TaskModel> get newTaskList =>_taskList;


  Future<bool> getNewTaskList() async {

    bool isSuccess = false;

    _getNewTaskInprogress = true;
    update();


    final  NetworkResponse response =
    await NetWorkCaller.getRequest(Urls.addNewTask);


    if (response.isSuccess) {

      TaskListWrapperModel taskListWrapperModel = TaskListWrapperModel.fromJson(response.responseData);
      _taskList = taskListWrapperModel.taskList ?? [];

    } else {

      _errorMassage = response.erroMessage ?? 'Get New Task Failed,Try Again!!';

    }

    _getNewTaskInprogress = false;
    update();

    return isSuccess;

  }

}