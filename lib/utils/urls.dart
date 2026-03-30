class urls {
  static final String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static final String registrationUrl = '$_baseUrl/registration';
  static final String loginUrl = '$_baseUrl/login';
  static final String addNewTaskUrl = '$_baseUrl/createTask';
  static final String taskStatusCountUrl = '$_baseUrl/taskStatusCount';
  static final String updateUserDataUrl = '$_baseUrl/profileUpdate';
  static final String profileDetailsUrl = '$_baseUrl/profileDetails';
  static  String deleteTaskUrl(String id) => '$_baseUrl/deleteTask/$id';
  static   String getTaskListUrl( String status) => '$_baseUrl/listTaskByStatus/$status';
  static   String updateTaskstatusUrl(String id, String status) => '$_baseUrl/updateTaskStatus/$id/$status';
  static   String forgotPassUrl(String email) => '$_baseUrl/RecoverVerifyEmail/$email';





}