import 'package:se121_giupviec_app/domain/entities/BlockTasker.dart';

class BlockTaskerModel extends BlockTasker {
  BlockTaskerModel({
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

  factory BlockTaskerModel.fromJson(Map<String, dynamic> json) {
    return BlockTaskerModel(
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
