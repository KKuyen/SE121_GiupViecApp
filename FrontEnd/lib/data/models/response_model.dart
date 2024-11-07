import '../../domain/entities/response.dart';

class ResponseModel extends Response {
  ResponseModel({
    required super.message,
    required super.errCode,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      message: json['message'],
      errCode: json['errCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'errCode': errCode,
    };
  }
}
