import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/filter_request.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/real_estate_post.dart';
import 'package:nhagiare_mobile/features/domain/enums/posted_by.dart';
import 'package:nhagiare_mobile/features/domain/usecases/address/get_province_names.dart';
import 'package:nhagiare_mobile/features/domain/usecases/post/remote/get_post_search.dart';
import 'package:nhagiare_mobile/features/domain/usecases/post/remote/get_suggest_keywords_use_case.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/pair.dart';
import '../../../../core/utils/filter_values.dart';
import '../../../../core/utils/list_check_service.dart';
import '../../../../core/utils/radio_service.dart';
import '../../../../injection_container.dart';
import '../../../domain/enums/apartment_types.dart';
import '../../../domain/enums/direction.dart';
import '../../../domain/enums/furniture_status.dart';
import '../../../domain/enums/house_types.dart';
import '../../../domain/enums/land_types.dart';
import '../../../domain/enums/legal_document_status.dart';
import '../../../domain/enums/navigate_type.dart';
import '../../../domain/enums/office_types.dart';
import '../../../domain/enums/order_by_types.dart';
import '../../../domain/usecases/post/remote/get_posts.dart';
import 'screens/filter_screen.dart';

class MySearchController extends GetxController {
// set type navigator
// type of navigate when navigate from home
  TypeNavigate typeNavigate = TypeNavigate.search;
  String? provinceHome;
  final GetSuggestKeywordsUseCase getSuggestKeywordsUseCase =
      sl<GetSuggestKeywordsUseCase>();

  void setTypeResult(TypeNavigate type) {
    typeNavigate = type;
    if (type == TypeNavigate.province) {
      provinceHome = Get.arguments["province"];
    } else {
      provinceHome = null;
    }
  }

// loading
  RxBool isLoadingGetPosts = false.obs;
  RxBool hasMore = true.obs;

  void toggleLoadingGetPosts(bool check) {
    isLoadingGetPosts.value = check;
  }

// data in search screen
  // voice controller
  RxBool isListening = false.obs;

  void toggleListening(bool check) {
    isListening.value = check;
  }

  /// query of search bar
  String query = "";

  void changeQuery(String newQuery) {
    query = newQuery;
  }

  /// list dummy data
  final List<String> dummydata = [
    "nha 3 tang",
    "nha lau",
    "nha tro",
    "Dat nong nghiep",
  ];

  /// data in search delegate
  final List<String> history = <String>[
    'nha tro',
    'ban nha',
    'chung cu',
    'van phong',
  ];

  /// list suggestions in search
  RxList<String> suggestions = <String>[].obs;

  /// Name of screen
  String sreenName = 'Tìm kiếm';

  /// hint text int textField
  final String hintText = "Mua bán văn phòng";

  Future<List<RealEstatePostEntity>> getAllPosts() async {
    final GetPostsUseCase getPostsUseCase = sl<GetPostsUseCase>();
    final dataState = await getPostsUseCase();

    if (dataState is DataSuccess && dataState.data!.second.isNotEmpty) {
      return dataState.data!.second;
    } else if (dataState is DataFailed) {
      return [];
    } else {
      return [];
    }
  }

  final RxList<String> searchStrings = <String>[].obs;

  Future<RxList<String>> getSearchString() async {
    List<RealEstatePostEntity> datas = await getAllPosts();
    searchStrings.clear();
    for (var data in datas) {
      searchStrings.add(data.title!);
    }
    return searchStrings;
  }

  /// add new query to history
  void addToHistory(String newQuery) {
    if (newQuery.trim() == "") return; // should not be null
    // check in history has newQuery, if had => delete and add in the top
    if (checkIsInHistory(newQuery)) deleteHistory(newQuery);
    // add to history
    history.insert(0, newQuery);
  }

  /// check is in history has newQuery
  bool checkIsInHistory(String query) {
    for (String q in history) {
      if (q == query) return true;
    }
    return false;
  }

  /// delete a query in history
  void deleteHistory(String query) {
    history.remove(query);
    // update suggestion to sync
    updateSuggestions("");
  }

  /// get list Suggestions
  Future<List<String>> getSuggestions(String query) async {
    if (query.trim().isEmpty) return [...history];
    List<String> results = [];
    if (query.isEmpty) {
      results = [...history];
    } else {
      results = await getSuggestKeywordsUseCase(params: query);
    }
    return results;
  }

  /// update suggestions
  Future updateSuggestions(String query) async {
    suggestions.value = await getSuggestions(query);
  }

