import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:gotoko/controller/account_controller.dart';
import 'package:gotoko/controller/cart_controller.dart';
import 'package:gotoko/data/api/api_checker.dart';
import 'package:gotoko/data/model/response/account_model.dart';
import 'package:gotoko/data/model/response/transaction_model.dart';
import 'package:gotoko/data/model/response/transaction_type_model.dart';
import 'package:gotoko/data/repository/transaction_repo.dart';
import 'package:gotoko/view/base/custom_snackbar.dart';

class TransactionController extends GetxController implements GetxService {
  final TransactionRepo transactionRepo;
  TransactionController({required this.transactionRepo});
  bool _isLoading = false;
  bool _isFirst = true;
  bool get isFirst => _isFirst;
  bool get isLoading => _isLoading;
  int? _transactionListLength;
  int? get transactionListLength => _transactionListLength;
  List<Transfers>? _transactionList = [];
  List<Transfers>? get transactionList => _transactionList;

  List<Types>? _transactionTypeList;
  List<Types>? get transactionTypeList => _transactionTypeList;

  int? _transactionTypeIndex = 0;
  int? get transactionTypeIndex => _transactionTypeIndex;

  String? _transactionTypeName;
  String? get transactionTypeName => _transactionTypeName;

  List<int?> _transactionTypeIds = [];
  List<int?> get transactionTypeIds => _transactionTypeIds;

  int? _fromAccountIndex;
  int? get fromAccountIndex => _fromAccountIndex;
  set setFromAccountIndex(int? index) => _fromAccountIndex = index;
  int? _toAccountIndex;
  int? get toAccountIndex => _toAccountIndex;

  int? _selectedFromAccountId;
  int? get selectedFromAccountId => _selectedFromAccountId;
  set setSelectedFromAccountId(int? id) => _selectedFromAccountId = id;

  int? _selectedToAccountId = 0;
  int? get selectedToAccountId => _selectedToAccountId;

  List<int?>? _fromAccountIds;
  List<int?>? get fromAccountIds => _fromAccountIds;

  List<int?>? _toAccountIds;
  List<int?>? get toAccountIds => _toAccountIds;

  List<Accounts>? _accountList;
  List<Accounts>? get accountList => _accountList;

  String? _transactionExportFilePath = '';
  String? get transactionExportFilePath => _transactionExportFilePath;

  bool _filterIaActive = false;
  bool get filterIaActive => _filterIaActive;

  bool _filterClick = false;
  bool get filterClick => _filterClick;

