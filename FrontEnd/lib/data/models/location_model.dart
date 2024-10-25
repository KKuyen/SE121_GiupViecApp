// lib/data/models/location_model.dart
import '../../domain/entities/location.dart';

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
  }) : super(
          id: id,
          ownerName: ownerName,
          ownerPhoneNumber: ownerPhoneNumber,
          country: country,
          province: province,
          district: district,
          detailAddress: detailAddress,
          map: map,
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
    };
  }
}
