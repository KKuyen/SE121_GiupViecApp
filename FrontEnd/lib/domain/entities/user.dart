class User {
  // final int id;
  // final String name;
  // final String email;
  // final String phoneNumber;
  final dynamic access_token;
  final String message;
  final Object? user;
  final int errCode;

  User({
    // required this.id,
    // required this.name,
    // required this.email,
    // required this.phoneNumber,
    required this.access_token,
    required this.message,
    this.user,
    required this.errCode,
  });
}
