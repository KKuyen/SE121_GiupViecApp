import 'package:se121_giupviec_app/domain/entities/task.dart';

class TaskModel extends Task {
  @override
  final Map<String, dynamic>? user; // Allow null
  @override
  final Map<String, dynamic>? location; // Allow null
  @override
  final Map<String, dynamic>? taskType; // Allow null
  @override
  final List<Map<String, dynamic>>? taskerLists; // Allow null

  TaskModel(
      {required super.id,
      required super.userId,
      required super.taskTypeId,
      required super.time,
      required super.locationId,
      super.note,
      super.isReTaskChildren,
      required super.taskStatus,
      required super.createdAt,
      required super.updatedAt,
      super.price,
      this.user,
      this.location,
      this.taskType,
      this.taskerLists,
      super.numberOfTasker,
      super.approvedAt,
      super.cancelAt,
      super.finishedAt,
      super.cancelReason,
      super.isPaid})
      : super(
          location: location,
          user: user,
          taskType: taskType,
          taskerLists: taskerLists,
        );

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      userId: json['userId'],
      taskTypeId: json['taskTypeId'],
      time: DateTime.parse(json['time']),
      locationId: json['locationId'],
      note: json['note'],
      isReTaskChildren: json['isReTaskChildren'],
      taskStatus: json['taskStatus'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      price: json['price'],
      isPaid: json['isPaid'],
      user: json['user'] != null ? json['user'] as Map<String, dynamic> : null,
      location: json['location'] != null
          ? json['location'] as Map<String, dynamic>
          : null,
      taskType: json['taskType'] != null
          ? json['taskType'] as Map<String, dynamic>
          : null,
      taskerLists: json['taskerLists'] != null
          ? (json['taskerLists'] as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList()
          : null,
      numberOfTasker: json['numberOfTasker'],
      approvedAt: json['approvedAt'] != null
          ? DateTime.parse(json['approvedAt'])
          : null,
      cancelAt:
          json['cancelAt'] != null ? DateTime.parse(json['cancelAt']) : null,
      finishedAt: json['finishedAt'] != null
          ? DateTime.parse(json['finishedAt'])
          : null,
      cancelReason: json['cancelReason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'taskTypeId': taskTypeId,
      'time': time.toIso8601String(),
      'locationId': locationId,
      'note': note,
      'isReTaskChildren': isReTaskChildren,
      'taskStatus': taskStatus,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'price': price,
      'isPaid': isPaid,
      'user': user,
      'location': location,
      'taskType': taskType,
      'taskerLists': taskerLists,
      'numberOfTasker': numberOfTasker,
      'approvedAt': approvedAt?.toIso8601String(),
      'cancelAt': cancelAt?.toIso8601String(),
      'finishedAt': finishedAt?.toIso8601String(),
      'cancelReason': cancelReason,
    };
  }
}
