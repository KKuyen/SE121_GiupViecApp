import '../../domain/entities/response.dart';

class ResponseModel extends Response {
  ResponseModel({
    required String message,
    required int errCode,
  }) : super(
          message: message,
          errCode: errCode,
        );

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
