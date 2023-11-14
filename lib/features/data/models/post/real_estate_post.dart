import 'dart:math';
import 'package:nhagiare_mobile/features/domain/entities/posts/address.dart';
import 'package:nhagiare_mobile/features/domain/enums/post_status.dart';
import '../../../domain/entities/posts/real_estate_post.dart';

class RealEstatePostModel extends RealEstatePostEntity {
  const RealEstatePostModel({
    String? id,
    String? userId,
    String? projectId,
    String? typeId,
    String? unitId,
    PostStatus? status,
    String? title,
    String? description,
    double? area,
    AddressEntity? address,
    Point? addressPoint,
    String? price,
    int? deposit,
    bool? isLease,
    DateTime? postedDate,
    DateTime? expiryDate,
    List<String>? images,
    List<String>? videos,
    bool? isProSeller,
    Map<String, dynamic>? features,
    int? postApprovalPriorityPoint,
    bool? isActive,
    String? infoMessage,
    int? updateCount,
    int? displayPriorityPoint,
    int? numFavourites,
    int? numViews,
    bool? isFavorite,
  }) : super(
          id: id,
          userId: userId,
          projectId: projectId,
          typeId: typeId,
          unitId: unitId,
          status: status,
          title: title,
          description: description,
          area: area,
          address: address,
          addressPoint: addressPoint,
          price: price,
          deposit: deposit,
          isLease: isLease,
          postedDate: postedDate,
          expiryDate: expiryDate,
          images: images,
          videos: videos,
          isProSeller: isProSeller,
          features: features,
          postApprovalPriorityPoint: postApprovalPriorityPoint,
          isActive: isActive,
          infoMessage: infoMessage,
          updateCount: updateCount,
          displayPriorityPoint: displayPriorityPoint,
          isFavorite: isFavorite,
          numFavourites: numFavourites,
          numViews: numViews,
        );

  factory RealEstatePostModel.fromJson(Map<String, dynamic> json) {
    return RealEstatePostModel(
      id: json['id'],
      userId: json['user_id'],
      projectId: json['project_id'],
      typeId: json['type_id'],
      unitId: json['unit_id'],
      status: PostStatus.parse(json['status']),
      title: json['title'],
      description: json['description'],
      area: double.parse(json['area'].toString()),
      address: AddressEntity.fromJson(json['address']),
      addressPoint: null,
      //Point(json['address_point']['x'], json['address_point']['y']),
      price: json['price'],
      deposit: json['deposit'],
      isLease: json['is_lease'],
      postedDate: DateTime.parse(json['posted_date']),
      expiryDate: DateTime.parse(json['expiry_date']),
      images: List<String>.from(json['images'] ?? []),
      videos: List<String>.from(json['videos'] ?? []),
      isProSeller: json['is_pro_seller'],
      infoMessage: json['info_message'],
      displayPriorityPoint: json['display_priority_point'],
      features: json['features'],
      postApprovalPriorityPoint: json['post_approval_priority_point'],
      updateCount: json['update_count'],
      isActive: json['is_active'],
      numFavourites: json['num_favourites'],
      numViews: json['num_views'],
      isFavorite: json['is_favorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'project_id': projectId,
      'type_id': typeId,
      'unit_id': unitId,
      'status': status.toString(),
      'title': title,
      'description': description,
      'area': area!.toString(),
      'address': address!.toJson(),
      'address_point': addressPoint,
      'price': price,
      'deposit': deposit,
      'is_lease': isLease,
      'posted_date': postedDate!.toIso8601String(),
      'expiry_date': expiryDate!.toIso8601String(),
      'images': images,
      'videos': videos,
      'is_pro_seller': isProSeller,
      'info_message': infoMessage,
      'display_priority_point': displayPriorityPoint,
      'features': features,
      'post_approval_priority_point': postApprovalPriorityPoint,
      'update_count': updateCount,
      'is_active': isActive,
      'num_favourites': numFavourites,
      'num_views': numViews,
      'is_favorite': isFavorite,
    };
  }

  factory RealEstatePostModel.fromEntity(RealEstatePostEntity entity) {
    return RealEstatePostModel(
      id: entity.id,
      userId: entity.userId,
      projectId: entity.projectId,
      typeId: entity.typeId,
      unitId: entity.unitId,
      status: entity.status,
      title: entity.title,
      description: entity.description,
      area: entity.area,
      address: entity.address,
      addressPoint: entity.addressPoint,
      price: entity.price,
      deposit: entity.deposit,
      isLease: entity.isLease,
      postedDate: entity.postedDate,
      expiryDate: entity.expiryDate,
      images: entity.images,
      videos: entity.videos,
      isProSeller: entity.isProSeller,
      infoMessage: entity.infoMessage,
      displayPriorityPoint: entity.displayPriorityPoint,
      features: entity.features,
      postApprovalPriorityPoint: entity.postApprovalPriorityPoint,
      updateCount: entity.updateCount,
      isActive: entity.isActive,
      numFavourites: entity.numFavourites,
      numViews: entity.numViews,
      isFavorite: entity.isFavorite,
    );
  }
}
