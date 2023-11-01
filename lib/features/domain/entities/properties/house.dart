import '../../enums/direction.dart';
import '../../enums/furniture_status.dart';
import '../../enums/legal_document_status.dart';
import 'property_feature.dart';

class House implements PropertyFeature {
  final String? houseType;
  final int? numOfBedRooms;
  final bool? isWidensTowardsTheBack;
  final int? numOfToilets;
  final int? numOfFloors;
  final Direction? mainDoorDirection;
  final double? width;
  final double? length;
  final double? areaUsed;
  final LegalDocumentStatus? legalDocumentStatus;
  final String? houseNumber;
  final bool? showHouseNumber;
  final FurnitureStatus? furnitureStatus;

  House(
    this.houseType,
    this.numOfBedRooms,
    this.isWidensTowardsTheBack,
    this.numOfToilets,
    this.numOfFloors,
    this.mainDoorDirection,
    this.width,
    this.length,
    this.areaUsed,
    this.legalDocumentStatus,
    this.houseNumber,
    this.showHouseNumber,
    this.furnitureStatus,
  );

  factory House.fromJson(Map<String, dynamic> json) {
    return House(
      json['house_type'],
      json['num_of_bed_rooms'],
      json['is_widens_towards_the_back'],
      json['num_of_toilets'],
      json['num_of_floors'],
      json['main_door_direction'] != null
          ? Direction.parse(json['main_door_direction'])
          : null,
      json['width'] != null ? double.parse(json['width'].toString()) : null,
      json['length'] != null ? double.parse(json['length'].toString()) : null,
      json['area_used'] != null
          ? double.parse(json['area_used'].toString())
          : null,
      json['legal_document_status'] != null
          ? LegalDocumentStatus.parse(json['legal_document_status'])
          : null,
      json['house_number'],
      json['show_house_number'],
      json['furniture_status'] != null
          ? FurnitureStatus.parse(json['furniture_status'])
          : null,
    );
  }
}
