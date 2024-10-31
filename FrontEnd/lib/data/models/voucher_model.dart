// lib/data/models/task_model.dart

import '../../domain/entities/voucher.dart';

class VoucherModel extends Voucher {
  VoucherModel({
    required int id,
    required String? image,
    required String content,
    required String header,
    required String applyTasks,
    required int RpointCost,
    required String value,
    required bool isInfinity,
    required int quantity,
    required DateTime startDate,
    required DateTime endDate,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          image: image ?? '',
          content: content,
          header: header,
          applyTasks: applyTasks,
          RpointCost: RpointCost,
          value: value,
          isInfinity: isInfinity,
          quantity: quantity,
          startDate: startDate,
          endDate: endDate,
          createdAt: createdAt,
          updatedAt: updatedAt,
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
