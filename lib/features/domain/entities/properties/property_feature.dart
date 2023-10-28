import 'package:nhagiare_mobile/features/domain/entities/properties/motel.dart';

import 'apartment.dart';
import 'house.dart';
import 'land.dart';
import 'office.dart';

abstract class PropertyFeature {
  static PropertyFeature fromJson(Map<String, dynamic> data) {
    var type = data['type_id'];
    var json = data['features'];

    if (type == 'motel') {
      return Motel.fromJson(json);
    } else if (type == 'apartment') {
      return Apartment.fromJson(json);
    } else if (type == 'office') {
      return Office.fromJson(json);
    } else if (type == 'house') {
      return House.fromJson(json);
    } else if (type == 'land') {
      return Land.fromJson(json);
    } else {
      throw Exception('Invalid property type');
    }
  }
}
