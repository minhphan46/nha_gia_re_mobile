import '../../enums/direction.dart';
import '../../enums/furniture_status.dart';
import '../../enums/legal_document_status.dart';
import 'property_feature.dart';

class Office implements PropertyFeature {
  final String? officeType;
  final bool? isFacade;
  final Direction? mainDoorDirection;
  final String? block;
  final String? floor;
  final LegalDocumentStatus? legalDocumentStatus;
  final String? officeNumber;
  final bool? showOfficeNumber;
  final FurnitureStatus? furnitureStatus;

  Office(
    this.officeType,
    this.isFacade,
    this.mainDoorDirection,
    this.block,
    this.floor,
    this.legalDocumentStatus,
    this.officeNumber,
    this.showOfficeNumber,
    this.furnitureStatus,
  );

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      json['office_type'],
      json['is_facade'],
      json['main_door_direction'] != null
          ? Direction.parse(json['main_door_direction'])
          : null,
      json['block'],
      json['floor'],
      json['legal_document_status'] != null
          ? LegalDocumentStatus.parse(json['legal_document_status'])
          : null,
      json['office_number'],
      json['show_office_number'],
      json['furniture_status'] != null
          ? FurnitureStatus.parse(json['furniture_status'])
          : null,
    );
  }
}
