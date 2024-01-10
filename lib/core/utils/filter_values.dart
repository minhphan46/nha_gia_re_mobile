import 'package:nhagiare_mobile/features/domain/enums/apartment_types.dart';

import '../../features/domain/enums/direction.dart';
import '../../features/domain/enums/furniture_status.dart';
import '../../features/domain/enums/house_types.dart';
import '../../features/domain/enums/land_types.dart';
import '../../features/domain/enums/legal_document_status.dart';
import '../../features/domain/enums/office_types.dart';
import '../../features/domain/enums/property_types.dart';

class FilterValues {
  List<String> categorys = [
    "Tất cả bất động sản",
    ...PropertyTypes.values.map((e) => e.getStringVi()),
  ];

// sort card
  List<String> sortTypes = [
    "Liên quan",
    "Tin mới trước",
    "Giá thấp trước",
  ];
// posted card
  List<String> postedBy = [
    "Cá nhân",
    "Môi giới",
  ];
// Price range
  double lowerPrice = 0;
  double upperPrice = 3000000000;
// Area range
  double lowerArea = 0;
  double upperArea = 10000;

// Specifications (Thông số kĩ thuật)
  // Can ho, chung cu
  List<String> apartmentStatus = [
    "Tất cả",
    "Chưa bàn giao",
    "Đã bàn giao",
  ];

  List<String> apartmentTypes =
      ApartmentTypes.values.map((e) => ApartmentTypes.getStringVi(e)).toList();

  List<String> apartmentCharacteristics = [
    "Tất cả",
    "Căn góc",
  ];
  List<String> bedroomNumber = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "Nhiều hơn 10",
  ];
  List<String> mainDirection =
      Direction.values.map((e) => Direction.getStringValueVi(e)).toList();
  List<String> legalDocuments = LegalDocumentStatus.values
      .map((e) => LegalDocumentStatus.getStringVi(e))
      .toList();
  List<String> interiorStatus = FurnitureStatus.values
      .map((e) => FurnitureStatus.getStringVi(e))
      .toList();
  // Nha o
  List<String> residentialTypes =
      HouseTypes.values.map((e) => HouseTypes.getStringVi(e)).toList();

  List<String> houseCharacteristics = [
    "Hẽm xe hơi",
    "Mặt tiền",
    "Nở hậu",
  ];
  // Đất
  List<String> typeOfLand =
      LandTypes.values.map((e) => LandTypes.getStringVi(e)).toList();
  // van phong
  List<String> officeType =
      OfficeTypes.values.map((e) => OfficeTypes.getStringVi(e)).toList();
}
