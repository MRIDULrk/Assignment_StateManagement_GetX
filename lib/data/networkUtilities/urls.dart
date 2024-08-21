class Urls{

  static const String _baseurl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$_baseurl/registration';
  static const String login = '$_baseurl/login';
  static const String createTask = '$_baseurl/createTask';
  static const String addNewTask = '$_baseurl/listTaskByStatus/New';
  static const String addCompletedTask = '$_baseurl/listTaskByStatus/Completed';
  static const String addProgressTask = '$_baseurl/listTaskByStatus/Progress';
  static const String addCancelledTask = '$_baseurl/listTaskByStatus/Cancelled';
  static const String taskStatusCount = '$_baseurl/taskStatusCount';
  static String deleteItem(String id) => '$_baseurl/deleteTask/$id';
  static String editItem(String id,String status) => '$_baseurl/updateTaskStatus/$id/$status';
  static const String updateProfile = '$_baseurl/profileUpdate';

  static String recoverVerifyEmail(String email) => '$_baseurl/RecoverVerifyEmail/$email';
  static String recoverVerifyOTP(String email,String otp) => '$_baseurl/RecoverVerifyOTP/$email/$otp';
  static const String recoverResetPass = '$_baseurl/RecoverResetPass';






}