import 'package:image_picker/image_picker.dart';
import 'package:gotoko/controller/auth_controller.dart';
import 'package:gotoko/data/api/api_checker.dart';
import 'package:gotoko/data/model/response/config_model.dart';
import 'package:gotoko/data/model/response/profile_model.dart';
import 'package:gotoko/data/model/response/revenue_model.dart';
import 'package:gotoko/data/repository/splash_repo.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:gotoko/view/base/custom_snackbar.dart';

class SplashController extends GetxController implements GetxService {
  final SplashRepo splashRepo;
  SplashController({required this.splashRepo});

  final DateTime _currentTime = DateTime.now();

  DateTime get currentTime => _currentTime;
  bool _firstTimeConnectionCheck = true;
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;

  ConfigModel? _configModel;
  ConfigModel? get configModel => _configModel;
  BaseUrls? _baseUrls;
  BaseUrls? get baseUrls => _baseUrls;

  ProfileModel? _profileModel;
  ProfileModel? get profileModel => _profileModel;

  RevenueSummary? _revenueModel;
  RevenueSummary? get revenueModel => _revenueModel;

  int _revenueFilterTypeIndex = 0;
  int get revenueFilterTypeIndex => _revenueFilterTypeIndex;

  String? _revenueFilterType = '';
  String? get revenueFilterType => _revenueFilterType;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<dynamic> _timeZoneList = [];
  List<dynamic> get timeZoneList => _timeZoneList;
  List<String> _timeZone = [];
  List<String> get timeZone => _timeZone;

  String? _selectedTimeZone = '';
  String? get selectedTimeZone => _selectedTimeZone;

  Future<void> getConfigData() async {
    Response response = await splashRepo.getConfigData();
    if (response.statusCode == 200) {
      _configModel = ConfigModel.fromJson(response.body);
      _baseUrls = ConfigModel.fromJson(response.body).baseUrls;
    } else {
      ApiChecker.checkApi(response);
    }
  }

  void getTimeZoneList() async {
    _timeZone = configModel?.timeZone ?? [];
  }

  Future<void> getProfileData() async {
    Response response = await splashRepo.getProfile();
    if (response.statusCode == 200) {
      _profileModel = ProfileModel.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<void> getDashboardRevenueData(String? filterType) async {
    Response response = await splashRepo.getDashboardRevenueSummery(filterType);
    if (response.statusCode == 200) {
      _revenueModel = RevenueModel.fromJson(response.body).revenueSummary;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<bool> initSharedData() {
    return splashRepo.initSharedData();
  }

  Future<bool> removeSharedData() {
    return splashRepo.removeSharedData();
  }

  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }

  void setRevenueFilterType(int index, bool notify) {
    _revenueFilterTypeIndex = index;
    if (notify) {
      update();
    }
  }

  void setRevenueFilterName(String? filterName, bool notify) {
    _revenueFilterType = filterName;
    getDashboardRevenueData(filterName);
    if (notify) {
      update();
    }
  }

  final picker = ImagePicker();
  XFile? _shopLogo;
  XFile? get shopLogo => _shopLogo;
  void pickImage(bool isRemove) async {
    if (isRemove) {
      _shopLogo = null;
    } else {
      _shopLogo = await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    update();
  }

  Future<http.StreamedResponse> updateShop(BusinessInfo shop) async {
    _isLoading = true;
    update();
    http.StreamedResponse response = await splashRepo.updateShop(
        shop, _shopLogo, Get.find<AuthController>().getUserToken());
    if (response.statusCode == 200) {
      getConfigData();
      _isLoading = false;
      Get.back();
      showCustomSnackBar('shop_updated_successfully'.tr, isError: false);
    } else {
      _isLoading = false;
    }
    _isLoading = false;
    update();
    return response;
  }

  void setValueForSelectedTimeZone(String? setValue) {
    _selectedTimeZone = setValue;
  }
}
