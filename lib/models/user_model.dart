class UserModel {
  late String name;
  late String email;
  late String uId;

  UserModel({
    required this.email,
    required this.name,
    required this.uId,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    uId = json['uId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
    };
  }
}