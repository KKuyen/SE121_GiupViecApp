import 'package:se121_giupviec_app/domain/entities/loveTasker.dart';
import 'package:se121_giupviec_app/domain/entities/review.dart';

class LoveTaskerModel extends LoveTasker {
  LoveTaskerModel({
    required int id,
    required int userId,
    required int taskerId,
    required Object? tasker,
  }) : super(
          id: id,
          userId: userId,
          taskerId: taskerId,
          tasker: tasker,
        );

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
