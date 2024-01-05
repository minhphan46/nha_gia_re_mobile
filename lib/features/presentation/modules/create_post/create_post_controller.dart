import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nhagiare_mobile/core/resources/pair.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/address.dart';
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
import 'package:nhagiare_mobile/features/domain/usecases/address/get_district_names.dart';
import 'package:nhagiare_mobile/features/domain/usecases/address/get_ward_names.dart';
import 'package:nhagiare_mobile/features/domain/usecases/post/remote/create_post.dart';
import 'package:nhagiare_mobile/features/domain/usecases/post/remote/upload_images.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../injection_container.dart';
import '../../../domain/entities/properties/office.dart';
import '../../../domain/enums/house_types.dart';
import '../../../domain/enums/legal_document_status.dart';
import '../../../domain/enums/property_types.dart';
import '../../../domain/usecases/address/get_province_names.dart';

class CreatePostController extends GetxController {
  RxBool isLoading = false.obs;
  toggleIsLoading(bool value) {
    isLoading.value = value;
  }

  Rxn<RealEstatePostEntity?> post = Rxn(null);

  @override
  onInit() {
    super.onInit();
    if (Get.arguments != null) {
      post.value = Get.arguments as RealEstatePostEntity;
      setPostEdit(post.value!);
    }
  }

