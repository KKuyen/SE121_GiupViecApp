// lib/data/models/task_model.dart

import 'package:se121_giupviec_app/domain/entities/taskType.dart';

class TaskTypeModel extends TaskType {
  TaskTypeModel({
    required super.id,
    required super.name,
    required String? avatar,
    required super.value,
    required String? description,
    required String? image,
    required super.originalPrice,
    required super.createdAt,
    required super.updatedAt,
  }) : super(
          avatar: avatar ?? '',
          description: description ?? '',
          image: image ?? '',
        );

  factory TaskTypeModel.fromJson(Map<String, dynamic> json) {
    return TaskTypeModel(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      value: json['value'],
      description: json['description'],
      image: json['image'],
      originalPrice: json['originalPrice'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
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
    };
  }
}
