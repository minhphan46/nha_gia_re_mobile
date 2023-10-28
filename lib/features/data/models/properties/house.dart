import '../../../domain/entities/properties/house.dart';
import '../../../domain/enums/enums.dart';
import 'address.dart';

class HouseModel extends HouseEntity {
  HouseModel({
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
    required bool hasWideAlley,
    required bool isFacade,
    required bool isWidensTowardsTheBack,
    required double? areaUsed,
    required double? width,
    required double? length,
    required HouseType? houseType,
    required int? numOfBedRooms,
    required int? numOfToilets,
    required int? numOfFloors,
    required Direction? mainDoorDirection,
    required LegalDocumentStatus? legalDocumentStatus,
    required FurnitureStatus? furnitureStatus,
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
              null, // Vì projectName không được sử dụng trong HouseModel
          deposit: null, // Vì deposit không được sử dụng trong HouseModel
          numOfLikes: 0, // Không cần đặt giá trị cho numOfLikes
          status: status, // Sử dụng giá trị status truyền vào constructor
          rejectedInfo: rejectedInfo,
          isHide: isHide,
          isPriority: isPriority,
          hasWideAlley: hasWideAlley,
          isFacade: isFacade,
          isWidensTowardsTheBack: isWidensTowardsTheBack,
          areaUsed: areaUsed,
          width: width,
          length: length,
          houseType: houseType,
          numOfBedRooms: numOfBedRooms,
          numOfToilets: numOfToilets,
          numOfFloors: numOfFloors,
          mainDoorDirection: mainDoorDirection,
          legalDocumentStatus: legalDocumentStatus,
          furnitureStatus: furnitureStatus,
        );

  factory HouseModel.fromJson(Map<String, dynamic> json) {
    return HouseModel(
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
      hasWideAlley: json['has_wide_alley'],
      isFacade: json['is_facade'],
      isWidensTowardsTheBack: json['is_widens_towards_the_back'],
      areaUsed: json['area_used'],
      width: json['width']?.toDouble(),
      length: json['length']?.toDouble(),
      houseType: json['house_type'] != null
          ? HouseType.parse(json['house_type'])
          : null,
      mainDoorDirection: json['main_door_direction'] != null
          ? Direction.parse(json['main_door_direction'])
          : null,
      legalDocumentStatus: json['legal_document_status'] != null
          ? LegalDocumentStatus.parse(json['legal_document_status'])
          : null,
      furnitureStatus: json['furniture_status'] != null
          ? FurnitureStatus.parse(json['furniture_status'])
          : null,
      numOfBedRooms: json['num_of_bed_rooms'],
      numOfToilets: json['num_of_toilets'],
      numOfFloors: json['num_of_floors'],
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
      'has_wide_alley': hasWideAlley,
      'is_facade': isFacade,
      'is_widens_towards_the_back': isWidensTowardsTheBack,
      'area_used': areaUsed,
      'width': width,
      'length': length,
      'house_type': houseType?.toString(),
      'num_of_bed_rooms': numOfBedRooms,
      'num_of_toilets': numOfToilets,
      'num_of_floors': numOfFloors,
      'main_door_direction': mainDoorDirection?.toString(),
      'legal_document_status': legalDocumentStatus?.toString(),
      'furniture_status': furnitureStatus.toString(),
      'status': status.toString(),
      'rejected_info': rejectedInfo,
      'is_hide': isHide,
    };
  }

  factory HouseModel.fromEntity(HouseEntity entity) {
    return HouseModel(
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
      hasWideAlley: entity.hasWideAlley,
      isFacade: entity.isFacade,
      isWidensTowardsTheBack: entity.isWidensTowardsTheBack,
      areaUsed: entity.areaUsed,
      width: entity.width,
      length: entity.length,
      houseType: entity.houseType,
      numOfBedRooms: entity.numOfBedRooms,
      numOfToilets: entity.numOfToilets,
      numOfFloors: entity.numOfFloors,
      mainDoorDirection: entity.mainDoorDirection,
      legalDocumentStatus: entity.legalDocumentStatus,
      furnitureStatus: entity.furnitureStatus,
      status: entity.status,
      rejectedInfo: entity.rejectedInfo,
      isHide: entity.isHide,
    );
  }
}
