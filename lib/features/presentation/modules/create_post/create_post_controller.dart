import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/real_estate_post.dart';
import 'package:nhagiare_mobile/features/domain/entities/properties/apartment.dart';
import 'package:nhagiare_mobile/features/domain/entities/properties/house.dart';
import 'package:nhagiare_mobile/features/domain/entities/properties/land.dart';
import 'package:nhagiare_mobile/features/domain/entities/properties/motel.dart';
import 'package:nhagiare_mobile/features/domain/enums/apartment_types.dart';
import 'package:nhagiare_mobile/features/domain/enums/direction.dart';
import 'package:nhagiare_mobile/features/domain/enums/furniture_status.dart';
import 'package:nhagiare_mobile/features/domain/enums/land_types.dart';
import 'package:nhagiare_mobile/features/domain/enums/office_types.dart';
import 'package:nhagiare_mobile/features/domain/usecases/post/remote/create_post.dart';
import 'package:nhagiare_mobile/features/domain/usecases/post/remote/upload_images.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../injection_container.dart';
import '../../../domain/entities/properties/office.dart';
import '../../../domain/enums/house_types.dart';
import '../../../domain/enums/legal_document_status.dart';
import '../../../domain/enums/property_types.dart';

class CreatePostController extends GetxController {
  RxBool isLoading = false.obs;
  toggleIsLoading(bool value) {
    isLoading.value = value;
  }

