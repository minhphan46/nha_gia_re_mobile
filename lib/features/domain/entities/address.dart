import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final int? cityCode;
  final String? cityName;
  final int? districtCode;
  final String? districtName;
  final int? wardCode;
  final String? wardName;
  final String? detail;
  final double? latitude;
  final double? longitude;
  AddressEntity({
    this.cityCode,
    this.cityName,
    this.districtCode,
    this.districtName,
    this.wardCode,
    this.wardName,
    this.detail,
    this.latitude,
    this.longitude,
  })  : assert(detail?.trim().isNotEmpty ?? true),
        assert((longitude == null) == (latitude == null)),
        assert(longitude == null || (-180 <= longitude && longitude <= 180)),
        assert(latitude == null || (-90 <= latitude && latitude <= 90));

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

  AddressEntity.fromJson(Map<String, dynamic> json)
      : cityCode = json['city_code'],
        cityName = json['city_name'],
        districtCode = json['district_code'],
        districtName = json['district_name'],
        wardCode = json['ward_code'],
        wardName = json['ward_name'],
        detail = json['detail'],
        latitude = json['latitude'],
        longitude = json['longitude'];

  @override
  List<Object?> get props => [cityCode];
}
