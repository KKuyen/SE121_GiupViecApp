import 'package:se121_giupviec_app/domain/entities/tasker.dart';

class TaskerModel extends Tasker {
  TaskerModel({
    required int id,
    required String email,
    required String name,
    required String phoneNumber,
    required String role,
    required String? avatar,
    required DateTime? birthday,
    required Object? taskerInfo,
  }) : super(
          id: id,
          email: email,
          name: name,
          phoneNumber: phoneNumber,
          role: role,
          avatar: avatar,
          birthday: birthday,
          taskerInfo: taskerInfo,
        );

  factory TaskerModel.fromJson(Map<String, dynamic> json) {
    return TaskerModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      role: json['role'],
      avatar: json['avatar'],
      birthday:
          json['birthday'] != null ? DateTime.parse(json['birthday']) : null,
      taskerInfo: json['taskerInfo'],
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
      'taskerInfo': taskerInfo,
    };
  }
}
