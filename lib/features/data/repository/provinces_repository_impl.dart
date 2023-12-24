import 'package:dio/dio.dart';
import 'package:nhagiare_mobile/core/resources/data_state.dart';
import '../../domain/repository/provinces_repository.dart';
import '../data_sources/local/provinces_json.dart';

class ProvincesRepositoryImpl implements ProvincesRepository {
  @override
  DataState<String> getFullAddress(
      String? detail, int provinceCode, int districtCode, int wardCode) {
    try {
      String provinceName = provinceCode.toString();
      String districtName = districtCode.toString();
      String wardName = districtCode.toString();
      for (Map<String, Object> province in provincesVietNam) {
        if (province['code'] == provinceCode) {
          provinceName = province['name'] as String;
          for (Map<String, Object> district in province['districts'] as List) {
            if (district['code'] == districtCode) {
              districtName = district['name'] as String;
              for (Map<String, Object> ward in district['wards'] as List) {
                if (ward['code'] == wardCode) {
                  wardName = ward['name'] as String;
                }
              }
            }
          }
        }
      }

      String detailAddress = detail != null ? "$detail, " : "";
      String result = '$detailAddress$wardName, $districtName, $provinceName';

      return DataSuccess(result);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  DataState<String> getProvinceName(int provinceCode) {
    try {
      String provinceName = provinceCode.toString();
      for (Map<String, Object> province in provincesVietNam) {
        if (province['code'] == provinceCode) {
          provinceName = province['name'] as String;
        }
      }
      return DataSuccess(provinceName);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  DataState<String> getDistrictName(int provinceCode, int districtCode) {
    try {
      String districtName = districtCode.toString();
      for (Map<String, Object> province in provincesVietNam) {
        if (province['code'] == provinceCode) {
          for (Map<String, Object> district in province['districts'] as List) {
            if (district['code'] == districtCode) {
              districtName = district['name'] as String;
            }
          }
        }
      }
      return DataSuccess(districtName);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  DataState<String> getWardName(
      int provinceCode, int districtCode, int wardCode) {
    try {
      String wardName = districtCode.toString();
      for (Map<String, Object> province in provincesVietNam) {
        if (province['code'] == provinceCode) {
          for (Map<String, Object> district in province['districts'] as List) {
            if (district['code'] == districtCode) {
              for (Map<String, Object> ward in district['wards'] as List) {
                if (ward['code'] == wardCode) {
                  wardName = ward['name'] as String;
                }
              }
            }
          }
        }
      }
      return DataSuccess(wardName);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  DataState<int> getProvinceCode(String provinceName) {
    // TODO: implement getProvinceCode
    throw UnimplementedError();
  }

  @override
  DataState<int> getDistrictCode(String districtName) {
    // TODO: implement getDistrictCode
    throw UnimplementedError();
  }

  @override
  DataState<int> getWardCode(String wardName) {
    // TODO: implement getWardCode
    throw UnimplementedError();
  }

  @override
  DataState<List<String>> getProvinceNames() {
    try {
      List<String> provinceNames = [];
      for (Map<String, Object> province in provincesVietNam) {
        provinceNames.add(province['name'] as String);
      }
      return DataSuccess(provinceNames);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  DataState<List<Map<String, dynamic>>> getProvincesMap() {
    try {
      List<Map<String, dynamic>> provincesMap = [];
      for (Map<String, Object> province in provincesVietNam) {
        Map<String, dynamic> namCode = {
          'name': province['name'] as String,
          'code': province['code'] as int,
        };
        provincesMap.add(namCode);
      }
      return DataSuccess(provincesMap);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  DataState<List<Map<String, dynamic>>> getDistrictMap(int proviceCode) {
    try {
      List<Map<String, dynamic>> districtsMap = [];
      // search for province
      for (Map<String, Object> province in provincesVietNam) {
        if (province['code'] == proviceCode) {
          // search for districts
          for (Map<String, Object> district in province['districts'] as List) {
            Map<String, dynamic> namCode = {
              'name': district['name'] as String,
              'code': district['code'] as int,
            };
            districtsMap.add(namCode);
          }
        }
      }
      return DataSuccess(districtsMap);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  DataState<List<Map<String, dynamic>>> getWardMap(
      int proviceCode, int districtCode) {
    try {
      List<Map<String, dynamic>> wardsMap = [];
      // search for province
      for (Map<String, Object> province in provincesVietNam) {
        if (province['code'] == proviceCode) {
          // search for districts
          for (Map<String, Object> district in province['districts'] as List) {
            if (district['code'] == districtCode) {
              // search for wards
              for (Map<String, Object> ward in district['wards'] as List) {
                Map<String, dynamic> namCode = {
                  'name': ward['name'] as String,
                  'code': ward['code'] as int,
                };
                wardsMap.add(namCode);
              }
            }
          }
        }
      }
      return DataSuccess(wardsMap);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
