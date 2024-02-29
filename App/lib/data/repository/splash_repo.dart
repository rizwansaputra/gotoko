import 'package:flutter/foundation.dart';
import 'package:gotoko/data/api/api_client.dart';
import 'package:gotoko/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gotoko/data/model/response/config_model.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class SplashRepo {
  ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SplashRepo({required this.sharedPreferences, required this.apiClient});

  Future<Response> getConfigData() async {
    Response response = await apiClient.getData(AppConstants.configUri);
    return response;
  }

  Future<bool> initSharedData() {
    if (!sharedPreferences.containsKey(AppConstants.theme)) {
      return sharedPreferences.setBool(AppConstants.theme, false);
    }
    if (!sharedPreferences.containsKey(AppConstants.countryCode)) {
      return sharedPreferences.setString(
          AppConstants.countryCode, AppConstants.languages[0].countryCode!);
    }
    if (!sharedPreferences.containsKey(AppConstants.languageCode)) {
      return sharedPreferences.setString(
          AppConstants.languageCode, AppConstants.languages[0].languageCode!);
    }
    if (!sharedPreferences.containsKey(AppConstants.cartList)) {
      return sharedPreferences.setStringList(AppConstants.cartList, []);
    }
    return Future.value(true);
  }

  Future<bool> removeSharedData() {
    return sharedPreferences.clear();
  }

  Future<Response> getProfile() async {
    return await apiClient.getData(AppConstants.getProfileUri);
  }

  Future<Response> getDashboardRevenueSummery(String? filterType) async {
    Response response = await apiClient.getData(
        '${AppConstants.getDashboardRevenueSummeryUri}?statistics_type=$filterType');
    return response;
  }

  Future<http.StreamedResponse> updateShop(
    BusinessInfo shop,
    XFile? file,
    String token,
  ) async {
    http.MultipartRequest request = http.MultipartRequest('POST',
        Uri.parse('${AppConstants.baseUrl}${AppConstants.updateShopUri}'));
    request.headers.addAll(<String, String>{'Authorization': 'Bearer $token'});
    if (file != null) {
      Uint8List list = await file.readAsBytes();
      var part = http.MultipartFile(
          'shop_logo', file.readAsBytes().asStream(), list.length,
          filename: basename(file.path));
      request.files.add(part);
    }

    Map<String, String> fields = {};
    fields.addAll(<String, String>{
      'pagination_limit': shop.paginationLimit!,
      'currency': shop.currency!,
      'shop_name': shop.shopName!,
      'shop_address': shop.shopAddress!,
      'shop_phone': shop.shopPhone!,
      'shop_email': shop.shopEmail!,
      'footer_text': shop.footerText!,
      'country': shop.country!,
      'stock_limit': shop.stockLimit!,
      'time_zone': shop.timeZone!,
      'vat_reg_no': shop.vat!,
    });
    request.fields.addAll(fields);
    http.StreamedResponse response = await request.send();
    return response;
  }
}
