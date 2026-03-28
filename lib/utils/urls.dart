class urls {
  static final String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static final String registrationUrl = '$_baseUrl/registration';
  static final String loginUrl = '$_baseUrl/login';
  static final String addNewTaskUrl = '$_baseUrl/createTask';
  static final String taskStatusCountUrl = '$_baseUrl/taskStatusCount';
  static final String  newTaskListUrl = '$_baseUrl/listTaskByStatus/New';
  static final String  progressTaskListUrl = '$_baseUrl/listTaskByStatus/Progress';
  static final String  cancellTaskListUrl = '$_baseUrl/listTaskByStatus/Cancelled';
  static final String  completedTaskListUrl = '$_baseUrl/listTaskByStatus/Completed';
  static   String updateTaskstatusUrl(String id, String status) => '$_baseUrl/updateTaskStatus/$id/$status';

}