  /// navigator to filter screen
  void navigateToFilterScreen() {
    Get.to(() => FilterScreen());
  }

  void popScreen() {
    searchPosts.clear();
    Get.back();
  }

  void navigateToDetailSceen(RealEstatePostEntity post) {
    Get.toNamed(AppRoutes.postDetail, arguments: post);
  }

// data in result screen
  RxList<RealEstatePostEntity> searchPosts = <RealEstatePostEntity>[].obs;

  PostFilter postFilter = PostFilter(
    isLease: true,
    postedBy: PostedBy.all,
    provinceCode: 0,
  );

  Future<void> initPosts(bool isLease, {int? page = 1}) async {
    postFilter.setIsLease(isLease);
    postFilter.setTextSearch(query);
    // return await getPosts(postFilter).then(
    //   (value) {
    //     return value;
    //   },
    // );
  }

  Future<Pair<int, List<RealEstatePostEntity>>> getPosts(
      {int? page = 1}) async {
    final GetPostSearchsUseCase getPostSearchsUseCase =
        sl<GetPostSearchsUseCase>();
    if (page == 1 || page == null) {
      toggleLoadingGetPosts(true);
      searchPosts.clear();
    }
    final dataState =
        await getPostSearchsUseCase(params: Pair(postFilter, page));

    toggleLoadingGetPosts(false);
    if (dataState is DataSuccess && dataState.data!.second.isNotEmpty) {
      if (page == 1 || page == null) {
        searchPosts.value = dataState.data!.second;
        if (dataState.data!.second.length < 10) {
          hasMore.value = false;
        } else {
          hasMore.value = true;
        }
      } else {
        searchPosts.value = [...searchPosts, ...dataState.data!.second];
      }
      return dataState.data!;
    } else {
      return Pair(1, []);
    }
  }

  /// value in dropdown menu item
  // getAll Names of cities
  List<Map<String, dynamic>> provinceNames = <Map<String, dynamic>>[];

  List<Map<String, dynamic>> getProvinceNames() {
    final GetProvinceNamesUseCase getProvinceNamesUseCase =
        sl<GetProvinceNamesUseCase>();
    final dataState = getProvinceNamesUseCase(
      params: this,
    );

    if (dataState is DataSuccess) {
      provinceNames = dataState.data!;
      provinceNames.insert(0, {"name": "Tất cả", "code": 0});
      return dataState.data!;
    } else {
      provinceNames = [];
      return [];
    }
  }

  RxString? selectedProvince = "".obs;

  /// change new value to selectedTypeItem
  void changeSelectedProvince(String newValue) async {
    for (Map<String, dynamic> province in provinceNames) {
      if ((province['name'] as String).contains(newValue)) {
        selectedProvince!.value = (province['name'] as String);
        break;
      }
    }
    // search in provinceNames to get provinceCode
    int provinceCode = 0;
    for (Map<String, dynamic> province in provinceNames) {
      if ((province['name'] as String).contains(newValue)) {
        provinceCode = province['code'] as int;
        break;
      }
    }
    // get posts by province
    await getPostByProvince(provinceCode);
  }

  Future<Pair<int, List<RealEstatePostEntity>>> getPostByProvince(
      int proviceCode,
      {int? page = 1}) async {
    postFilter.setProvinceCode(proviceCode);
    return await getPosts(page: page).then(
      (value) {
        return value;
      },
    );
  }

  // FILTER =================================================================
  // loading
  RxBool isLoadingFilter = false.obs;
  void toggleLoadingFilter(bool check) {
    isLoadingFilter.value = check;
  }

  Future<void> applyFilter() async {
    toggleLoadingFilter(true);

    if (radioCategory.isEqualValue(0)) {
      // Tất cả bất động sản
      postFilter = getPostFilter();
    } else if (radioCategory.isEqualValue(1)) {
      // Căn Hộ/chung Cư
      postFilter = getApartmentFilter();
    } else if (radioCategory.isEqualValue(2)) {
      // Nhà ở
      postFilter = getHouseFilter();
    } else if (radioCategory.isEqualValue(3)) {
      // Đất
      postFilter = getLandFilter();
    } else if (radioCategory.isEqualValue(4)) {
      // Văn Phòng, Mặt bằng kinh doanh
      postFilter = getOfficeFilter();
    } else {
      // Phòng trọ
      postFilter = getMotelFilter();
    }
    await getPosts();
    // reset provinces
    changeSelectedProvince(provinceNames[0]['name']);
    // reset all
    toggleLoadingFilter(false);
    // pop screen when done
    popScreen();
    deleteFilter();
  }

