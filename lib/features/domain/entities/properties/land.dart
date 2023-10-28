import '../../enums/direction.dart';
import '../../enums/land_types.dart';
import '../../enums/legal_document_status.dart';
import 'property_feature.dart';

class Land implements PropertyFeature {
  final LandTypes landType;
  final String? landLotCode;
  final String? subdivisionName;
  final bool? isFacade;
  final bool? hasWideAlley;
  final bool? isWidensTowardsTheBack;
  final Direction? landDirection;
  final double? width;
  final double? length;
  final LegalDocumentStatus? legalDocumentStatus;
  final bool? showLandLotCode;

  Land(
    this.landType,
    this.landLotCode,
    this.subdivisionName,
    this.isFacade,
    this.hasWideAlley,
    this.isWidensTowardsTheBack,
    this.landDirection,
    this.width,
    this.length,
    this.legalDocumentStatus,
    this.showLandLotCode,
  );

  factory Land.fromJson(Map<String, dynamic> json) {
    return Land(
      json['land_type'],
      json['land_lot_code'],
      json['subdivision_name'],
      json['is_facade'],
      json['has_wide_alley'],
      json['is_widens_towards_the_back'],
      json['land_direction'],
      json['width'],
      json['length'],
      json['legal_document_status'],
      json['show_land_lot_code'],
    );
  }
}
