import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final int? provinceCode;
  final int? districtCode;
  final int? wardCode;
  final String? detail;

  AddressEntity({
    this.provinceCode,
    this.districtCode,
    this.wardCode,
    this.detail,
  }) : assert(detail?.trim().isNotEmpty ?? true);

  Map<String, dynamic> toJson() => {
        'province_code': provinceCode,
        'district_code': districtCode,
        'ward_code': wardCode,
        'detail': detail,
      };

  AddressEntity.fromJson(Map<String, dynamic> json)
      : provinceCode = json['province_code'],
        districtCode = json['district_code'],
        wardCode = json['ward_code'],
        detail = json['detail'];

  @override
  String toString() {
    String result = "";
    result += detail != null ? "$detail, " : "";
    result += wardCode != null ? "$wardCode, " : "";
    result += districtCode != null ? "$districtCode, " : "";
    result += provinceCode != null ? "$provinceCode" : "";
    return result;
  }

  @override
  List<Object?> get props => [provinceCode];
}