  OrderByTypes getOrderBy() {
    if (radioSortType.isEqualValue(0)) {
      return OrderByTypes.relatedDesc;
    } else if (radioSortType.isEqualValue(1)) {
      return OrderByTypes.createdAtDesc;
    } else {
      return OrderByTypes.priceAsc;
    } 
  }

  PostedBy getPostBy() {
    if (radiopostedBy.isEqualValue(0)) {
      // ca nhan
      return PostedBy.individual;
    } else {
      // moi gioi
      return PostedBy.proSeller;
    }
  }

  // get post filter
  // all
  PostFilter getPostFilter() {
    return PostFilter(
      textSearch: typeNavigate == TypeNavigate.search ? query : null,
      isLease: typeNavigate == TypeNavigate.sell
          ? false
          : typeNavigate == TypeNavigate.rent
              ? true
              : null,
      orderBy: getOrderBy(),
      minPrice: lowerPriceValue.value.toInt(),
      maxPrice: upperPriceValue.value.toInt(),
      minArea: lowerAreaValue.value.toInt(),
      maxArea: upperAreaValue.value.toInt(),
      postedBy: getPostBy(),
    );
  }

  // ApartmentFilter
  ApartmentFilter getApartmentFilter() {
    return ApartmentFilter(
        textSearch: typeNavigate == TypeNavigate.search ? query : null,
        isLease: typeNavigate == TypeNavigate.sell
            ? false
            : typeNavigate == TypeNavigate.rent
                ? true
                : null,
        orderBy: getOrderBy(),
        minPrice: lowerPriceValue.value.toInt(),
        maxPrice: upperPriceValue.value.toInt(),
        minArea: lowerAreaValue.value.toInt(),
        maxArea: upperAreaValue.value.toInt(),
        postedBy: getPostBy(),
        isHandedOver: apartmentStatus.isEqualValue(0)
            ? null
            : apartmentStatus.isEqualValue(1)
                ? false
                : true,
        apartmentTypes: apartmentTypes
            .getListSelected()
            .map((e) => ApartmentTypes.parseVi(e))
            .toList(),
        isCorner: apartmentCharacteristics.isEqualValue(0) ? null : true,
        numOfBedrooms: apartmentBedroomNumber.getListSelected().map(
          (e) {
            if (e == "Nhiều hơn 10") {
              return 11;
            } else {
              return int.parse(e);
            }
          },
        ).toList(),
        mainDoorDirections: apartmentMainDirection
            .getListSelected()
            .map((e) => Direction.parseVi(e))
            .toList(),
        balconyDirections: apartmentBalconyDirection
            .getListSelected()
            .map((e) => Direction.parseVi(e))
            .toList(),
        legalStatus: apartmentLegalDocuments
            .getListSelected()
            .map((e) => LegalDocumentStatus.parseVi(e))
            .toList(),
        furnitureStatus: apartmentInteriorStatus
            .getListSelected()
            .map((e) => FurnitureStatus.parseVi(e))
            .toList());
  }

  // HouseFilter
  HouseFilter getHouseFilter() {
    return HouseFilter(
        textSearch: typeNavigate == TypeNavigate.search ? query : null,
        isLease: typeNavigate == TypeNavigate.sell
            ? false
            : typeNavigate == TypeNavigate.rent
                ? true
                : null,
        orderBy: getOrderBy(),
        minPrice: lowerPriceValue.value.toInt(),
        maxPrice: upperPriceValue.value.toInt(),
        minArea: lowerAreaValue.value.toInt(),
        maxArea: upperAreaValue.value.toInt(),
        postedBy: getPostBy(),
        houseTypes: houseTypes
            .getListSelected()
            .map((e) => HouseTypes.parseVi(e))
            .toList(),
        hasWideAlley: houseCharacteristics.isEqualValue(0),
        isFacade: houseCharacteristics.isEqualValue(1),
        isWidensTowardsTheBack: houseCharacteristics.isEqualValue(2),
        numOfBedrooms: houseBedroomNumber.getListSelected().map(
          (e) {
            if (e == "Nhiều hơn 10") {
              return 11;
            } else {
              return int.parse(e);
            }
          },
        ).toList(),
        mainDoorDirections: houseMainDirection
            .getListSelected()
            .map((e) => Direction.parseVi(e))
            .toList(),
        legalStatus: houseLegalDocuments
            .getListSelected()
            .map((e) => LegalDocumentStatus.parseVi(e))
            .toList(),
        furnitureStatus: houseInteriorStatus
            .getListSelected()
            .map((e) => FurnitureStatus.parseVi(e))
            .toList());
  }

