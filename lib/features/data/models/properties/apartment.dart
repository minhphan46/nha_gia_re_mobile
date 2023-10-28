import '../../../domain/entities/properties/apartment.dart';
import '../../../domain/enums/enums.dart';
import 'address.dart'; // Đảm bảo bạn import đúng đường dẫn đến lớp AddressEntity

class ApartmentModel extends ApartmentEntity {
  ApartmentModel({
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
    required bool isCorner,
    required bool isHandOver,
    required int? numOfBedRooms,
    required Direction? balconyDirection,
    required Direction? mainDoorDirection,
    required int? numOfToilets,
    required String? block,
    required int floor,
    required ApartmentType? apartmentType,
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
              null, // Vì projectName không được sử dụng trong ApartmentModel
          deposit: null, // Vì deposit không được sử dụng trong ApartmentModel
          numOfLikes: 0, // Không cần đặt giá trị cho numOfLikes
          status: status, // Sử dụng giá trị status truyền vào constructor
          rejectedInfo: rejectedInfo,
          isHide: isHide,
          isPriority: isPriority,
          isCorner: isCorner,
          isHandOver: isHandOver,
          numOfBedRooms: numOfBedRooms,
          balconyDirection: balconyDirection,
          mainDoorDirection: mainDoorDirection,
          numOfToilets: numOfToilets,
          block: block,
          floor: floor,
          apartmentType: apartmentType,
          legalDocumentStatus: legalDocumentStatus,
          furnitureStatus: furnitureStatus,
        );

  factory ApartmentModel.fromJson(Map<String, dynamic> json) {
    return ApartmentModel(
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
      isCorner: json['is_corner'],
      isHandOver: json['is_hand_over'],
      numOfBedRooms: json['num_of_bedrooms'],
      balconyDirection: json['balcony_direction'] != null
          ? Direction.parse(json['balcony_direction'])
          : null,
      mainDoorDirection: json['main_door_direction'] != null
          ? Direction.parse(json['main_door_direction'])
          : null,
      numOfToilets: json['num_of_toilets'],
      block: json['block'],
      floor: json['floor'],
      apartmentType: json['apartment_type'] != null
          ? ApartmentType.parse(json['apartment_type'])
          : null,
      legalDocumentStatus: json['legal_document_status'] != null
          ? LegalDocumentStatus.parse(json['legal_document_status'])
          : null,
      status: PostStatus.parse(json['status']),
      rejectedInfo: json['rejected_info'],
      isHide: json['is_hide'],
      furnitureStatus: FurnitureStatus.parse(json['furniture_status']),
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
      'is_corner': isCorner,
      'is_hand_over': isHandOver,
      'num_of_bedrooms': numOfBedRooms,
      'balcony_direction': balconyDirection?.toString(),
      'main_door_direction': mainDoorDirection?.toString(),
      'num_of_toilets': numOfToilets,
      'block': block,
      'floor': floor,
      'apartment_type': apartmentType?.toString(),
      'legal_document_status': legalDocumentStatus?.toString(),
      'status': status.toString(),
      'rejected_info': rejectedInfo,
      'is_hide': isHide,
      'furniture_status': furnitureStatus.toString(),
    };
  }

  factory ApartmentModel.fromEntity(ApartmentEntity entity) {
    return ApartmentModel(
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
      isCorner: entity.isCorner,
      isHandOver: entity.isHandOver,
      numOfBedRooms: entity.numOfBedRooms,
      balconyDirection: entity.balconyDirection,
      mainDoorDirection: entity.mainDoorDirection,
      numOfToilets: entity.numOfToilets,
      block: entity.block,
      floor: entity.floor,
      apartmentType: entity.apartmentType,
      legalDocumentStatus: entity.legalDocumentStatus,
      status: entity.status,
      rejectedInfo: entity.rejectedInfo,
      isHide: entity.isHide,
      furnitureStatus: entity.furnitureStatus,
    );
  }
}
