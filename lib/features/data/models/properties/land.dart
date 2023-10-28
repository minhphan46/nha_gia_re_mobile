import '../../../domain/entities/properties/land.dart';
import '../../../domain/enums/enums.dart';
import 'address.dart';

class LandModel extends LandEntity {
  LandModel({
    required String id,
    required double area,
    required PropertyType type,
    required AddressModel address,
    required String userID,
    required bool isLease,
    required int price,
    required String title,
    required String description,
    required DateTime postedDate,
    required DateTime expiryDate,
    required List<String> imagesUrl,
    required bool isProSeller,
    required bool isPriority,
    required String? landLotCode,
    required String? subdivisionName,
    required LandType? landType,
    required double width,
    required double length,
    required Direction? landDirection,
    required LegalDocumentStatus? legalDocumentStatus,
    required bool isFacade,
    required bool isWidensTowardsTheBack,
    required bool hasWideAlley,
    required PostStatus status,
    required String? rejectedInfo,
    required bool isHide,
  }) : super(
          id: id,
          area: area,
          type: type,
          address: address,
          userID: userID,
          isLease: isLease,
          price: price,
          title: title,
          description: description,
          postedDate: postedDate,
          expiryDate: expiryDate,
          imagesUrl: imagesUrl,
          isProSeller: isProSeller,
          projectName:
              null, // Vì projectName không được sử dụng trong LandModel
          deposit: null, // Vì deposit không được sử dụng trong LandModel
          numOfLikes: 0, // Không cần đặt giá trị cho numOfLikes
          status: status, // Sử dụng giá trị status truyền vào constructor
          rejectedInfo: rejectedInfo,
          isHide: isHide,
          isPriority: isPriority,
          landLotCode: landLotCode,
          subdivisionName: subdivisionName,
          landType: landType,
          width: width,
          length: length,
          landDirection: landDirection,
          legalDocumentStatus: legalDocumentStatus,
          isFacade: isFacade,
          isWidensTowardsTheBack: isWidensTowardsTheBack,
          hasWideAlley: hasWideAlley,
        );

  factory LandModel.fromJson(Map<String, dynamic> json) {
    return LandModel(
      id: json['id'],
      area: json['area'],
      type: PropertyType.parse(json['property_type']),
      address: AddressModel.fromJson(json['address']),
      userID: json['user_id'],
      isLease: json['is_lease'],
      price: json['price'],
      title: json['title'],
      description: json['description'],
      postedDate: DateTime.parse(json['posted_date']),
      expiryDate: DateTime.parse(json['expiry_date']),
      imagesUrl: List<String>.from(json['images_url']),
      isProSeller: json['is_pro_seller'],
      isPriority: json['is_priority'],
      landLotCode: json['land_lot_code'],
      subdivisionName: json['subdivision_name'],
      landType:
          json['land_type'] != null ? LandType.parse(json['land_type']) : null,
      landDirection: json['land_direction'] != null
          ? Direction.parse(json['land_direction'])
          : null,
      legalDocumentStatus: json['legal_document_status'] != null
          ? LegalDocumentStatus.parse(json['legal_document_status'])
          : null,
      width: json['width'].toDouble(),
      length: json['length'].toDouble(),
      isFacade: json['is_facade'],
      isWidensTowardsTheBack: json['is_widens_towards_the_back'],
      hasWideAlley: json['has_wide_alley'],
      status: PostStatus.parse(json['status']),
      rejectedInfo: json['rejected_info'],
      isHide: json['is_hide'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'area': area,
      'property_type': type.toString(),
      'address': address.toJson(),
      'user_id': userID,
      'is_lease': isLease,
      'price': price,
      'title': title,
      'description': description,
      'posted_date': postedDate.toIso8601String(),
      'expiry_date': expiryDate.toIso8601String(),
      'images_url': imagesUrl,
      'is_pro_seller': isProSeller,
      'is_priority': isPriority,
      'land_lot_code': landLotCode,
      'subdivision_name': subdivisionName,
      'land_type': landType?.toString(),
      'width': width,
      'length': length,
      'land_direction': landDirection?.toString(),
      'legal_document_status': legalDocumentStatus?.toString(),
      'is_facade': isFacade,
      'is_widens_towards_the_back': isWidensTowardsTheBack,
      'has_wide_alley': hasWideAlley,
      'status': status.toString(),
      'rejected_info': rejectedInfo,
      'is_hide': isHide,
    };
  }

  factory LandModel.fromEntity(LandEntity entity) {
    return LandModel(
      id: entity.id,
      area: entity.area,
      type: entity.type,
      address: AddressModel.fromEntity(entity.address),
      userID: entity.userID,
      isLease: entity.isLease,
      price: entity.price,
      title: entity.title,
      description: entity.description,
      postedDate: entity.postedDate,
      expiryDate: entity.expiryDate,
      imagesUrl: entity.imagesUrl,
      isProSeller: entity.isProSeller,
      isPriority: entity.isPriority,
      landLotCode: entity.landLotCode,
      subdivisionName: entity.subdivisionName,
      landType: entity.landType,
      width: entity.width,
      length: entity.length,
      landDirection: entity.landDirection,
      legalDocumentStatus: entity.legalDocumentStatus,
      isFacade: entity.isFacade,
      isWidensTowardsTheBack: entity.isWidensTowardsTheBack,
      hasWideAlley: entity.hasWideAlley,
      status: entity.status,
      rejectedInfo: entity.rejectedInfo,
      isHide: entity.isHide,
    );
  }
}