  // LandFilter
  LandFilter getLandFilter() {
    return LandFilter(
      textSearch: typeNavigate == TypeNavigate.search ? query : null,
      isLease: typeNavigate == TypeNavigate.sell
          ? false
          : typeNavigate == TypeNavigate.rent
              ? true
              : null,
      orderBy: getOrderBy(),
      minPrice: lowerPriceValue.value.toInt(),
      maxPrice: upperPriceValue.value.toInt(),
      minArea: lowerAreaValue.value.toInt(),
      maxArea: upperAreaValue.value.toInt(),
      postedBy: getPostBy(),
      landTypes:
          landTypes.getListSelected().map((e) => LandTypes.parseVi(e)).toList(),
      hasWideAlley: landCharacteristics.isEqualValue(0),
      isFacade: landCharacteristics.isEqualValue(1),
      isWidensTowardsTheBack: landCharacteristics.isEqualValue(2),
      landDirections: landDirection
          .getListSelected()
          .map((e) => Direction.parseVi(e))
          .toList(),
      legalStatus: landLegalDocuments
          .getListSelected()
          .map((e) => LegalDocumentStatus.parseVi(e))
          .toList(),
    );
  }

  // OfficeFilter
  OfficeFilter getOfficeFilter() {
    return OfficeFilter(
      textSearch: typeNavigate == TypeNavigate.search ? query : null,
      isLease: typeNavigate == TypeNavigate.sell
          ? false
          : typeNavigate == TypeNavigate.rent
              ? true
              : null,
      orderBy: getOrderBy(),
      minPrice: lowerPriceValue.value.toInt(),
      maxPrice: upperPriceValue.value.toInt(),
      minArea: lowerAreaValue.value.toInt(),
      maxArea: upperAreaValue.value.toInt(),
      postedBy: getPostBy(),
      officeTypes: officeType
          .getListSelected()
          .map((e) => OfficeTypes.parseVi(e))
          .toList(),
      mainDoorDirections: officeDirection
          .getListSelected()
          .map((e) => Direction.parseVi(e))
          .toList(),
      legalStatus: landLegalDocuments
          .getListSelected()
          .map((e) => LegalDocumentStatus.parseVi(e))
          .toList(),
      furnitureStatus: officeInteriorStatus
          .getListSelected()
          .map((e) => FurnitureStatus.parseVi(e))
          .toList(),
    );
  }

  // MotelFilter
  MotelFilter getMotelFilter() {
    return MotelFilter(
      textSearch: typeNavigate == TypeNavigate.search ? query : null,
      isLease: typeNavigate == TypeNavigate.sell
          ? false
          : typeNavigate == TypeNavigate.rent
              ? true
              : null,
      orderBy: getOrderBy(),
      minPrice: lowerPriceValue.value.toInt(),
      maxPrice: upperPriceValue.value.toInt(),
      minArea: lowerAreaValue.value.toInt(),
      maxArea: upperAreaValue.value.toInt(),
      postedBy: getPostBy(),
      furnitureStatus: rentInteriorStatus
          .getListSelected()
          .map((e) => FurnitureStatus.parseVi(e))
          .toList(),
    );
  }

  void deleteFilter() {
    // reset all
    radioCategory.reset();
    radioSortType.reset();
    radiopostedBy.reset();

    resetAllCardsOfCategory();
    changeValuePrice(
        sl.get<FilterValues>().lowerPrice, sl.get<FilterValues>().upperPrice);
    changeAreaValue(
        sl.get<FilterValues>().lowerArea, sl.get<FilterValues>().upperArea);
  }

// Category type ==================================
  RadioService radioCategory = RadioService(
    values: sl.get<FilterValues>().categorys,
    expendedFunc: () => Get.back(),
  );

// sort card ======================================
  RadioService radioSortType = RadioService(
    values: sl.get<FilterValues>().sortTypes,
  );

// posted card ======================================
  RadioService radiopostedBy = RadioService(
    values: sl.get<FilterValues>().postedBy,
  );
// Slider ranges ==================================
  // Price range

  RxDouble lowerPriceValue = sl.get<FilterValues>().lowerPrice.obs;
  RxDouble upperPriceValue = sl.get<FilterValues>().upperPrice.obs;

  void changeValuePrice(double lower, double upper) {
    lowerPriceValue.value = lower;
    upperPriceValue.value = upper;
  }

