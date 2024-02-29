import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gotoko/controller/auth_controller.dart';
import 'package:gotoko/data/api/api_checker.dart';
import 'package:gotoko/data/model/response/categories_product_model.dart';
import 'package:gotoko/data/model/response/category_model.dart';
import 'package:gotoko/data/model/response/product_model.dart';
import 'package:gotoko/data/model/response/sub_category_model.dart';
import 'package:gotoko/data/repository/category_repo.dart';
import 'package:gotoko/view/base/custom_snackbar.dart';
import 'package:http/http.dart' as http;

class CategoryController extends GetxController implements GetxService {
  final CategoryRepo categoryRepo;
  CategoryController({required this.categoryRepo});

  bool _isLoading = false;
  bool _isGetting = false;
  bool _isCategory = false;
  bool get isCategory => _isCategory;
  bool _isSub = false;
  bool _isFirst = true;
  bool get isFirst => _isFirst;
  bool get isGetting => _isGetting;
  bool get isLoading => _isLoading;
  bool get isSub => _isSub;
  int? _categoryListLength;
  int? get categoryListLength => _categoryListLength;

  int? _subCategoryListLength;
  int? get subCategoryListLength => _subCategoryListLength;

  List<Categories> _categoryList = [];
  List<Categories> get categoryList => _categoryList;

  List<SubCategories>? _subCategoryList = [];
  List<SubCategories>? get subCategoryList => _subCategoryList;

  int? _categorySelectedIndex;
  int? get categorySelectedIndex => _categorySelectedIndex;

  int _categoryIndex = 0;
  final int _categoryId = 0;
  int get categoryId => _categoryId;
  int? _subCategoryIndex;
  int get categoryIndex => _categoryIndex;
  int? get subCategoryIndex => _subCategoryIndex;
  List<int?> _categoryIds = [];
  List<int?>? _subCategoryIds;
  List<int?> get categoryIds => _categoryIds;
  List<int?>? get subCategoryIds => _subCategoryIds;

  List<CategoriesProduct>? _categoriesProductList;
  List<CategoriesProduct>? get categoriesProductList => _categoriesProductList;

  List<Products>? _searchedProductList;
  List<Products>? get searchedProductList => _searchedProductList;
  String _selectedCategoryName = 'select';
  String get selectedCategoryName => _selectedCategoryName;

