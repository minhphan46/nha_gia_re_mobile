import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/extensions/string_ex.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/real_estate_post.dart';
import 'package:nhagiare_mobile/features/domain/usecases/address/get_province_names.dart';
import 'package:nhagiare_mobile/features/domain/usecases/post/remote/get_post_search.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/utils/filter_values.dart';
import '../../../../core/utils/list_check_service.dart';
import '../../../../core/utils/radio_service.dart';
import '../../../../injection_container.dart';
import '../../../domain/usecases/post/remote/get_posts.dart';
import 'screens/filter_screen.dart';

class MySearchController extends GetxController {
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

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      return dataState.data!;
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
  List<String> getSuggestions(String query) {
    // xu ly in hoa, in thuong, co dau, khong dau
    List<String> results = [];
    if (query.isEmpty) {
      results = [...history];
    } else {
      for (String value in searchStrings) {
        if (value
            .noAccentVietnamese()
            .toLowerCase()
            .startsWith(query.noAccentVietnamese().toLowerCase())) {
          results.add(value);
        }
      }
    }
    return results;
  }

  /// update suggestions
  void updateSuggestions(String query) async {
    suggestions.value = getSuggestions(query);
  }

  /// navigator to filter screen
  void navigateToFilterScreen() {
    Get.to(() => FilterScreen());
  }

  void popScreen() {
    Get.back();
  }

  void navigateToDetailSceen(RealEstatePostEntity post) {
    Get.toNamed(AppRoutes.postDetail, arguments: post);
  }

// data in result screen
  RxList<RealEstatePostEntity> searchPosts = <RealEstatePostEntity>[].obs;

  Map<String, dynamic> buildQuery = {
    "isLease": true,
    "search": "",
    "provinceCode": 0,
  };
  Future<void> initPosts(bool isLease) async {
    buildQuery.update("isLease", (value) => isLease);
    buildQuery.update("search", (value) => query);
    await getPosts(buildQuery);
  }

  Future<void> getPosts(Map<String, dynamic> buildQuery) async {
    final GetPostSearchsUseCase getPostSearchsUseCase =
        sl<GetPostSearchsUseCase>();
    final dataState = await getPostSearchsUseCase(params: buildQuery);
    searchPosts.value = [];
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      searchPosts.value = [...dataState.data!];
    } else {
      searchPosts.value = [];
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

  RxString? selectedProvince;

  /// change new value to selectedTypeItem
  void changeSelectedItem(String newValue) async {
    if (selectedProvince == null) {
      selectedProvince = newValue.obs;
    } else {
      selectedProvince!.value = newValue;
    }
    // search in provinceNames to get provinceCode
    int provinceCode = 0;
    for (Map<String, dynamic> province in provinceNames) {
      if (province['name'] == newValue) {
        provinceCode = province['code'] as int;
        break;
      }
    }
    // get posts by province
    await getPostByProvince(provinceCode);
  }

  Future<void> getPostByProvince(int proviceCode) async {
    buildQuery.update("provinceCode", (value) => proviceCode);
    await getPosts(buildQuery);
  }

  // FILTER =================================================================
  void deleteFilter() {
    // reset all
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
