class Location {
  final int id;
  final String ownerName;
  final String ownerPhoneNumber;
  final String country;
  final String province;
  final String district;
  final String detailAddress;
  final String map;
  final int userId;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;

  Location({
    required this.id,
    required this.ownerName,
    required this.ownerPhoneNumber,
    required this.country,
    required this.province,
    required this.district,
    required this.detailAddress,
    required this.map,
    required this.userId,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
  });
}
