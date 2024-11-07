class SettingModel {
  final int id;
  final int userId;
  final bool autoAcceptStatus;
  final bool loveTaskerOnly;
  final int upperStar;
  final bool nightMode;
  final DateTime createdAt;
  final DateTime updatedAt;

  SettingModel({
    required this.id,
    required this.userId,
    required this.autoAcceptStatus,
    required this.loveTaskerOnly,
    required this.upperStar,
    required this.nightMode,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SettingModel.fromJson(Map<String, dynamic> json) {
    return SettingModel(
      id: json['id'],
      userId: json['userId'],
      autoAcceptStatus: json['autoAcceptStatus'],
      loveTaskerOnly: json['loveTaskerOnly'],
      upperStar: json['upperStar'],
      nightMode: json['nightMode'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'autoAcceptStatus': autoAcceptStatus,
      'loveTaskerOnly': loveTaskerOnly,
      'upperStar': upperStar,
      'nightMode': nightMode,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
