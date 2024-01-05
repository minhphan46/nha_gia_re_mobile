import '../../../../core/utils/query_builder.dart';
import '../../enums/apartment_types.dart';
import '../../enums/direction.dart';
import '../../enums/furniture_status.dart';
import '../../enums/house_types.dart';
import '../../enums/land_types.dart';
import '../../enums/legal_document_status.dart';
import '../../enums/office_types.dart';
import '../../enums/order_by_types.dart';
import '../../enums/posted_by.dart';

class PostFilter {
  String? textSearch;
  OrderByTypes? orderBy;
  String? postedByUserID;
  bool? isLease;
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
    this.minPrice,
    this.maxPrice,
    this.minArea,
    this.maxArea,
    this.provinceCode = 0,
    required this.postedBy,
  });

  void setTextSearch(String text) {
    textSearch = text;
  }

  void setOrderBy(OrderByTypes orderBy) {
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

  //toString
  @override
  String toString() {
    return 'PostFilter{textSearch: $textSearch, orderBy: $orderBy, postedByUserID: $postedByUserID, isLease: $isLease, minPrice: $minPrice, maxPrice: $maxPrice, minArea: $minArea, maxArea: $maxArea, provinceCode: $provinceCode, postedBy: $postedBy}';
  }

  String get preParam => "post_features->>";

  String toParam() {
    return '';
  }

  String getListValue(List<dynamic> list) {
    String value = '';
    for (int i = 0; i < list.length; i++) {
      if (i != 0) {
        value += ',';
      }
      value += "'${list[i].toString()}'";
    }
    return value;
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

  @override
  String toString() {
    String value = super.toString();
    value +=
        '\nApartmentFilter{isHandedOver: $isHandedOver, apartmentTypes: $apartmentTypes, isCorner: $isCorner, numOfBedrooms: $numOfBedrooms, mainDoorDirections: $mainDoorDirections, balconyDirections: $balconyDirections, legalStatus: $legalStatus, furnitureStatus: $furnitureStatus}';
    return value;
  }

  @override
  String toParam() {
    QueryBuilder queryBuilder = QueryBuilder();
    if (isHandedOver != null) {
      queryBuilder.addQuery(
          '${super.preParam}is_hand_over', Operation.equals, "'$isHandedOver'");
    }
    if (isCorner != null) {
      queryBuilder.addQuery(
          '${super.preParam}is_corner', Operation.equals, "'$isCorner'");
    }
    if (apartmentTypes.isNotEmpty) {
      queryBuilder.addQuery('${super.preParam}apartment_type',
          Operation.inValue, super.getListValue(apartmentTypes));
    }
    if (numOfBedrooms.isNotEmpty) {
      queryBuilder.addQuery('${super.preParam}num_of_bedrooms',
          Operation.inValue, super.getListValue(numOfBedrooms));
    }
    if (mainDoorDirections.isNotEmpty) {
      queryBuilder.addQuery('${super.preParam}main_door_direction',
          Operation.inValue, super.getListValue(mainDoorDirections));
    }
    if (balconyDirections.isNotEmpty) {
      queryBuilder.addQuery('${super.preParam}balcony_direction',
          Operation.inValue, super.getListValue(balconyDirections));
    }
    if (legalStatus.isNotEmpty) {
      queryBuilder.addQuery('${super.preParam}legal_status', Operation.inValue,
          super.getListValue(legalStatus));
    }
    if (furnitureStatus.isNotEmpty) {
      queryBuilder.addQuery('${super.preParam}furniture_status',
          Operation.inValue, super.getListValue(furnitureStatus));
    }
    return queryBuilder.buildParam();
  }
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

  @override
  String toString() {
    String value = super.toString();
    value +=
        '\nHouseFilter{hasWideAlley: $hasWideAlley, isFacade: $isFacade, isWidensTowardsTheBack: $isWidensTowardsTheBack, houseTypes: $houseTypes, numOfBedrooms: $numOfBedrooms, mainDoorDirections: $mainDoorDirections, legalStatus: $legalStatus, furnitureStatus: $furnitureStatus}';
    return value;
  }
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

  @override
  String toString() {
    String value = super.toString();
    value +=
        '\nLandFilter{hasWideAlley: $hasWideAlley, isFacade: $isFacade, isWidensTowardsTheBack: $isWidensTowardsTheBack, landTypes: $landTypes, landDirections: $landDirections, legalStatus: $legalStatus}';
    return value;
  }
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

  @override
  String toString() {
    String value = super.toString();
    value +=
        '\nOfficeFilter{officeTypes: $officeTypes, mainDoorDirections: $mainDoorDirections, legalStatus: $legalStatus, furnitureStatus: $furnitureStatus}';
    return value;
  }
}

class MotelFilter extends PostFilter {
  List<FurnitureStatus> furnitureStatus;

  MotelFilter({
    super.textSearch,
    super.postedByUserID,
    bool? isLease,
    required super.orderBy,
    required int super.minPrice,
    required int super.maxPrice,
    required int super.minArea,
    required int super.maxArea,
    required super.postedBy,
    this.furnitureStatus = const [],
  });

  @override
  String toString() {
    String value = super.toString();
    value += '\nMotelFilter{furnitureStatus: $furnitureStatus}';
    return value;
  }
}
