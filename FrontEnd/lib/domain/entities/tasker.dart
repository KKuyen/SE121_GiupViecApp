class Tasker {
  final int id;
  final String email;
  final String name;
  final String phoneNumber;
  final String role;
  final String? avatar; // Allow null
  final DateTime? birthday; // Allow null
  final Object? taskerInfo;

  Tasker({
    required this.id,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.role,
    this.avatar,
    this.birthday,
    this.taskerInfo,
  });
}
