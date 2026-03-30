class UserModels {
  final String? id;
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;
  final String? photo;
  String get fullName {
    return '$firstName $lastName';
  }


  UserModels({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
     this.id,
    this.photo,
  });

  factory UserModels.fromJson(Map<String,dynamic> jsonData){
    return UserModels(email: jsonData["email"]??"",
        firstName: jsonData["firstName"]??"",
        lastName: jsonData["lastName"]??"",
        mobile: jsonData["mobile"]??"",
        id: jsonData['_id']??"",
        photo: jsonData["photo"]??"",
    );
  }
  Map<String,dynamic> toJson(){
    return {
      'email':email,
      'firstName': firstName,
      'lastName':lastName,
      'mobile':mobile
    };
  }
}

