import 'package:se121_giupviec_app/domain/entities/loveTasker.dart';

class LoveTaskerModel extends LoveTasker {
  LoveTaskerModel({
    required super.id,
    required super.userId,
    required super.taskerId,
    required super.tasker,
  });

  factory LoveTaskerModel.fromJson(Map<String, dynamic> json) {
    return LoveTaskerModel(
      id: json['id'],
      userId: json['userId'],
      taskerId: json['taskerId'],
      tasker: json['tasker'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'taskerId': taskerId,
      'tasker': tasker,
    };
  }
}
