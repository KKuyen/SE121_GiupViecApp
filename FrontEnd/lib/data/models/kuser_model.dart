// lib/data/models/user_model.dart
import 'package:se121_giupviec_app/domain/entities/kuser.dart';

import '../../domain/entities/user.dart';

class KuserModel extends KUser {
  KuserModel({
    required int id,
    required String email,
    required String name,
    required String phoneNumber,
    required String role,
    required String avatar,
    required DateTime? birthday,
    required int rpoints,
  }) : super(
          id: id,
          email: email,
          name: name,
          phoneNumber: phoneNumber,
          role: role,
          avatar: avatar,
          birthday: birthday,
          rpoints: rpoints,
        );

  factory KuserModel.fromJson(Map<String, dynamic> json) {
    return KuserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      role: json['role'],
      avatar: json['avatar'],
      birthday:
          json['birthday'] != null ? DateTime.parse(json['birthday']) : null,
      rpoints: json['rpoints'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'role': role,
      'avatar': avatar,
      'birthday': birthday?.toIso8601String(),
      'rpoints': rpoints,
    };
  }
}
