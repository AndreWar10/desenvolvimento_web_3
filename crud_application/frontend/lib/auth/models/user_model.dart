class UserModel {
  final String id;
  final String name;
  final String email;
  final String type;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
  });

  factory UserModel.fromJson(Map json) {
    return UserModel(
      id: json['uid'],
      name: json['displayName'],
      email: json['email'],
      type: json['levelAccess'],
    );
  }
}