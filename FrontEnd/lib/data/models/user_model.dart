import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    // required int id,
    // required String name,
    // required String email,
    // required String phoneNumber,
    required dynamic access_token,
    required String message,
    required Object user,
    required int errCode,
  }) : super(
          // id: id,
          // name: name,
          // email: email,
          // phoneNumber: phoneNumber,
          access_token: access_token,
          message: message,
          user: user,
          errCode: errCode,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      // id: json['id'],
      // name: json['name'],
      // email: json['email'],
      // phoneNumber: json['phoneNumber'],
      access_token: json['access_token'],
      message: json['message'],
      user: json['user'],
      errCode: json['errCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      // 'name': name,
      // 'email': email,
      // 'phoneNumber': phoneNumber,
      'access_token': access_token,
      'message': message,
      'user': user,
      'errCode': errCode,
    };
  }
}
