import 'package:get/get.dart';
import 'package:task_manager_project/data/models/login_model.dart';
import 'package:task_manager_project/data/models/network_Response.dart';
import 'package:task_manager_project/data/networkUtilities/urls.dart';
import 'package:task_manager_project/data/network_caller/network_caller.dart';
import 'package:task_manager_project/ui/controllers/auth_controller.dart';

class SignInController extends GetxController{

  bool isSuccess = false;

  bool _inProgressSignIn = false;
  String _errorMassage = '';

  bool get inProgressSignIn => _inProgressSignIn;
  String get errorMassage => _errorMassage;


  Future<bool> signIn(String email, String password) async {

    _inProgressSignIn = true;

    update();

    Map<String, dynamic> requestInput = {

      "email": email,
      "password": password,

    };

    final  NetworkResponse response =
    await NetWorkCaller.postRequest(Urls.login,body:requestInput);

    if (response.isSuccess) {

      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveUserAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.userModel!);


    } else {

      _errorMassage =response.erroMessage ?? 'Invalid Credentials!!,Try Again';

    }

    _inProgressSignIn = false;
    update();

    return isSuccess;
  }




}