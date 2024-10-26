// lib/domain/entities/location.dart
class Location {
  final int id;
  final String ownerName;
  final String ownerPhoneNumber;
  final String country;
  final String province;
  final String district;
  final String detailAddress;
  final String map;

  Location({
    required this.id,
    required this.ownerName,
    required this.ownerPhoneNumber,
    required this.country,
    required this.province,
    required this.district,
    required this.detailAddress,
    required this.map,
  });
}
