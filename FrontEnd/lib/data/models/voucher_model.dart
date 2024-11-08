// lib/data/models/task_model.dart

import '../../domain/entities/voucher.dart';

class VoucherModel extends Voucher {
  VoucherModel({
    required super.id,
    required String? image,
    required super.content,
    required super.header,
    required super.applyTasks,
    required super.RpointCost,
    required super.value,
    required super.isInfinity,
    required super.quantity,
    required super.startDate,
    required super.endDate,
    required super.createdAt,
    required super.updatedAt,
  }) : super(
          image: image ?? '',
        );

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      id: json['id'],
      image: json['image'],
      content: json['content'],
      header: json['header'],
      applyTasks: json['applyTasks'],
      RpointCost: json['RpointCost'],
      value: json['value'],
      isInfinity: json['isInfinity'],
      quantity: json['quantity'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'content': content,
      'header': header,
      'applyTasks': applyTasks,
      'RpointCost': RpointCost,
      'value': value,
      'isInfinity': isInfinity,
      'quantity': quantity,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
