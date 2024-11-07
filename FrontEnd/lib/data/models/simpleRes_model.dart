class SimpleResModel {
  final int errCode;
  final String message;

  SimpleResModel({required this.errCode, required this.message});

  factory SimpleResModel.fromJson(Map<String, dynamic> json) {
    return SimpleResModel(
      errCode: json['errCode'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'errCode': errCode,
      'message': message,
    };
  }
}
