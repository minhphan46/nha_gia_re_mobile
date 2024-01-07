import 'package:nhagiare_mobile/features/domain/entities/posts/address.dart';
import 'package:nhagiare_mobile/features/domain/entities/user/user.dart';
import 'package:nhagiare_mobile/features/domain/enums/post_status.dart';
import '../../../domain/entities/posts/real_estate_post.dart';

class RealEstatePostModel extends RealEstatePostEntity {
  const RealEstatePostModel({
    super.id,
    super.userId,
    super.projectId,
    super.typeId,
    super.unitId,
    super.status,
    super.title,
    super.description,
    super.area,
    super.address,
    super.addressPoint,
    super.price,
    super.deposit,
    super.isLease,
    super.postedDate,
    super.expiryDate,
    super.images,
    super.videos,
    super.isProSeller,
    super.features,
    super.postApprovalPriorityPoint,
    super.isActive,
    super.infoMessage,
    super.updateCount,
    super.displayPriorityPoint,
    super.numFavourites,
    super.numViews,
    super.isFavorite,
    super.user,
  });

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
        deposit: json['deposit'] != null ? int.parse(json['deposit']) : null,
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
        user: UserEntity.fromJson(json['user']));
  }

  Map<String, dynamic> toJson() {
    return {
      'type_id': typeId,
      'unit_id': unitId,
      'title': title,
      'description': description,
      'price': price,
      'deposit': deposit,
      'area': area!.toString(),
      'images': images,
      'videos': videos,
      //'address': address!.toJson(),
      'address': {
        "province_code": 1,
        "district_code": 1,
        "ward_code": 1,
        "street": "123 Main Street"
      },
      'features': features,
      'is_lease': isLease,
      'is_pro_seller': isProSeller,
      'project_id': projectId,
      'is_active': isActive ?? true,
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
