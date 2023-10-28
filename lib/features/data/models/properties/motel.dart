import '../../../domain/entities/properties/motel.dart';
import '../../../domain/enums/enums.dart';
import 'address.dart';

class MotelModel extends MotelEntity {
  MotelModel({
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
    required int? electricPrice,
    required int? waterPrice,
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
              null, // Vì projectName không được sử dụng trong MotelModel
          deposit: null, // Vì deposit không được sử dụng trong MotelModel
          numOfLikes: 0, // Không cần đặt giá trị cho numOfLikes
          status: status, // Sử dụng giá trị status truyền vào constructor
          rejectedInfo: rejectedInfo,
          isHide: isHide,
          isPriority: isPriority,
          electricPrice: electricPrice,
          waterPrice: waterPrice,
          furnitureStatus: furnitureStatus,
        );

  factory MotelModel.fromJson(Map<String, dynamic> json) {
    return MotelModel(
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
      electricPrice: json['electric_price'],
      waterPrice: json['water_price'],
      furnitureStatus: json['furniture_status'] != null
          ? FurnitureStatus.parse(json['furniture_status'])
          : null,
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
      'electric_price': electricPrice,
      'water_price': waterPrice,
      'furniture_status': furnitureStatus?.toString(),
      'status': status.toString(),
      'rejected_info': rejectedInfo,
      'is_hide': isHide,
    };
  }

  factory MotelModel.fromEntity(MotelEntity entity) {
    return MotelModel(
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
      electricPrice: entity.electricPrice,
      waterPrice: entity.waterPrice,
      furnitureStatus: entity.furnitureStatus,
      status: entity.status,
      rejectedInfo: entity.rejectedInfo,
      isHide: entity.isHide,
    );
  }
}
