import 'package:nhagiare_mobile/features/domain/entities/properties/address.dart';

class AddressModel extends AddressEntity {
  AddressModel({
    final int? cityCode,
    final String? cityName,
    final int? districtCode,
    final String? districtName,
    final int? wardCode,
    final String? wardName,
    final String? detail,
    final double? latitude,
    final double? longitude,
  }) : super(
          cityCode: cityCode,
          cityName: cityName,
          districtCode: districtCode,
          districtName: districtName,
          wardCode: wardCode,
          wardName: wardName,
          detail: detail,
          latitude: latitude,
          longitude: longitude,
        );

  @override
  Map<String, dynamic> toJson() => {
        'city_code': cityCode,
        'city_name': cityName,
        'district_code': districtCode,
        'district_name': districtName,
        'ward_code': wardCode,
        'ward_name': wardName,
        'detail': detail,
        'latitude': latitude,
        'longitude': longitude,
      };
  @override
  String toString() {
    return '$cityName, $districtName, $wardName';
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      cityCode: json['city_code'],
      cityName: json['city_name'],
      districtCode: json['district_code'],
      districtName: json['district_name'],
      wardCode: json['ward_code'],
      wardName: json['ward_name'],
      detail: json['detail'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  factory AddressModel.fromEntity(AddressEntity entity) {
    return AddressModel(
      cityCode: entity.cityCode,
      cityName: entity.cityName,
      districtCode: entity.districtCode,
      districtName: entity.districtName,
      wardCode: entity.wardCode,
      wardName: entity.wardName,
      detail: entity.detail,
      latitude: entity.latitude,
      longitude: entity.longitude,
    );
  }
}