  // create Post
  Future<void> createPost() async {
    toggleIsLoading(true);
    CreatePostsUseCase createPostsUseCase = sl<CreatePostsUseCase>();

    final dataState = await createPostsUseCase(params: getFinalPost());

    if (dataState is DataSuccess) {
      toggleIsLoading(false);
      Get.back();
      Get.snackbar(
        'Đăng bài thành công',
        'Vào mục quản lý tin để xem bài của bạn',
        backgroundColor: AppColors.green,
        colorText: Colors.white,
      );
    } else {
      toggleIsLoading(false);
      Get.snackbar(
        'Đăng bài thất bại',
        '',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  RealEstatePostEntity getFinalPost() {
    switch (selectedPropertyType.value!) {
      case PropertyTypes.motel:
        return createMotel();
      case PropertyTypes.apartment:
        return createApartment();
      case PropertyTypes.office:
        return createOffice();
      case PropertyTypes.house:
        return createHouse();
      case PropertyTypes.land:
        return createLand();
    }
  }

  RealEstatePostEntity createMotel() {
    return RealEstatePostEntity(
      typeId: "motel",
      unitId: "m2",
      title: title ?? "",
      description: description ?? "",
      price: motelPrice ?? "",
      deposit: motelDeposit != null ? int.parse(motelDeposit ?? "0") : null,
      area: double.parse(motelArea ?? "0"),
      address: null,
      images: const [
        "https://cdn.chotot.com/SXSnpDkjXu9UW0DxEjUAtBaVQ-sKQTdQcz6m8QaIDeg/preset:view/plain/f383d60848ae496a8464d9a8686970f4-2848018247746142852.jpg",
        "https://cdn.chotot.com/0cb0i8JTjoXyGNiGww76q5hsJTlbbwcs9bWhQfwPQrU/preset:view/plain/da4a1e0d0784c80a6560842120155652-2848018247795789418.jpg",
        "https://cdn.chotot.com/vZ9mSUUEcDwk-XEOP9hG9dIPAtOd9j5CSc_ARMPtOLQ/preset:view/plain/5ccb0c88de8a6198da298a375db9780a-2848018250111110762.jpg",
        "https://cdn.chotot.com/jlHI6xKmRuQGLaCWr5OglTO5PI1pDEhDKX7a1W1oN24/preset:view/plain/7769b3c0f8e54662c1b2b74c7451961a-2848018249642033796.jpg"
      ],
      features: Motel(
        motelWaterPrice,
        motelElectricPrice,
        motelSelectedFurnitureStatus.value,
      ).toJson(),
      isLease: isLease.value,
      isProSeller: isProSeller.value,
    );
  }

  RealEstatePostEntity createApartment() {
    return RealEstatePostEntity(
      typeId: "apartment",
      unitId: "m2",
      title: title ?? "",
      description: description ?? "",
      price: apartmentPrice,
      deposit: apartmentDeposit != null ? int.parse(apartmentDeposit!) : null,
      area: double.parse(apartmentArea!),
      address: null,
      images: const [
        "https://cdn.chotot.com/SXSnpDkjXu9UW0DxEjUAtBaVQ-sKQTdQcz6m8QaIDeg/preset:view/plain/f383d60848ae496a8464d9a8686970f4-2848018247746142852.jpg",
        "https://cdn.chotot.com/0cb0i8JTjoXyGNiGww76q5hsJTlbbwcs9bWhQfwPQrU/preset:view/plain/da4a1e0d0784c80a6560842120155652-2848018247795789418.jpg",
        "https://cdn.chotot.com/vZ9mSUUEcDwk-XEOP9hG9dIPAtOd9j5CSc_ARMPtOLQ/preset:view/plain/5ccb0c88de8a6198da298a375db9780a-2848018250111110762.jpg",
        "https://cdn.chotot.com/jlHI6xKmRuQGLaCWr5OglTO5PI1pDEhDKX7a1W1oN24/preset:view/plain/7769b3c0f8e54662c1b2b74c7451961a-2848018249642033796.jpg"
      ],
      features: Apartment(
        apartmentType.value,
        apartmentIsHandOver.value,
        int.parse(apartmentNumOfBedRooms ?? "0"),
        apartmentFurnitureStatus.value,
        int.parse(apartmentNumOfToilets ?? "0"),
        apartmentBalconyDirection.value.toString(),
        block,
        floor,
        apartmentLegalDocumentStatus.value,
        apartmentNumber,
        isShowapartmentNumber.value,
      ).toJson(),
      isLease: isLease.value,
      isProSeller: isProSeller.value,
    );
  }

  RealEstatePostEntity createOffice() {
    return RealEstatePostEntity(
      typeId: "office",
      unitId: "m2",
      title: title ?? "",
      description: description ?? "",
      price: officePrice,
      deposit: officeDeposit != null ? int.parse(officeDeposit!) : null,
      area: double.parse(officeArea ?? "0"),
      address: null,
      images: const [
        "https://cdn.chotot.com/SXSnpDkjXu9UW0DxEjUAtBaVQ-sKQTdQcz6m8QaIDeg/preset:view/plain/f383d60848ae496a8464d9a8686970f4-2848018247746142852.jpg",
        "https://cdn.chotot.com/0cb0i8JTjoXyGNiGww76q5hsJTlbbwcs9bWhQfwPQrU/preset:view/plain/da4a1e0d0784c80a6560842120155652-2848018247795789418.jpg",
        "https://cdn.chotot.com/vZ9mSUUEcDwk-XEOP9hG9dIPAtOd9j5CSc_ARMPtOLQ/preset:view/plain/5ccb0c88de8a6198da298a375db9780a-2848018250111110762.jpg",
        "https://cdn.chotot.com/jlHI6xKmRuQGLaCWr5OglTO5PI1pDEhDKX7a1W1oN24/preset:view/plain/7769b3c0f8e54662c1b2b74c7451961a-2848018249642033796.jpg"
      ],
      features: Office(
        officeType.value,
        officeIsFacade.value,
        officeMainDoorDirection.value,
        block,
        floor,
        officeLegalDocumentStatus.value,
        officeNumber,
        officeIsShowName.value,
        officeFurnitureStatus.value,
      ).toJson(),
      isLease: isLease.value,
      isProSeller: isProSeller.value,
    );
  }

  RealEstatePostEntity createHouse() {
    return RealEstatePostEntity(
      typeId: "house",
      unitId: "m2",
      title: title ?? "",
      description: description ?? "",
      price: housePrice,
      deposit: houseDeposit != null ? int.parse(houseDeposit!) : null,
      area: double.parse(houseArea!),
      address: null,
      images: const [
        "https://cdn.chotot.com/SXSnpDkjXu9UW0DxEjUAtBaVQ-sKQTdQcz6m8QaIDeg/preset:view/plain/f383d60848ae496a8464d9a8686970f4-2848018247746142852.jpg",
        "https://cdn.chotot.com/0cb0i8JTjoXyGNiGww76q5hsJTlbbwcs9bWhQfwPQrU/preset:view/plain/da4a1e0d0784c80a6560842120155652-2848018247795789418.jpg",
        "https://cdn.chotot.com/vZ9mSUUEcDwk-XEOP9hG9dIPAtOd9j5CSc_ARMPtOLQ/preset:view/plain/5ccb0c88de8a6198da298a375db9780a-2848018250111110762.jpg",
        "https://cdn.chotot.com/jlHI6xKmRuQGLaCWr5OglTO5PI1pDEhDKX7a1W1oN24/preset:view/plain/7769b3c0f8e54662c1b2b74c7451961a-2848018249642033796.jpg"
      ],
      features: House(
        houseType.value,
        int.parse(houseNumOfBedRooms ?? "0"),
        houseIsWidensTowardsTheBack.value,
        int.parse(houseNumOfToilets ?? "0"),
        int.parse(houseNumOfFloors ?? "0"),
        houseMainDoorDirection.value,
        double.parse(houseWidth ?? "0"),
        double.parse(houseLength ?? "0"),
        double.parse(houseAreaUsed ?? "0"),
        houseLegalDocumentStatus.value,
        houseNumber,
        isShowHouseNumber.value,
        houseFurnitureStatus.value,
        houseHasWideAlley.value,
        houseIsFacade.value,
      ).toJson(),
      isLease: isLease.value,
      isProSeller: isProSeller.value,
    );
  }

  RealEstatePostEntity createLand() {
    return RealEstatePostEntity(
      typeId: "land",
      unitId: "ha",
      title: title ?? "",
      description: description ?? "",
      price: landPrice,
      deposit: landDeposit != null ? int.parse(landDeposit!) : null,
      area: double.parse(landArea!),
      address: null,
      images: const [
        "https://cdn.chotot.com/SXSnpDkjXu9UW0DxEjUAtBaVQ-sKQTdQcz6m8QaIDeg/preset:view/plain/f383d60848ae496a8464d9a8686970f4-2848018247746142852.jpg",
        "https://cdn.chotot.com/0cb0i8JTjoXyGNiGww76q5hsJTlbbwcs9bWhQfwPQrU/preset:view/plain/da4a1e0d0784c80a6560842120155652-2848018247795789418.jpg",
        "https://cdn.chotot.com/vZ9mSUUEcDwk-XEOP9hG9dIPAtOd9j5CSc_ARMPtOLQ/preset:view/plain/5ccb0c88de8a6198da298a375db9780a-2848018250111110762.jpg",
        "https://cdn.chotot.com/jlHI6xKmRuQGLaCWr5OglTO5PI1pDEhDKX7a1W1oN24/preset:view/plain/7769b3c0f8e54662c1b2b74c7451961a-2848018249642033796.jpg"
      ],
      features: Land(
        landType.value,
        landLotCode,
        landSubdivisionName,
        landIsFacade.value,
        landHasWideAlley.value,
        landIsWidensTowardsTheBack.value,
        landDirection.value,
        double.parse(landWidth ?? "0"),
        double.parse(landLength ?? "0"),
        landLegalDocumentStatus.value,
        isShowLandLotCode.value,
      ).toJson(),
      isLease: isLease.value,
      isProSeller: isProSeller.value,
    );
  }

  Future<List<String>> uploadImages() async {
    UploadImagessUseCase uploadImagessUseCase = sl<UploadImagessUseCase>();

    final dataState = await uploadImagessUseCase(params: photos);

    if (dataState is DataSuccess) {
      toggleIsLoading(false);
      print(dataState.data!);
      return dataState.data!;
    } else {
      toggleIsLoading(false);
      return [];
    }
  }

  // card choose type property
  Rxn<PropertyTypes> selectedPropertyType = Rxn(null);
  bool isReachLimitPost = false;
  Rx<bool> isLease = false.obs;

  void changeSelectedProperty(PropertyTypes value) {
    selectedPropertyType.value = value;
  }

  void setIsLease(bool value) {
    isLease.value = value;
    if (!value && selectedPropertyType.value == PropertyTypes.motel) {
      selectedPropertyType.value = Rxn(null).value;
    }
  }

  // card choose type of user
  RxBool isProSeller = true.obs;
  void setRole(bool value) {
    isProSeller.value = value;
  }

  // card post info
  final titleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  String? title;
  String? description;

  // dia chi, hinh anh
  final apartmentNameTextController = TextEditingController();
  final addressTextController = TextEditingController();
  final blockTextController = TextEditingController();
  final floorTextController = TextEditingController();
  String? apartmentName;
  String? block;
  String? floor;
  String? address;

  // hinh anh
  bool? photoController;

  void checkLengthPhoto() {
    int length = photos.length + imageUrlList.length;
    if (length >= 3 && length <= 12) {
      photoController = true;
    } else {
      photoController = false;
    }
    update();
  }

  List<File> photos = [];
  List<String> imageUrlList = [];
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedImages = await _picker.pickMultiImage();
    for (int i = 0; i < pickedImages.length; i++) {
      photos.add(File(pickedImages[i].path));
    }
    checkLengthPhoto();
    update();
  }

  Future imgFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      photos.add(File(image.path));
      checkLengthPhoto();
      update();
    }
  }