  // create Post
  Future<void> createPost() async {
    toggleIsLoading(true);
    CreatePostsUseCase createPostsUseCase = sl<CreatePostsUseCase>();

    post.value = await getFinalPost();

    final dataState = await createPostsUseCase(params: post.value);

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

  Future<RealEstatePostEntity> getFinalPost() async {
    List<String> images = await uploadImages();
    switch (selectedPropertyType.value!) {
      case PropertyTypes.motel:
        return createMotel(images);
      case PropertyTypes.apartment:
        return createApartment(images);
      case PropertyTypes.office:
        return createOffice(images);
      case PropertyTypes.house:
        return createHouse(images);
      case PropertyTypes.land:
        return createLand(images);
    }
  }

  RealEstatePostEntity createMotel(List<String> images) {
    return RealEstatePostEntity(
      typeId: "motel",
      unitId: "m2",
      title: title ?? "",
      description: description ?? "",
      price: motelPrice ?? "",
      deposit: motelDeposit != null ? int.parse(motelDeposit ?? "0") : null,
      area: double.parse(motelArea ?? "0"),
      address: postAddress,
      images: images,
      features: Motel(
        motelWaterPrice,
        motelElectricPrice,
        motelSelectedFurnitureStatus.value,
      ).toJson(),
      isLease: isLease.value,
      isProSeller: isProSeller.value,
    );
  }

  RealEstatePostEntity createApartment(List<String> images) {
    return RealEstatePostEntity(
      typeId: "apartment",
      unitId: "m2",
      title: title ?? "",
      description: description ?? "",
      price: apartmentPrice,
      deposit: apartmentDeposit != null ? int.parse(apartmentDeposit!) : null,
      area: double.parse(apartmentArea!),
      address: postAddress,
      images: images,
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

  RealEstatePostEntity createOffice(List<String> images) {
    return RealEstatePostEntity(
      typeId: "office",
      unitId: "m2",
      title: title ?? "",
      description: description ?? "",
      price: officePrice,
      deposit: officeDeposit != null ? int.parse(officeDeposit!) : null,
      area: double.parse(officeArea ?? "0"),
      address: postAddress,
      images: images,
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

  RealEstatePostEntity createHouse(List<String> images) {
    return RealEstatePostEntity(
      typeId: "house",
      unitId: "m2",
      title: title ?? "",
      description: description ?? "",
      price: housePrice,
      deposit: houseDeposit != null ? int.parse(houseDeposit!) : null,
      area: double.parse(houseArea!),
      address: postAddress,
      images: images,
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

  RealEstatePostEntity createLand(List<String> images) {
    return RealEstatePostEntity(
      typeId: "land",
      unitId: "ha",
      title: title ?? "",
      description: description ?? "",
      price: landPrice,
      deposit: landDeposit != null ? int.parse(landDeposit!) : null,
      area: double.parse(landArea!),
      address: postAddress,
      images: images,
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
      return dataState.data!;
    } else {
      toggleIsLoading(false);
      return [];
    }
  }

  void setPostEdit(RealEstatePostEntity post) {
    print(post);
    if (post.isLease != null) {
      setIsLease(post.isLease!);
    }
    if (post.typeId != null) {
      changeSelectedProperty(PropertyTypes.parse(post.typeId!));
    }
    if (post.isProSeller != null) {
      isProSeller.value = post.isProSeller!;
    }
    if (post.title != null) {
      title = post.title!;
      titleTextController.text = post.title!;
    }
    if (post.description != null) {
      description = post.description!;
      descriptionTextController.text = post.description!;
    }
    if (post.address != null) {
      postAddress = post.address!;
      addressTextController.text = post.address!.getDetailAddress();
    }
    if (post.images != null) {
      imageUrlList = post.images!;
    }
    if (post.features != null) {
      switch (post.typeId) {
        case "motel":
          setMotelEdit(post);
          break;
        case "apartment":
          setApartmentEdit(post);
          break;
        case "office":
          setOfficeEdit(post);
          break;
        case "house":
          setHouseEdit(post);
          break;
        case "land":
          setLandEdit(post);
          break;
      }
    }
  }

  void setMotelEdit(RealEstatePostEntity post) {
    if (post.features!['waterPrice'] != null) {
      motelWaterPrice = post.features!['waterPrice'];
      motelWaterPriceTC.text = post.features!['waterPrice'].toString();
    }
    if (post.features!['electricPrice'] != null) {
      motelElectricPrice = post.features!['electricPrice'];
      motelElectricPriceTC.text = post.features!['electricPrice'].toString();
    }
    if (post.features!['furnitureStatus'] != null) {
      motelSelectedFurnitureStatus.value =
          FurnitureStatus.parse(post.features!['furnitureStatus']);
    }
    if (post.features!['area'] != null) {
      motelArea = post.features!['area'].toString();
      motelAreaTC.text = post.features!['area'].toString();
    }
    if (post.features!['price'] != null) {
      motelPrice = post.features!['price'].toString();
      motelPriceTC.text = post.features!['price'].toString();
    }
    if (post.features!['deposit'] != null) {
      motelDeposit = post.features!['deposit'].toString();
      motelDepositTC.text = post.features!['deposit'].toString();
    }
  }

  void setApartmentEdit(RealEstatePostEntity post) {
    if (post.features!['type'] != null) {
      apartmentType.value = ApartmentTypes.parse(post.features!['type']);
    }
    if (post.features!['isHandOver'] != null) {
      apartmentIsHandOver.value = post.features!['isHandOver'];
    }
    if (post.features!['numOfBedRooms'] != null) {
      apartmentNumOfBedRooms = post.features!['numOfBedRooms'].toString();
      apartmentNumOfBedRoomsTC.text =
          post.features!['numOfBedRooms'].toString();
    }
    if (post.features!['numOfToilets'] != null) {
      apartmentNumOfToilets = post.features!['numOfToilets'].toString();
      apartmentNumOfToiletsTC.text = post.features!['numOfToilets'].toString();
    }
    if (post.features!['balconyDirection'] != null) {
      apartmentBalconyDirection.value =
          Direction.parse(post.features!['balconyDirection']);
    }
    if (post.features!['number'] != null) {
      apartmentNumber = post.features!['number'];
      apartmentNumberTC.text = post.features!['number'];
    }
    if (post.features!['isShowName'] != null) {
      isShowapartmentNumber.value = post.features!['isShowName'];
    }
    if (post.features!['area'] != null) {
      apartmentArea = post.features!['area'].toString();
      apartmentAreaTC.text = post.features!['area'].toString();
    }
    if (post.features!['price'] != null) {
      apartmentPrice = post.features!['price'].toString();
      apartmentPriceTC.text = post.features!['price'].toString();
    }
    if (post.features!['deposit'] != null) {
      apartmentDeposit = post.features!['deposit'].toString();
      apartmentDepositTC.text = post.features!['deposit'].toString();
    }
    if (post.features!['furnitureStatus'] != null) {
      apartmentFurnitureStatus.value =
          FurnitureStatus.parse(post.features!['furnitureStatus']);
    }
    if (post.features!['legalDocumentStatus'] != null) {
      apartmentLegalDocumentStatus.value =
          LegalDocumentStatus.parse(post.features!['legalDocumentStatus']);
    }
    if (post.features!['isCorner'] != null) {
      apartmentIsCorner.value = post.features!['isCorner'];
    }
  }

  void setOfficeEdit(RealEstatePostEntity post) {
    if (post.features!['type'] != null) {
      officeType.value = OfficeTypes.parse(post.features!['type']);
    }
    if (post.features!['isFacade'] != null) {
      officeIsFacade.value = post.features!['isFacade'];
    }
    if (post.features!['mainDoorDirection'] != null) {
      officeMainDoorDirection.value =
          Direction.parse(post.features!['mainDoorDirection']);
    }
    if (post.features!['number'] != null) {
      officeNumber = post.features!['number'];
      officeNumberTC.text = post.features!['number'];
    }
    if (post.features!['isShowName'] != null) {
      officeIsShowName.value = post.features!['isShowName'];
    }
    if (post.features!['area'] != null) {
      officeArea = post.features!['area'].toString();
      officeAreaTC.text = post.features!['area'].toString();
    }
    if (post.features!['price'] != null) {
      officePrice = post.features!['price'].toString();
      officePriceTC.text = post.features!['price'].toString();
    }
    if (post.features!['deposit'] != null) {
      officeDeposit = post.features!['deposit'].toString();
      officeDepositTC.text = post.features!['deposit'].toString();
    }
    if (post.features!['furnitureStatus'] != null) {
      officeFurnitureStatus.value =
          FurnitureStatus.parse(post.features!['furnitureStatus']);
    }
    if (post.features!['legalDocumentStatus'] != null) {
      officeLegalDocumentStatus.value =
          LegalDocumentStatus.parse(post.features!['legalDocumentStatus']);
    }
  }

  void setHouseEdit(RealEstatePostEntity post) {
    if (post.features!['type'] != null) {
      houseType.value = HouseTypes.parse(post.features!['type']);
    }
    if (post.features!['numOfBedRooms'] != null) {
      houseNumOfBedRooms = post.features!['numOfBedRooms'].toString();
      houseNumOfBedRoomsTC.text = post.features!['numOfBedRooms'].toString();
    }
    if (post.features!['numOfToilets'] != null) {
      houseNumOfToilets = post.features!['numOfToilets'].toString();
      houseNumOfToiletsTC.text = post.features!['numOfToilets'].toString();
    }
    if (post.features!['numOfFloors'] != null) {
      houseNumOfFloors = post.features!['numOfFloors'].toString();
      houseNumOfFloorsTC.text = post.features!['numOfFloors'].toString();
    }
    if (post.features!['mainDoorDirection'] != null) {
      houseMainDoorDirection.value =
          Direction.parse(post.features!['mainDoorDirection']);
    }
    if (post.features!['number'] != null) {
      houseNumber = post.features!['number'];
      houseNumberTC.text = post.features!['number'];
    }
    if (post.features!['isShowName'] != null) {
      isShowHouseNumber.value = post.features!['isShowName'];
    }
    if (post.features!['area'] != null) {
      houseArea = post.features!['area'].toString();
      houseAreaTC.text = post.features!['area'].toString();
    }
    if (post.features!['areaUsed'] != null) {
      houseAreaUsed = post.features!['areaUsed'].toString();
      houseAreaUsedTC.text = post.features!['areaUsed'].toString();
    }
    if (post.features!['price'] != null) {
      housePrice = post.features!['price'].toString();
      housePriceTC.text = post.features!['price'].toString();
    }
    if (post.features!['deposit'] != null) {
      houseDeposit = post.features!['deposit'].toString();
      houseDepositTC.text = post.features!['deposit'].toString();
    }
    if (post.features!['furnitureStatus'] != null) {
      {
        houseFurnitureStatus.value =
            FurnitureStatus.parse(post.features!['furnitureStatus']);
      }
    }
  }

  void setLandEdit(RealEstatePostEntity post) {
    if (post.features!['land_type'] != null) {
      landType.value = LandTypes.parse(post.features!['land_type']);
    }
    if (post.features!['land_lot_code'] != null) {
      landLotCode = post.features!['land_lot_code'];
      landLotCodeTC.text = post.features!['land_lot_code'];
    }
    if (post.features!['subdivision_name'] != null) {
      landSubdivisionName = post.features!['subdivision_name'];
      landSubdivisionNameTC.text = post.features!['subdivision_name'];
    }
    if (post.features!['is_facade'] != null) {
      landIsFacade.value = post.features!['is_facade'];
    }
    if (post.features!['has_wide_alley'] != null) {
      landHasWideAlley.value = post.features!['has_wide_alley'];
    }
    if (post.features!['is_widens_towards_the_back'] != null) {
      landIsWidensTowardsTheBack.value =
          post.features!['is_widens_towards_the_back'];
    }
    if (post.features!['land_direction'] != null) {
      landDirection.value = Direction.parse(post.features!['land_direction']);
    }
    if (post.features!['width'] != null) {
      landWidth = post.features!['width'].toString();
      landWidthTC.text = post.features!['width'].toString();
    }
    if (post.features!['length'] != null) {
      landLength = post.features!['length'].toString();
      landLengthTC.text = post.features!['length'].toString();
    }
    if (post.area != null) {
      landArea = post.area.toString();
      landAreaTC.text = post.area.toString();
    }
    if (post.price != null) {
      landPrice = post.price.toString();
      landPriceTC.text = post.price.toString();
    }
    if (post.deposit != null) {
      landDeposit = post.deposit.toString();
      landDepositTC.text = post.deposit.toString();
    }
    if (post.features!['legal_document_status'] != null) {
      landLegalDocumentStatus.value =
          LegalDocumentStatus.parse(post.features!['legal_document_status']);
    }
    if (post.features!['show_land_lot_code'] != null) {
      isShowLandLotCode.value = post.features!['show_land_lot_code'];
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

  // address
  AddressEntity postAddress = AddressEntity();
  int provinceCode = 0;
  int districtCode = 0;
  int wardCode = 0;

  void createAddress() {
    if (provinceCode != 0 && districtCode != 0 && wardCode != 0) {
      postAddress = AddressEntity(
        provinceCode: provinceCode,
        districtCode: districtCode,
        wardCode: wardCode,
      );
    }

    addressTextController.text = postAddress.getDetailAddress();
  }

  Rxn<String> selectedProvince = Rxn(null);

  void changeSelectedProvince(String value) {
    selectedProvince.value = value;
    // search in provinceNames to get provinceCode
    for (Map<String, dynamic> province in provinceNames) {
      if ((province['name'] as String).contains(value)) {
        provinceCode = province['code'] as int;
        break;
      }
    }
    getDistrictNames(provinceCode);
    wardCode = 0;
  }

  Rxn<String> selectedDistrict = Rxn(null);

  void changeSelectedDistrict(String value) {
    selectedDistrict.value = value;
    // search in districtNames to get districtCode
    for (Map<String, dynamic> district in districtNames) {
      if ((district['name'] as String).contains(value)) {
        districtCode = district['code'] as int;
        break;
      }
    }
    getWardNames(provinceCode, districtCode);
  }

  Rxn<String> selectedWard = Rxn(null);

  void changeSelectedWard(String value) {
    selectedWard.value = value;
    // search in wardNames to get wardCode
    for (Map<String, dynamic> ward in wardNames) {
      if ((ward['name'] as String).contains(value)) {
        wardCode = ward['code'] as int;
        break;
      }
    }
  }

  RxList<Map<String, dynamic>> provinceNames = <Map<String, dynamic>>[].obs;

  List<Map<String, dynamic>> getProvinceNames() {
    final GetProvinceNamesUseCase getProvinceNamesUseCase =
        sl<GetProvinceNamesUseCase>();
    final dataState = getProvinceNamesUseCase();

    if (dataState is DataSuccess) {
      provinceNames.clear();
      provinceNames.value = [...dataState.data!];
      return dataState.data!;
    } else {
      provinceNames.clear();
      return [];
    }
  }

  RxList<Map<String, dynamic>> districtNames = <Map<String, dynamic>>[].obs;

  List<Map<String, dynamic>> getDistrictNames(int provinceCode) {
    final GetDistrictNamesUseCase getDistrictNamesUseCase =
        sl<GetDistrictNamesUseCase>();
    final dataState = getDistrictNamesUseCase(params: provinceCode);

    if (dataState is DataSuccess) {
      districtNames.clear();
      districtNames.value = [...dataState.data!];
      return dataState.data!;
    } else {
      districtNames.clear();
      return [];
    }
  }

  RxList<Map<String, dynamic>> wardNames = <Map<String, dynamic>>[].obs;

  List<Map<String, dynamic>> getWardNames(int provinceCode, int districtCode) {
    final GetWardNamesUseCase getWardNamesUseCase = sl<GetWardNamesUseCase>();
    final dataState =
        getWardNamesUseCase(params: Pair(provinceCode, districtCode));

    if (dataState is DataSuccess) {
      wardNames.clear();
      wardNames.value = [...dataState.data!];
      return dataState.data!;
    } else {
      wardNames.clear();
      return [];
    }
  }

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
  final ImagePicker picker0 = ImagePicker();

  Future imgFromGallery() async {
    final pickedImages = await picker0.pickMultiImage();
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
