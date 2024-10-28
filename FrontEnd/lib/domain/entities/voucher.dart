class Voucher {
  final int id;
  final String? image;
  final String content;
  final String header;
  final String applyTasks;
  final int RpointCost;
  final String value;
  final bool isInfinity;
  final int quantity;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  Voucher({
    required this.id,
    required this.image,
    required this.content,
    required this.header,
    required this.applyTasks,
    required this.RpointCost,
    required this.value,
    required this.isInfinity,
    required this.quantity,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
  });
}