  void deleteImage(int index) {
    if (index < imageUrlList.length) {
      imageUrlList.removeAt(index);
    } else {
      photos.removeAt(index - imageUrlList.length);
    }
    checkLengthPhoto();
    update();
  }

  // Motel ======================================================
  // thong tin chi tiet
  double? motelWaterPrice;
  double? motelElectricPrice;
  final motelWaterPriceTC = TextEditingController();
  final motelElectricPriceTC = TextEditingController();

  // Dien tich , gia tro
  final motelAreaTC = TextEditingController();
  final motelPriceTC = TextEditingController();
  final motelDepositTC = TextEditingController();
  String? motelArea;
  String? motelPrice;
  String? motelDeposit;

  // thong tin khac
  Rxn<FurnitureStatus> motelSelectedFurnitureStatus = Rxn(null);

  void setFurnitureStatus(FurnitureStatus value) {
    motelSelectedFurnitureStatus.value = value;
  }

  // Office ======================================================
  final officeNumberTC = TextEditingController();
  String? officeNumber;
  RxBool officeIsShowName = false.obs;
  void setofficeIsShowName(bool value) {
    officeIsShowName.value = value;
  }

  // thong tin chi tiet
  Rxn<OfficeTypes> officeType = Rxn(null);
  Rxn<Direction> officeMainDoorDirection = Rxn(null);

