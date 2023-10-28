import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final int? cityCode;
  final int? districtCode;
  final int? wardCode;
  final String? detail;

  AddressEntity({
    this.cityCode,
    this.districtCode,
    this.wardCode,
    this.detail,
  }) : assert(detail?.trim().isNotEmpty ?? true);

  Map<String, dynamic> toJson() => {
        'city_code': cityCode,
        'district_code': districtCode,
        'ward_code': wardCode,
        'detail': detail,
      };

  AddressEntity.fromJson(Map<String, dynamic> json)
      : cityCode = json['city_code'],
        districtCode = json['district_code'],
        wardCode = json['ward_code'],
        detail = json['detail'];

  @override
  List<Object?> get props => [cityCode];
}
