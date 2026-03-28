
class GetTaskModel {
final String id;
final String title;
final String description;
final String status;
final String createdDate;

  GetTaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdDate});

  factory GetTaskModel.fromjson(Map<String,dynamic>jsonData){
    return GetTaskModel(
        id: jsonData['_id']??'',
        title: jsonData['title']??'',
        description: jsonData['description']??'',
        status: jsonData['status'],
        createdDate: jsonData['createdDate']??''
    );
  }
}