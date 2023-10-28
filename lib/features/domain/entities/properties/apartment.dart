import '../../enums/apartment_types.dart';
import '../../enums/furniture_status.dart';
import '../../enums/legal_document_status.dart';
import 'property_feature.dart';

class Apartment implements PropertyFeature {
  final ApartmentTypes apartmentType;
  final bool isHandOver;
  final int numOfBedRooms;
  final FurnitureStatus? furnitureStatus;
  final int? numOfToilets;
  final String? balconyDirection;
  final String? block;
  final String? floor;
  final LegalDocumentStatus? legalDocumentStatus;
  final String? apartmentNumber;
  final bool? showApartmentNumber;

  Apartment(
    this.apartmentType,
    this.isHandOver,
    this.numOfBedRooms,
    this.furnitureStatus,
    this.numOfToilets,
    this.balconyDirection,
    this.block,
    this.floor,
    this.legalDocumentStatus,
    this.apartmentNumber,
    this.showApartmentNumber,
  );

  factory Apartment.fromJson(Map<String, dynamic> json) {
    return Apartment(
      json['apartment_type'],
      json['is_hand_over'],
      json['num_of_bed_rooms'],
      json['furniture_status'],
      json['num_of_toilets'],
      json['balcony_direction'],
      json['block'],
      json['floor'],
      json['legal_document_status'],
      json['apartment_number'],
      json['show_apartment_number'],
    );
  }
}
