import 'package:flutter/material.dart';
import 'package:nhagiare_mobile/features/domain/entities/properties/apartment.dart';
import 'package:nhagiare_mobile/features/domain/enums/apartment_types.dart';
import 'package:nhagiare_mobile/features/domain/enums/direction.dart';
import 'package:nhagiare_mobile/features/domain/enums/legal_document_status.dart';

import '../../../../../config/values/asset_image.dart';
import '../../../../domain/enums/furniture_status.dart';
import 'details.dart';

class ApartmentCard extends StatelessWidget {
  const ApartmentCard({required this.feature, super.key});
  final Apartment feature;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 4,
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        if (feature.apartmentType != null)
          Detail(
            iconAsset: Assets.home,
            title: "Loại căn hộ:",
            value: ApartmentTypes.getStringVi(feature.apartmentType!),
          ),
        if (feature.isHandOver != null)
          Detail(
            iconAsset: Assets.home,
            title: "Tình trạng:",
            value: feature.isHandOver! ? "Đã bàn giao" : "Chưa bàn giao",
          ),
        if (feature.numOfBedRooms != null)
          Detail(
            iconAsset: Assets.home,
            title: "Số phòng ngủ:",
            value: "${feature.numOfBedRooms} phòng",
          ),
        if (feature.furnitureStatus != null)
          Detail(
            iconAsset: Assets.home,
            title: "Tình trạng nội thất:",
            value: FurnitureStatus.getStringVi(feature.furnitureStatus!),
          ),
        if (feature.numOfToilets != null)
          Detail(
            iconAsset: Assets.home,
            title: "Số phòng vệ sinh:",
            value: "${feature.numOfToilets} phòng",
          ),
        if (feature.balconyDirection != null)
          Detail(
            iconAsset: Assets.home,
            title: "Hướng ban công:",
            value: Direction.getStringVi(feature.balconyDirection!),
          ),
        if (feature.block != null)
          Detail(
            iconAsset: Assets.home,
            title: "Tòa",
            value: feature.block.toString(),
          ),
        if (feature.floor != null)
          Detail(
            iconAsset: Assets.home,
            title: "Tầng:",
            value: feature.floor.toString(),
          ),
        if (feature.legalDocumentStatus != null)
          Detail(
            iconAsset: Assets.home,
            title: "Giấy tờ pháp lý:",
            value:
                LegalDocumentStatus.getStringVi(feature.legalDocumentStatus!),
          ),
        if (feature.apartmentNumber != null &&
            feature.showApartmentNumber != null &&
            feature.showApartmentNumber == true)
          Detail(
            iconAsset: Assets.home,
            title: "Số căn hộ",
            value: feature.apartmentNumber.toString(),
          ),
      ],
    );
  }
}
