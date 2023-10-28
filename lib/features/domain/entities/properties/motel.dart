import '../../enums/furniture_status.dart';
import 'property_feature.dart';

class Motel implements PropertyFeature {
  final double waterPrice;
  final double electricPrice;
  final FurnitureStatus furnitureStatus;

  Motel(this.waterPrice, this.electricPrice, this.furnitureStatus);

  factory Motel.fromJson(Map<String, dynamic> json) {
    if (json['water_price'] == null ||
        json['electric_price'] == null ||
        json['furniture_status'] == null) {
      throw Exception('Invalid motel');
    }
    return Motel(
        json['water_price'], json['electric_price'], json['furniture_status']);
  }
}
