import 'package:nhagiare_mobile/core/utils/query_builder.dart';
import '../../enums/apartment_types.dart';
import '../../enums/direction.dart';
import '../../enums/furniture_status.dart';
import '../../enums/house_types.dart';
import '../../enums/land_types.dart';
import '../../enums/legal_document_status.dart';
import '../../enums/office_types.dart';
import '../../enums/posted_by.dart';

class PostFilter {
  String? textSearch;
  OrderBy? orderBy;
  String? postedByUserID;
  bool? isLease;
  int? from;
  int? to;
  int? minPrice;
  int? maxPrice;
  int? minArea;
  int? maxArea;
  int? provinceCode;
  PostedBy? postedBy;

  PostFilter({
    this.textSearch,
    this.isLease,
    this.postedByUserID,
    this.orderBy,
    this.from,
    this.to,
    this.minPrice,
    this.maxPrice,
    this.minArea,
    this.maxArea,
    this.provinceCode,
    required this.postedBy,
  }) : assert((from != null && to != null && from < to) ||
            (from == null && to == null));

  void setTextSearch(String text) {
    textSearch = text;
  }

  void setOrderBy(OrderBy orderBy) {
    this.orderBy = orderBy;
  }

  void setIsLease(bool isLease) {
    this.isLease = isLease;
  }

  void setPostedBy(PostedBy postedBy) {
    this.postedBy = postedBy;
  }

  void setProvinceCode(int provinceCode) {
    this.provinceCode = provinceCode;
  }
}

class ApartmentFilter extends PostFilter {
  bool? isHandedOver;
  List<ApartmentTypes> apartmentTypes;
  bool? isCorner;
  List<int> numOfBedrooms;
  List<Direction> mainDoorDirections;
  List<Direction> balconyDirections;
  List<LegalDocumentStatus> legalStatus;
  List<FurnitureStatus> furnitureStatus;

  ApartmentFilter({
    super.textSearch,
    super.postedByUserID,
    bool? isLease,
    required super.orderBy,
    required int super.from,
    required int super.to,
    required int super.minPrice,
    required int super.maxPrice,
    required int super.minArea,
    required int super.maxArea,
    required super.postedBy,
    this.isHandedOver,
    this.apartmentTypes = const [],
    this.isCorner,
    this.numOfBedrooms = const [],
    this.mainDoorDirections = const [],
    this.balconyDirections = const [],
    this.legalStatus = const [],
    this.furnitureStatus = const [],
  });
}

class HouseFilter extends PostFilter {
  bool? hasWideAlley;
  bool? isFacade;
  bool? isWidensTowardsTheBack;
  List<HouseTypes> houseTypes;
  List<int> numOfBedrooms;
  List<Direction> mainDoorDirections;
  List<LegalDocumentStatus> legalStatus;
  List<FurnitureStatus> furnitureStatus;

  HouseFilter({
    super.postedByUserID,
    super.textSearch,
    bool? isLease,
    required super.orderBy,
    required int super.from,
    required int super.to,
    required int super.minPrice,
    required int super.maxPrice,
    required int super.minArea,
    required int super.maxArea,
    required super.postedBy,
    this.hasWideAlley,
    this.isFacade,
    this.isWidensTowardsTheBack,
    this.houseTypes = const [],
    this.numOfBedrooms = const [],
    this.mainDoorDirections = const [],
    this.legalStatus = const [],
    this.furnitureStatus = const [],
  });
}

class LandFilter extends PostFilter {
  bool? hasWideAlley;
  bool? isFacade;
  bool? isWidensTowardsTheBack;
  List<LandTypes> landTypes;
  List<Direction> landDirections;
  List<LegalDocumentStatus> legalStatus;

  LandFilter({
    super.textSearch,
    super.postedByUserID,
    bool? isLease,
    required super.orderBy,
    required int super.from,
    required int super.to,
    required int super.minPrice,
    required int super.maxPrice,
    required int super.minArea,
    required int super.maxArea,
    required super.postedBy,
    this.hasWideAlley,
    this.isFacade,
    this.isWidensTowardsTheBack,
    this.landTypes = const [],
    this.landDirections = const [],
    this.legalStatus = const [],
  });
}

class OfficeFilter extends PostFilter {
  List<OfficeTypes> officeTypes;
  List<Direction> mainDoorDirections;
  List<LegalDocumentStatus> legalStatus;
  List<FurnitureStatus> furnitureStatus;

  OfficeFilter({
    super.postedByUserID,
    super.textSearch,
    bool? isLease,
    required super.orderBy,
    required int super.from,
    required int super.to,
    required int super.minPrice,
    required int super.maxPrice,
    required int super.minArea,
    required int super.maxArea,
    required super.postedBy,
    this.officeTypes = const [],
    this.mainDoorDirections = const [],
    this.legalStatus = const [],
    this.furnitureStatus = const [],
  });
}

class MotelFilter extends PostFilter {
  List<FurnitureStatus> furnitureStatus;

  MotelFilter({
    super.textSearch,
    super.postedByUserID,
    bool? isLease,
    required super.orderBy,
    required int super.from,
    required int super.to,
    required int super.minPrice,
    required int super.maxPrice,
    required int super.minArea,
    required int super.maxArea,
    required super.postedBy,
    this.furnitureStatus = const [],
  });
}
