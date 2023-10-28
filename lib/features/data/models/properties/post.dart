import '../../../domain/entities/properties/post.dart';
import '../../../domain/enums/enums.dart';
import 'address.dart';

class PostModel extends PostEntity {
  PostModel({
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
    required String? projectName,
    required int? deposit,
    required int numOfLikes,
    required PostStatus status,
    required String? rejectedInfo,
    required bool isHide,
    required bool isPriority,
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
          projectName: projectName,
          deposit: deposit,
          numOfLikes: numOfLikes,
          status: status,
          rejectedInfo: rejectedInfo,
          isHide: isHide,
          isPriority: isPriority,
        );

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      area: json['area'].toDouble(),
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
      projectName: json['project_name'],
      deposit: json['deposit'],
      numOfLikes: json['num_of_likes'],
      status: PostStatus.parse(json['status']),
      rejectedInfo: json['rejected_info'],
      isHide: json['is_hide'],
      isPriority: json['is_priority'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'area': area,
      'property_type':
          type.toString(), // Sử dụng .toString() để lấy giá trị enum dướng dẫn
      'address': address.toJson(), // Gọi phương thức toJson() của AddressModel
      'user_id': userID,
      'is_lease': isLease,
      'price': price,
      'title': title,
      'description': description,
      'posted_date': postedDate.toIso8601String(),
      'expiry_date': expiryDate.toIso8601String(),
      'images_url': imagesUrl,
      'is_pro_seller': isProSeller,
      'project_name': projectName,
      'deposit': deposit,
      'num_of_likes': numOfLikes,
      'status': status
          .toString(), // Sử dụng .toString() để lấy giá trị enum dướng dẫn
      'rejected_info': rejectedInfo,
      'is_hide': isHide,
      'is_priority': isPriority,
    };
  }

  factory PostModel.fromEntity(PostEntity entity) {
    return PostModel(
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
      projectName: entity.projectName,
      deposit: entity.deposit,
      numOfLikes: entity.numOfLikes,
      status: entity.status,
      rejectedInfo: entity.rejectedInfo,
      isHide: entity.isHide,
      isPriority: entity.isPriority,
    );
  }
}
