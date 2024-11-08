import 'package:se121_giupviec_app/domain/entities/tasker_info.dart';

class TaskerInfoModel extends TaskerInfo {
  TaskerInfoModel({
    required super.errCode,
    required super.tasker,
    required super.taskerInfo,
    required super.reviewList,
    required super.isLove,
    required super.isBlock,
    required super.message,
  });

  factory TaskerInfoModel.fromJson(Map<String, dynamic> json) {
    return TaskerInfoModel(
      errCode: json['errCode'],
      tasker: json['tasker'],
      taskerInfo: json['taskerInfo'],
      reviewList: json['reviewList'] != null
          ? (json['reviewList'] as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList()
          : null,
      isLove: json['isLove'],
      isBlock: json['isBlock'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'errCode': errCode,
      'tasker': tasker,
      'taskerInfo': taskerInfo,
      'reviewList': reviewList,
      'isLove': isLove,
      'isBlock': isBlock,
      'message': message,
    };
  }
}