  final picker = ImagePicker();
  XFile? _categoryImage;
  XFile? get categoryImage => _categoryImage;
  void pickImage(bool isRemove) async {
    if (isRemove) {
      _categoryImage = null;
    } else {
      _categoryImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    update();
  }

  Future<http.StreamedResponse> addCategory(
      String categoryName, int? categoryId, bool isUpdate) async {
    _isLoading = true;
    update();
    http.StreamedResponse response = await categoryRepo.addCategory(
        categoryName,
        categoryId,
        _categoryImage,
        Get.find<AuthController>().getUserToken(),
        isUpdate: isUpdate);
    if (response.statusCode == 200) {
      _categoryImage = null;
      getCategoryList(1, reload: true);
      _isLoading = false;
      Get.back();
      showCustomSnackBar(
          isUpdate
              ? 'category_updated_successfully'.tr
              : 'category_added_successfully'.tr,
          isError: false);
    } else {
      ApiChecker.checkApi(await ApiChecker.getResponse(response));
    }
    _isLoading = false;
    update();
    return response;
  }

  Future<void> getCategoryList(int offset,
      {Products? product, reload = false, int limit = 10}) async {
    if (reload) {
      _categoryList = [];
    }
    _isGetting = true;
    _categoryIndex = 0;
    _categoryIds = [];
    _categoryIds.add(0);
    Response response = await categoryRepo.getCategoryList(offset, limit);
    if (response.statusCode == 200) {
      _categoryList.addAll(CategoryModel.fromJson(response.body).categories!);
      _categoryListLength = CategoryModel.fromJson(response.body).total;
      _categoryIndex = 0;
      for (int index = 0; index < _categoryList.length; index++) {
        _categoryIds.add(_categoryList[index].id);
      }

      if (product != null) {
        setCategoryIndex(
            _categoryIds.indexOf(int.parse(product.categoryIds![0].id!)), false,
            product: product);
      }

      _isGetting = false;
      _isFirst = false;
    } else {
      ApiChecker.checkApi(response);
    }
    _isGetting = false;
    update();
  }

  Future<void> getCategoryWiseProductList(int? categoryId) async {
    _isCategory = true;
    Response response =
        await categoryRepo.getCategoryWiseProductList(categoryId);
    if (response.body != {} && response.statusCode == 200) {
      _categoriesProductList = [];
      response.body.forEach((categoriesProduct) => _categoriesProductList!
          .add(CategoriesProduct.fromJson(categoriesProduct)));
    } else {
      ApiChecker.checkApi(response);
    }
    _isCategory = false;
    update();
  }

  Future<void> getSearchProductList(String name, {bool isReset = false}) async {
    if (!isReset) {
      Response response = await categoryRepo.searchProduct(name);
      if (response.body != {} && response.statusCode == 200) {
        _searchedProductList = [];
        _searchedProductList!
            .addAll(ProductModel.fromJson(response.body).products!);
      } else {
        ApiChecker.checkApi(response);
      }
      _isGetting = false;
      update();
    } else {
      _searchedProductList = null;
      update();
    }
  }

  Future<void> getSubCategoryList(int offset, int? categoryId,
      {Products? product, bool reload = false, bool isUpdate = true}) async {
    if (offset == 1 || _subCategoryList == null || reload) {
      _subCategoryList = null;
      _subCategoryIds = null;
      if (isUpdate) {
        update();
      }
    }
    _isGetting = true;

    Response response =
        await categoryRepo.getSubCategoryList(offset, categoryId);
    if (response.statusCode == 200) {
      _subCategoryList ??= [];
      _subCategoryList
          ?.addAll(SubCategoryModel.fromJson(response.body).subCategories!);
      _subCategoryListLength = SubCategoryModel.fromJson(response.body).total;
      for (int index = 0; index < _subCategoryList!.length; index++) {
        _subCategoryIndex = null;
        _subCategoryIds ??= [];
        _subCategoryIds?.add(_subCategoryList![index].id);
      }

      if (product != null && product.categoryIds != null) {
        for (int i = 0; i < product.categoryIds!.length; i++) {
          if (product.categoryIds?[i].position == 2) {
            setSubCategoryIndex(
                int.parse('${product.categoryIds![i].id}'), false);
          }
        }
      }
      _isGetting = false;
      _isFirst = false;
    } else {
      ApiChecker.checkApi(response);
    }
    _isGetting = false;
    update();
  }

  Future<void> addSubCategory(String subCategoryName, int? id,
      int? parenCategoryId, bool isUpdate) async {
    _isSub = true;
    _isLoading = true;
    update();
    Response response = await categoryRepo.addSubCategory(
        subCategoryName, parenCategoryId, id,
        isUpdate: isUpdate);
    if (response.statusCode == 200) {
      getSubCategoryList(1, parenCategoryId, reload: true);
      Get.back();
      showCustomSnackBar(
          isUpdate
              ? 'sub_category_update_successfully'.tr
              : 'sub_category_added_successfully'.tr,
          isError: false);
      _isSub = false;
    } else {
      ApiChecker.checkApi(response);
    }
    _isSub = false;
    _isLoading = false;
    update();
  }

  void removeImage() {
    _categoryImage = null;
    update();
  }

  void showBottomLoader() {
    _isGetting = true;
    update();
  }

  void removeFirstLoading() {
    _isFirst = true;
    update();
  }

  void setCategoryIndex(int index, bool notify,
      {bool fromUpdate = false, Products? product}) {
    _subCategoryIds = null;
    if (index != 0) {
      getSubCategoryList(1, categoryList[index - 1].id,
          reload: true, product: product);
    } else {
      _subCategoryList = null;
    }
    _categoryIndex = index;
    _categorySelectedIndex = _categoryIndex;
    if (notify) {
      update();
    }
  }

  void setSubCategoryIndex(int? index, bool notify) {
    _subCategoryIndex = index;

    if (notify) {
      update();
    }
  }

  void changeSelectedIndex(int selectedIndex) {
    _categorySelectedIndex = selectedIndex;
    // update();
  }

  void setCategorySelectedName(String categoryName) {
    _selectedCategoryName = categoryName;
    update();
  }

  Future<void> deleteCategory(int? categoryId) async {
    Response response = await categoryRepo.deleteCategory(categoryId);
    if (response.statusCode == 200) {
      Map map = response.body;
      bool status = map['success'];
      String? message = map['message'];
      getCategoryList(1, reload: true);
      Get.back();
      showCustomSnackBar('$message', isError: !status);
    } else {
      ApiChecker.checkApi(response);
    }
    _isGetting = false;
    update();
  }

  Future<void> deleteSubCategory(SubCategories subCategory) async {
    _isLoading = true;
    update();
    Get.back();

    Response response = await categoryRepo.deleteCategory(subCategory.id);
    if (response.statusCode == 200) {
      getSubCategoryList(1, subCategory.parentId, reload: true);
      showCustomSnackBar('sub_category_deleted_successfully'.tr,
          isError: false);
    } else {
      ApiChecker.checkApi(response);
    }
    _isGetting = false;
    _isLoading = false;
    update();
  }

  Future<void> categoryStatusOnOff(
      int? categoryId, int status, int? index) async {
    Response response =
        await categoryRepo.categoryStatusOnOff(categoryId, status);
    if (response.statusCode == 200) {
      // getCategoryList(1, reload: true);
      _categoryList[index!].status = status;
      showCustomSnackBar('category_status_updated_successfully'.tr,
          isError: false);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> subCategoryStatusOnOff(int subCategoryId, int status) async {
    Response response =
        await categoryRepo.categoryStatusOnOff(subCategoryId, status);
    if (response.statusCode == 200) {
      getSubCategoryList(1, categorySelectedIndex, reload: true);
      showCustomSnackBar('category_status_updated_successfully'.tr,
          isError: false);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> categoryListEmpty(Products product) async {
    _categoryList = [];
    getCategoryList(1, product: product, reload: true);
  }

  void setCategoryAndSubCategoryEmpty() {
    _categoryIndex = 0;
    _subCategoryIndex = null;
  }
}
