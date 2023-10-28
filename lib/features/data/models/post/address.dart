import 'package:nhagiare_mobile/features/domain/entities/posts/address.dart';

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
          districtCode: districtCode,
          wardCode: wardCode,
          detail: detail,
        );

  @override
  Map<String, dynamic> toJson() => {
        'city_code': cityCode,
        'district_code': districtCode,
        'ward_code': wardCode,
        'detail': detail,
      };

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      cityCode: json['city_code'],
      districtCode: json['district_code'],
      wardCode: json['ward_code'],
      detail: json['detail'],
    );
  }

  factory AddressModel.fromEntity(AddressEntity entity) {
    return AddressModel(
      cityCode: entity.cityCode,
      districtCode: entity.districtCode,
      wardCode: entity.wardCode,
      detail: entity.detail,
    );
  }
}