  int _offset = 1;
  int get offset => _offset;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels &&
          transactionList != null &&
          transactionList!.isNotEmpty &&
          !_isLoading) {
        if (_offset < _transactionListLength!) {
          _offset++;
          showBottomLoader();
          if (_filterIaActive) {
            String selectedStartDate = '';
            String selectedEndDate = '';
            selectedStartDate = dateFormat.format(startDate!).toString();
            selectedEndDate = dateFormat.format(endDate!).toString();
            getTransactionFilter(
                selectedStartDate,
                selectedEndDate,
                Get.find<AccountController>().accountIndex,
                transactionTypeName ?? 'income',
                offset,
                reload: false);
          } else {
            Get.find<TransactionController>()
                .getTransactionList(offset, reload: false);
          }
        }
      }
    });
  }

  Future<void> getTransactionList(int offset,
      {bool reload = true, bool isUpdate = true}) async {
    _offset = offset;

    if (reload || _transactionList == null || offset == 1) {
      _transactionList = null;
      _isLoading = true;
      _filterClick = false;
      _filterIaActive = false;
      if (isUpdate) {
        update();
      }
    }

    Response response = await transactionRepo.getTransactionList(offset);
    if (response.statusCode == 200) {
      _transactionList ??= [];
      _transactionList
          ?.addAll(TransactionModel.fromJson(response.body).transfers!);
      _transactionListLength = TransactionModel.fromJson(response.body).total;
      _isLoading = false;
      _isFirst = false;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getCustomerWiseTransactionListList(int? customerId, int offset,
      {bool reload = true, bool isUpdate = true}) async {
    if (reload || _transactionList == null || offset == 1) {
      _transactionList = null;
      _isFirst = true;
      if (isUpdate) {
        update();
      }
    }

    _offset = offset;
    _isLoading = true;
    Response response = await transactionRepo.getCustomerWiseTransactionList(
        customerId, offset);
    if (response.statusCode == 200) {
      _transactionList ??= [];
      _transactionList
          ?.addAll(TransactionModel.fromJson(response.body).transfers!);
      _transactionListLength = TransactionModel.fromJson(response.body).total;
      _isLoading = false;
      _isFirst = false;
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<void> getTransactionTypeList() async {
    _transactionTypeIndex = 0;
    _transactionTypeIds = [];
    _transactionTypeName = null;
    _isLoading = true;
    Response response = await transactionRepo.getTransactionTypeList();
    if (response.statusCode == 200) {
      _transactionTypeList = [];
      _transactionTypeList!
          .addAll(TransactionTypeModel.fromJson(response.body).types!);
      if (_transactionTypeList!.isNotEmpty) {
        for (int index = 0; index < _transactionTypeList!.length; index++) {
          _transactionTypeIds.add(_transactionTypeList![index].id);
        }
        _transactionTypeIndex = _transactionTypeIds[0];
      }

      _isLoading = false;
      _isFirst = false;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getTransactionFilter(String startDate, String endDate,
      int? accountId, String? accountType, int offset,
      {bool reload = true}) async {
    _offset = offset;
    if (reload || offset == 1 || _transactionList == null) {
      _transactionList = [];
      _filterClick = true;
      _filterIaActive = true;
      update();
    }
    _isLoading = true;

    Response response = await transactionRepo.getTransactionFilter(
        startDate, endDate, accountId, accountType, offset);
    if (response.statusCode == 200) {
      _transactionList
          ?.addAll(TransactionModel.fromJson(response.body).transfers!);
      _transactionListLength =
          (TransactionModel.fromJson(response.body).total! / 10).ceil() + 1;
      _isLoading = false;
      _isFirst = false;
      _filterClick = false;
    } else {
      _isLoading = false;
      _isFirst = false;
      _filterClick = false;
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> addTransaction(
      Transfers transfer, int? fromAccountId, int? toAccountId) async {
    _isLoading = true;
    Response response = await transactionRepo.addNewTransaction(
        transfer, fromAccountId, toAccountId);
    if (response.statusCode == 200) {
      getTransactionList(1);
      Get.back();
      showCustomSnackBar('transaction_added_successfully'.tr, isError: false);
      _isLoading = false;
    } else {
      _isLoading = false;
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<void> getTransactionAccountList(int offset) async {
    _fromAccountIndex = null;
    _toAccountIndex = null;
    _fromAccountIds = null;
    _toAccountIds = null;
    _isLoading = true;
    Response response = await transactionRepo.getTransactionAccountList(offset);
    if (response.statusCode == 200) {
      _accountList = [];
      _accountList!.addAll(AccountModel.fromJson(response.body).accounts!);
      if (_accountList!.isNotEmpty) {
        for (int index = 0; index < _accountList!.length; index++) {
          _fromAccountIds ??= [];
          _fromAccountIds?.add(_accountList![index].id);
        }
      }
      if (_accountList!.isNotEmpty) {
        for (int index = 0; index < _accountList!.length; index++) {
          _toAccountIds ??= [];
          _toAccountIds?.add(_accountList![index].id);
        }
        // _toAccountIndex = _toAccountIds[0];
      }

      _isLoading = false;
      _isFirst = false;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void addCustomerBalanceIntoAccountList(Accounts accounts) {
    _fromAccountIndex = null;
    _fromAccountIds = [];
    if ((_accountList!.any((e) =>
        e.id == accounts.id && Get.find<CartController>().customerId == 0))) {
      if (accounts.id == 0) {
        _accountList!.removeAt(_accountList!.length - 1);
        for (int index = 0; index < _accountList!.length; index++) {
          _fromAccountIds ??= [];
          _fromAccountIds?.add(_accountList![index].id);
        }
      } else if (_accountList!.isNotEmpty) {
        for (int index = 0; index < _accountList!.length; index++) {
          _fromAccountIds ??= [];
          _fromAccountIds?.add(_accountList![index].id);
        }
      }
    } else if ((_accountList!.any((e) =>
        e.id != accounts.id && Get.find<CartController>().customerId == 0))) {
      for (int index = 0; index < _accountList!.length; index++) {
        _fromAccountIds ??= [];
        _fromAccountIds?.add(_accountList![index].id);
      }
    } else if ((_accountList!.any((e) =>
        e.id == accounts.id && Get.find<CartController>().customerId != 0))) {
      for (int index = 0; index < _accountList!.length; index++) {
        _fromAccountIds ??= [];
        _fromAccountIds?.add(_accountList![index].id);
      }
    } else if (_accountList!.any((e) => e.id != accounts.id) &&
        Get.find<CartController>().customerId == 0) {
      for (int index = 0; index < _accountList!.length; index++) {
        _fromAccountIds ??= [];
        _fromAccountIds?.add(_accountList![index].id);
      }
    } else {
      _accountList!.add(accounts);
      if (_accountList!.isNotEmpty) {
        for (int index = 0; index < _accountList!.length; index++) {
          _fromAccountIds ??= [];
          _fromAccountIds?.add(_accountList![index].id);
        }
      }
    }

    update();
  }

  Future<void> exportTransactionList(String startDate, String endDate,
      int accountId, String transactionType) async {
    _isLoading = true;
    Response response = await transactionRepo.exportTransactionList(
        startDate, endDate, accountId, transactionType);
    if (response.statusCode == 200) {
      Map map = response.body;
      _transactionExportFilePath = map['excel_report'];
      _isLoading = false;
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }

  void removeFirstLoading() {
    _isFirst = true;
    update();
  }

  void setAccountIndex(int? index, String type, bool notify) {
    if (type == 'from') {
      _fromAccountIndex = index;
      _selectedFromAccountId = _fromAccountIndex;
    } else {
      _toAccountIndex = index;
      _selectedToAccountId = _toAccountIndex;
    }

    if (notify) {
      update();
    }
  }

  void setTransactionTypeIndex(int? index, bool notify) {
    _transactionTypeIndex = index;
    _transactionTypeName =
        _transactionTypeList![(_transactionTypeIds.indexOf(index))].tranType;
    if (notify) {
      update();
    }
  }

  DateTime? _startDate;
  DateTime? _endDate;
  final DateFormat _dateFormat = DateFormat('yyyy-MM-d');
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  DateFormat get dateFormat => _dateFormat;

  void selectDate(String type, BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    ).then((date) {
      if (type == 'start') {
        _startDate = date;
      } else {
        _endDate = date;
      }
      if (date == null) {}
      update();
    });
  }

  void resetDate() {
    _startDate = null;
    _endDate = null;
    update();
  }
}
