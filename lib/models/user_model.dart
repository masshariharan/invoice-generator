class UserModel {
  final String name;
  final String email;
  final String userid;

  UserModel({required this.name, required this.email, required this.userid});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'userid': userid,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      userid: map['userid'] ?? '',
    );
  }
}
