import 'package:movies/features/auth/domain/entity/user_entity.dart';

class UserDataModel extends UserEntity {
  UserDataModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }
}