  void setOfficeType(OfficeTypes value) {
    officeType.value = value;
  }

  void setOfficeMainDoorDirection(Direction value) {
    officeMainDoorDirection.value = value;
  }

  // Dien tich , gia tro
  final officeAreaTC = TextEditingController();
  final officePriceTC = TextEditingController();
  final officeDepositTC = TextEditingController();
  String? officeArea;
  String? officePrice;
  String? officeDeposit;
  // thong tin khac
  Rxn<LegalDocumentStatus> officeLegalDocumentStatus = Rxn(null);
  Rxn<FurnitureStatus> officeFurnitureStatus = Rxn(null);
  RxBool officeIsFacade = false.obs;

  void setOfficeLegalDocumentStatus(LegalDocumentStatus value) {
    officeLegalDocumentStatus.value = value;
  }

  void setOfficeFurnitureStatus(FurnitureStatus value) {
    officeFurnitureStatus.value = value;
  }

  void setOfficeIsFacade(bool value) {
    officeIsFacade.value = value;
  }

  // Land ======================================================
  final landSubdivisionNameTC = TextEditingController();
  final landLotCodeTC = TextEditingController();
  String? landSubdivisionName;
  String? landLotCode;
  RxBool isShowLandLotCode = false.obs;

  void setIsShowLandLotCode(bool value) {
    isShowLandLotCode.value = value;
  }

  Rxn<LandTypes> landType = Rxn(null);
  Rxn<Direction> landDirection = Rxn(null);

  void setLandType(LandTypes value) {
    landType.value = value;
  }

  void setLandDirection(Direction value) {
    landDirection.value = value;
  }

  // dien tich & gia
  final landAreaTC = TextEditingController();
  final landPriceTC = TextEditingController();
  final landDepositTC = TextEditingController();
  final landWidthTC = TextEditingController();
  final landLengthTC = TextEditingController();
  String? landArea;
  String? landPrice;
  String? landDeposit;
  String? landWidth;
  String? landLength;

  // thong tin khac
  Rxn<LegalDocumentStatus> landLegalDocumentStatus = Rxn(null);

  void setLandLegalDocumentStatus(LegalDocumentStatus value) {
    landLegalDocumentStatus.value = value;
  }

  RxBool landIsFacade = false.obs;
  RxBool landHasWideAlley = false.obs;
  RxBool landIsWidensTowardsTheBack = false.obs;

  void setLandIsFacade(bool value) {
    landIsFacade.value = value;
  }

