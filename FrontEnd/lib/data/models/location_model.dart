// lib/data/models/task_model.dart

import 'package:se121_giupviec_app/domain/entities/location.dart';

class LocationModel extends Location {
  LocationModel({
    required int id,
    required String ownerName,
    required String ownerPhoneNumber,
    required String country,
    required String province,
    required String district,
    required String detailAddress,
    required String map,
    required int userId,
    required bool isDefault,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          ownerName: ownerName,
          ownerPhoneNumber: ownerPhoneNumber,
          country: country,
          province: province,
          district: district,
          detailAddress: detailAddress,
          map: map,
          userId: userId,
          isDefault: isDefault,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      ownerName: json['ownerName'],
      ownerPhoneNumber: json['ownerPhoneNumber'],
      country: json['country'],
      province: json['province'],
      district: json['district'],
      detailAddress: json['detailAddress'],
      map: json['map'],
      userId: json['userId'],
      isDefault: json['isDefault'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ownerName': ownerName,
      'ownerPhoneNumber': ownerPhoneNumber,
      'country': country,
      'province': province,
      'district': district,
      'detailAddress': detailAddress,
      'map': map,
      'userId': userId,
      'isDefault': isDefault,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
