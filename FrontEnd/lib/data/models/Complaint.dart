import 'package:se121_giupviec_app/domain/entities/complaint.dart';

class ComplaintModel extends Complaint {
  ComplaintModel({
    required super.id,
    required super.taskId,
    required super.type,
    required super.status,
    required super.description,
    required super.customerId,
    required super.taskerId,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'],
      taskId: json['taskId'],
      type: json['type'],
      status: json['status'],
      description: json['description'],
      customerId: json['customerId'],
      taskerId: json['taskerId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskId': taskId,
      'type': type,
      'status': status,
      'description': description,
      'customerId': customerId,
      'taskerId': taskerId,
    };
  }
}
