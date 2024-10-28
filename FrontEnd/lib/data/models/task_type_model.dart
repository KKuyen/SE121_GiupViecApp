// lib/data/models/task_model.dart

import 'package:se121_giupviec_app/domain/entities/taskType.dart';

class TaskTypeModel extends TaskType {
  TaskTypeModel({
    required int id,
    required String name,
    required String? avatar,
    required String value,
    required String? description,
    required String? image,
    required double originalPrice,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          name: name,
          avatar: avatar ?? '',
          value: value,
          description: description ?? '',
          image: image ?? '',
          originalPrice: originalPrice,
          createdAt: createdAt,
          updatedAt: updatedAt,
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
