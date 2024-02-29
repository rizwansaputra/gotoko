import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gotoko/data/api/api_client.dart';
import 'package:gotoko/util/app_constants.dart';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class CategoryRepo {
  ApiClient apiClient;
  CategoryRepo({required this.apiClient});

  Future<Response> getCategoryList(int offset, int limit) async {
    return await apiClient.getData(
        '${AppConstants.getCategoryListUri}?limit=$limit&offset=$offset');
  }

  Future<Response> getCategoryWiseProductList(int? categoryId) async {
    return await apiClient.getData(
        '${AppConstants.categoriesProductUri}?category_id=$categoryId');
  }

  Future<http.StreamedResponse> addCategory(
      String categoryName, int? categoryId, XFile? file, String token,
      {bool isUpdate = false}) async {
    http.MultipartRequest request = isUpdate
        ? http.MultipartRequest(
            'POST',
            Uri.parse(
                '${AppConstants.baseUrl}${AppConstants.updateCategoryUri}'))
        : http.MultipartRequest('POST',
            Uri.parse('${AppConstants.baseUrl}${AppConstants.addCategoryUri}'));
    request.headers.addAll(<String, String>{'Authorization': 'Bearer $token'});

    if (file != null) {
      Uint8List list = await file.readAsBytes();
      var part = http.MultipartFile(
          'image', file.readAsBytes().asStream(), list.length,
          filename: basename(file.path));
      request.files.add(part);
    }

    Map<String, String> fields = {};
    fields.addAll(<String, String>{
      'id': categoryId.toString(),
      'name': categoryName,
    });
    request.fields.addAll(fields);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<Response> getSubCategoryList(int offset, int? categoryId) async {
    return await apiClient.getData(
        '${AppConstants.getSubCategoryListUri}?limit=10&offset=$offset&category_id=$categoryId');
  }

  Future<Response> addSubCategory(
      String subCategoryName, int? parenCategoryId, int? id,
      {bool isUpdate = false}) async {
    return await apiClient.postData(
        isUpdate
            ? AppConstants.updateSubCategoryUri
            : AppConstants.addSubCategoryUri,
        {'name': subCategoryName, 'parent_id': parenCategoryId, 'id': id});
  }

  Future<Response> searchProduct(String productName) async {
    return await apiClient
        .getData('${AppConstants.productSearchUri}?name=$productName');
  }

  Future<Response> deleteCategory(int? categoryId) async {
    return await apiClient
        .getData('${AppConstants.deleteCategoryUri}?id=$categoryId');
  }

  Future<Response> categoryStatusOnOff(int? categoryId, int status) async {
    return await apiClient.getData(
        '${AppConstants.updateCategoryStatusUri}?id=$categoryId&status=$status');
  }
}
