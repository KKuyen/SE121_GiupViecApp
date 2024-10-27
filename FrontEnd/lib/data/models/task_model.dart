import 'package:se121_giupviec_app/domain/entities/task.dart';

class TaskModel extends Task {
  final Map<String, dynamic>? user; // Allow null
  final Map<String, dynamic>? location; // Allow null
  final Map<String, dynamic>? taskType; // Allow null
  final List<Map<String, dynamic>>? taskerLists; // Allow null

  TaskModel({
    required int id,
    required int userId,
    required int taskTypeId,
    required DateTime time,
    required int locationId,
    String? note,
    int? isReTaskChildren,
    required String taskStatus,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? price,
    this.user,
    this.location,
    this.taskType,
    this.taskerLists,
    int? numberOfTasker,
    DateTime? approvedAt,
    DateTime? cancelAt,
    DateTime? finishedAt,
    String? cancelReason,
  }) : super(
          id: id,
          userId: userId,
          taskTypeId: taskTypeId,
          time: time,
          locationId: locationId,
          note: note,
          isReTaskChildren: isReTaskChildren,
          taskStatus: taskStatus,
          createdAt: createdAt,
          updatedAt: updatedAt,
          price: price,
          location: location,
          user: user,
          taskType: taskType,
          taskerLists: taskerLists,
          numberOfTasker: numberOfTasker,
          approvedAt: approvedAt,
          cancelAt: cancelAt,
          finishedAt: finishedAt,
          cancelReason: cancelReason,
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
