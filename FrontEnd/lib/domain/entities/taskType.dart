class TaskType {
  final int id;
  final String name;
  final String? avatar;

  final double value;

  final String? description;
  final String? image;
  final int originalPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Object>? addPriceDetails;

  TaskType(
      {required this.id,
      required this.name,
      this.avatar,
      required this.value,
      this.description,
      this.image,
      required this.originalPrice,
      required this.createdAt,
      required this.updatedAt,
      this.addPriceDetails});
}
