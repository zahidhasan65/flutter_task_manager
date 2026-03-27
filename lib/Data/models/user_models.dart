class UserModels {
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;
  String get fullName {
    return '$firstName $lastName';
  }


  UserModels({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
  });

  factory UserModels.fromJson(Map<String,dynamic> jsonData){
    return UserModels(email: jsonData["email"],
        firstName: jsonData["firstName"],
        lastName: jsonData["lastName"],
        mobile: jsonData["mobile"],
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

