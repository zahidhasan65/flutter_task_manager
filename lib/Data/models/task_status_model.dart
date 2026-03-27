class TaskStatusModel {
  final String status;
  final int countTask;
  TaskStatusModel({
    required this.status,
    required this.countTask
  });
  factory TaskStatusModel.fromjson(Map<String,dynamic> jsonData){
    return TaskStatusModel(status: jsonData['_id'], countTask: jsonData['sum']);
  }
}
