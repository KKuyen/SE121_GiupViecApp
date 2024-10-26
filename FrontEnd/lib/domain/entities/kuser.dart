// lib/domain/entities/user.dart
class KUser {
  final int id;
  final String email;
  final String name;
  final String phoneNumber;
  final String role;
  final String avatar;
  final DateTime? birthday;
  final int rpoints;

  KUser({
    required this.id,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.role,
    required this.avatar,
    this.birthday,
    required this.rpoints,
  });
}
