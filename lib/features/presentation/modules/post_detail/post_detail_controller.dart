import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/real_estate_post.dart';
import 'package:nhagiare_mobile/features/presentation/modules/post_detail/widgets/motel_card.dart';
import 'package:nhagiare_mobile/features/presentation/modules/post_detail/widgets/office_card.dart';
import '../../../domain/entities/properties/apartment.dart';
import '../../../domain/entities/properties/house.dart';
import '../../../domain/entities/properties/land.dart';
import '../../../domain/entities/properties/motel.dart';
import '../../../domain/entities/properties/office.dart';
import '../../../domain/entities/properties/property_feature.dart';
import 'widgets/apartment_card.dart';
import 'widgets/house_card.dart';
import 'widgets/land_card.dart';

class PostDetailController extends GetxController {
  final RealEstatePostEntity post = Get.arguments as RealEstatePostEntity;
  PropertyFeature? feature;

  Widget getDetailCard() {
    feature = PropertyFeature.fromJson(post.typeId!, post.features!);
    if (feature is Apartment) {
      return ApartmentCard(feature: feature as Apartment);
    }
    // else if (feature is House) {
    //   return HouseCard(feature: feature as House);
    // } else if (feature is Land) {
    //   return LandCard(feature: feature as Land);
    // } else if (feature is Office) {
    //   return OfficeCard(feature: feature as Office);
    // } else if (feature is Motel) {
    //   return MotelCard(feature: feature as Motel);
    // }
    else {
      return const SizedBox();
    }
  }
}
