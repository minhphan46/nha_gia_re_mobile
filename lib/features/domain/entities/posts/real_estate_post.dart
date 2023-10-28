import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/address.dart';

class RealEstatePostEntity extends Equatable {
  final String? id;
  final String? userId;
  final String? projectId;
  final String? typeId;
  final String? unitId;
  final String? status;
  final String? title;
  final String? description;
  final double? area;
  final AddressEntity? address;
  final Point? addressPoint;
  final int? price;
  final int? deposit;
  final bool? isLease;
  final DateTime? postedDate;
  final DateTime? expiryDate;
  final List<String>? images;
  final List<String>? videos;
  final bool? isProSeller;
  final Map<String, dynamic>? features;
  final bool? postApprovalPriority;
  final bool? isActive;
  final String? infoMessage;
  final int? updateCount;
  final int? priorityLevel;

  const RealEstatePostEntity({
    this.id,
    this.userId,
    this.projectId,
    this.typeId,
    this.unitId,
    this.status,
    this.title,
    this.description,
    this.area,
    this.address,
    this.addressPoint,
    this.price,
    this.deposit,
    this.isLease,
    this.postedDate,
    this.expiryDate,
    this.images,
    this.videos,
    this.isProSeller,
    this.features,
    this.postApprovalPriority,
    this.isActive,
    this.infoMessage,
    this.updateCount,
    this.priorityLevel,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        projectId,
        typeId,
        unitId,
        status,
        title,
        description,
        area,
        address,
        addressPoint,
        price,
        deposit,
        isLease,
        postedDate,
        expiryDate,
        images,
        videos,
        isProSeller,
        features,
        postApprovalPriority,
        isActive,
        infoMessage,
        updateCount,
        priorityLevel,
      ];

  RealEstatePostEntity copyWith({
    String? id,
    String? userId,
    String? projectId,
    String? typeId,
    String? unitId,
    String? status,
    String? title,
    String? description,
    double? area,
    AddressEntity? address,
    Point? addressPoint,
    int? price,
    int? deposit,
    bool? isLease,
    DateTime? postedDate,
    DateTime? expiryDate,
    List<String>? images,
    List<String>? videos,
    bool? isProSeller,
    Map<String, dynamic>? features,
    bool? postApprovalPriority,
    bool? isActive,
    String? infoMessage,
    int? updateCount,
    int? priorityLevel,
  }) {
    return RealEstatePostEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      projectId: projectId ?? this.projectId,
      typeId: typeId ?? this.typeId,
      unitId: unitId ?? this.unitId,
      status: status ?? this.status,
      title: title ?? this.title,
      description: description ?? this.description,
      area: area ?? this.area,
      address: address ?? this.address,
      addressPoint: addressPoint ?? this.addressPoint,
      price: price ?? this.price,
      deposit: deposit ?? this.deposit,
      isLease: isLease ?? this.isLease,
      postedDate: postedDate ?? this.postedDate,
      expiryDate: expiryDate ?? this.expiryDate,
      images: images ?? this.images,
      videos: videos ?? this.videos,
      isProSeller: isProSeller ?? this.isProSeller,
      features: features ?? this.features,
      postApprovalPriority: postApprovalPriority ?? this.postApprovalPriority,
      isActive: isActive ?? this.isActive,
      infoMessage: infoMessage ?? this.infoMessage,
      updateCount: updateCount ?? this.updateCount,
      priorityLevel: priorityLevel ?? this.priorityLevel,
    );
  }
}
