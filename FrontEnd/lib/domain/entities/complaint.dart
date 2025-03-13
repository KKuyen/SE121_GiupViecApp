class Complaint {
  final int id;
  final int taskId;
  final String type;
  final String status;
  final String description;
  final int customerId;
  final int taskerId;

  Complaint({
    required this.id,
    required this.taskId,
    required this.type,
    required this.status,
    required this.description,
    required this.customerId,
    required this.taskerId,
  });
}
