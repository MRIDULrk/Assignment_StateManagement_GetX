import 'package:get/get.dart';
import 'package:task_manager_project/ui/controllers/New_Task_Controller.dart';
import 'package:task_manager_project/ui/controllers/sign_in_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> SignInController());
    Get.lazyPut(()=> NewTaskController());
  }
}