  // Area range

  RxDouble lowerAreaValue = sl.get<FilterValues>().lowerArea.obs;
  RxDouble upperAreaValue = sl.get<FilterValues>().upperArea.obs;

  void changeAreaValue(double lower, double upper) {
    lowerAreaValue.value = lower;
    upperAreaValue.value = upper;
  }

// reset radio ==========================================
  void resetAllCardsOfCategory() {
    resetApartment();
    resetHouse();
    resetLand();
    resetOffice();
    resetRent();
  }

  void resetApartment() {
    apartmentStatus.reset();
    apartmentTypes.reset();
    apartmentCharacteristics.reset();
    apartmentBedroomNumber.reset();
    apartmentMainDirection.reset();
    apartmentBalconyDirection.reset();
    apartmentLegalDocuments.reset();
    apartmentInteriorStatus.reset();
  }

  void resetHouse() {
    houseTypes.reset();
    houseCharacteristics.reset();
    houseBedroomNumber.reset();
    houseMainDirection.reset();
    houseLegalDocuments.reset();
    houseInteriorStatus.reset();
  }

  void resetLand() {
    landTypes.reset();
    landCharacteristics.reset();
    landDirection.reset();
    landLegalDocuments.reset();
  }

  void resetOffice() {
    officeType.reset();
    officeDirection.reset();
    officeLegalDocuments.reset();
    officeInteriorStatus.reset();
  }

  void resetRent() {
    rentInteriorStatus.reset();
  }

// Can ho chung cu ======================================
  RadioService apartmentStatus = RadioService(
    values: sl.get<FilterValues>().apartmentStatus,
  );
  ListCheckService apartmentTypes = ListCheckService(
    values: sl.get<FilterValues>().apartmentTypes,
  );
  RadioService apartmentCharacteristics = RadioService(
    values: sl.get<FilterValues>().apartmentCharacteristics,
  );
  ListCheckService apartmentBedroomNumber = ListCheckService(
    values: sl.get<FilterValues>().bedroomNumber,
  );
  ListCheckService apartmentMainDirection = ListCheckService(
    values: sl.get<FilterValues>().mainDirection,
  );
  ListCheckService apartmentBalconyDirection = ListCheckService(
    values: sl.get<FilterValues>().mainDirection,
  );
  ListCheckService apartmentLegalDocuments = ListCheckService(
    values: sl.get<FilterValues>().legalDocuments,
  );
  ListCheckService apartmentInteriorStatus = ListCheckService(
    values: sl.get<FilterValues>().interiorStatus,
  );
// Nha o ================================================
  ListCheckService houseTypes = ListCheckService(
    values: sl.get<FilterValues>().residentialTypes,
  );
  ListCheckService houseCharacteristics = ListCheckService(
    values: sl.get<FilterValues>().houseCharacteristics,
  );
  ListCheckService houseBedroomNumber = ListCheckService(
    values: sl.get<FilterValues>().bedroomNumber,
  );
  ListCheckService houseMainDirection = ListCheckService(
    values: sl.get<FilterValues>().mainDirection,
  );
  ListCheckService houseLegalDocuments = ListCheckService(
    values: sl.get<FilterValues>().legalDocuments,
  );
  ListCheckService houseInteriorStatus = ListCheckService(
    values: sl.get<FilterValues>().interiorStatus,
  );
// Dat ================================================
  ListCheckService landTypes = ListCheckService(
    values: sl.get<FilterValues>().typeOfLand,
  );
  ListCheckService landCharacteristics = ListCheckService(
    values: sl.get<FilterValues>().houseCharacteristics,
  );
  ListCheckService landDirection = ListCheckService(
    values: sl.get<FilterValues>().mainDirection,
  );
  ListCheckService landLegalDocuments = ListCheckService(
    values: sl.get<FilterValues>().legalDocuments,
  );
// Van phong  ================================================
  ListCheckService officeType = ListCheckService(
    values: sl.get<FilterValues>().officeType,
  );
  ListCheckService officeDirection = ListCheckService(
    values: sl.get<FilterValues>().mainDirection,
  );
  ListCheckService officeLegalDocuments = ListCheckService(
    values: sl.get<FilterValues>().legalDocuments,
  );
  ListCheckService officeInteriorStatus = ListCheckService(
    values: sl.get<FilterValues>().interiorStatus,
  );
// Phong tro  ================================================
  ListCheckService rentInteriorStatus = ListCheckService(
    values: sl.get<FilterValues>().interiorStatus,
  );
}
