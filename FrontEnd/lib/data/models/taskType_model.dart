import 'package:se121_giupviec_app/domain/entities/taskType.dart';

class TasktypeModel extends TaskType {
  TasktypeModel(
      {required super.id,
      required super.name,
      required super.avatar,
      required super.value,
      required super.description,
      required super.image,
      required super.originalPrice,
      required super.createdAt,
      required super.updatedAt,
      // ignore: avoid_types_as_parameter_names
      required super.addPriceDetails});

  factory TasktypeModel.fromJson(Map<String, dynamic> json) {
    return TasktypeModel(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      value: json['value'],
      description: json['description'],
      image: json['image'],
      originalPrice: json['originalPrice'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      addPriceDetails: json['addPriceDetails'] != null
          ? (json['addPriceDetails'] as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'value': value,
      'description': description,
      'image': image,
      'originalPrice': originalPrice,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'addPriceDetails': addPriceDetails
    };
  }
}
