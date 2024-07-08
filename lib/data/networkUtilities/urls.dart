class Urls{

  static const String _baseurl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$_baseurl/registration';
  static const String login = '$_baseurl/login';
  static const String createTask = '$_baseurl/createTask';
  static const String addNewTask = '$_baseurl/listTaskByStatus/New';
  static const String addCompletedTask = '$_baseurl/listTaskByStatus/Completed';
  static const String taskStatusCount = '$_baseurl/taskStatusCount';

  static String deleteItem(String id) => '$_baseurl/deleteTask/$id';
  static String editItem(String id,String status) => '$_baseurl/updateTaskStatus/$id/$status';




}