  void setLandHasWideAlley(bool value) {
    landHasWideAlley.value = value;
  }

  void setLandIsWidensTowardsTheBack(bool value) {
    landIsWidensTowardsTheBack.value = value;
  }

  // house ======================================================
  Rxn<HouseTypes> houseType = Rxn(null);
  void setHouseType(HouseTypes value) {
    houseType.value = value;
  }

  String? houseNumOfBedRooms;
  final houseNumOfBedRoomsTC = TextEditingController();

  String? houseNumOfToilets;
  final houseNumOfToiletsTC = TextEditingController();

  String? houseNumOfFloors;
  final houseNumOfFloorsTC = TextEditingController();

  Rxn<Direction> houseMainDoorDirection = Rxn(null);
  void setHouseMainDoorDirection(Direction value) {
    houseMainDoorDirection.value = value;
  }

  String? houseNumber;
  final houseNumberTC = TextEditingController();

  RxBool isShowHouseNumber = false.obs;
  void setIsShowHouseNumber(bool value) {
    isShowHouseNumber.value = value;
  }

  // dien tich & gia
  final houseAreaTC = TextEditingController();
  final houseAreaUsedTC = TextEditingController();
  final housePriceTC = TextEditingController();
  final houseDepositTC = TextEditingController();
  final houseWidthTC = TextEditingController();
  final houseLengthTC = TextEditingController();
  String? houseArea;
  String? houseAreaUsed;
  String? housePrice;
  String? houseDeposit;
  String? houseWidth;
  String? houseLength;

  // thong tin khac
  Rxn<LegalDocumentStatus> houseLegalDocumentStatus = Rxn(null);
  Rxn<FurnitureStatus> houseFurnitureStatus = Rxn(null);
  void sethouseLegalDocumentStatus(LegalDocumentStatus value) {
    houseLegalDocumentStatus.value = value;
  }

  void setHouseFurnitureStatus(FurnitureStatus value) {
    houseFurnitureStatus.value = value;
  }

  RxBool houseIsFacade = false.obs;
  RxBool houseHasWideAlley = false.obs;
  RxBool houseIsWidensTowardsTheBack = false.obs;

  void sethouseIsFacade(bool value) {
    houseIsFacade.value = value;
  }

  void sethouseHasWideAlley(bool value) {
    houseHasWideAlley.value = value;
  }

  void sethouseIsWidensTowardsTheBack(bool value) {
    houseIsWidensTowardsTheBack.value = value;
  }

  // apartment ======================================================
  RxBool apartmentIsHandOver = true.obs;
  void setApartmentIsHandOver(bool value) {
    apartmentIsHandOver.value = value;
  }

  Rxn<ApartmentTypes> apartmentType = Rxn(null);
  void setapartmentType(ApartmentTypes value) {
    apartmentType.value = value;
  }

  String? apartmentNumOfBedRooms;
  final apartmentNumOfBedRoomsTC = TextEditingController();

  String? apartmentNumOfToilets;
  final apartmentNumOfToiletsTC = TextEditingController();

  Rxn<Direction> apartmentBalconyDirection = Rxn(null);
  void setapartmentBalconyDirection(Direction value) {
    apartmentBalconyDirection.value = value;
  }

  String? apartmentNumber;
  final apartmentNumberTC = TextEditingController();

  RxBool isShowapartmentNumber = false.obs;
  void setIsShowapartmentNumber(bool value) {
    isShowapartmentNumber.value = value;
  }

  // dien tich & gia
  final apartmentAreaTC = TextEditingController();
  final apartmentPriceTC = TextEditingController();
  final apartmentDepositTC = TextEditingController();
  String? apartmentArea;
  String? apartmentPrice;
  String? apartmentDeposit;

  // thong tin khac
  Rxn<LegalDocumentStatus> apartmentLegalDocumentStatus = Rxn(null);
  Rxn<FurnitureStatus> apartmentFurnitureStatus = Rxn(null);
  void setapartmentLegalDocumentStatus(LegalDocumentStatus value) {
    apartmentLegalDocumentStatus.value = value;
  }

  void setapartmentFurnitureStatus(FurnitureStatus value) {
    apartmentFurnitureStatus.value = value;
  }

  RxBool apartmentIsCorner = false.obs;

  void setapartmentIsCorner(bool value) {
    apartmentIsCorner.value = value;
  }
}
