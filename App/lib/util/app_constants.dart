import 'package:gotoko/data/model/response/language_model.dart';
import 'package:gotoko/util/images.dart';

class AppConstants {
  static const String appName = 'GoToko';
  static const bool demo = false;
  static const String baseUrl = 'https://toko.mwend.com';
  static const String configUri = '/api/v1/config';
  static const String loginUri = '/api/v1/login';
  static const String profileUri = '/api/v1/delivery-man/profile?token=';
  static const String tokenUri = '/api/v1/delivery-man/update-fcm-token';
  static const String orderListUri = '/api/v1/pos/order/list';
  static const String invoice = '/api/v1/pos/invoice';
  static const String addCategoryUri = '/api/v1/category/store';
  static const String getCategoryListUri = '/api/v1/category/list';
  static const String addSubCategoryUri = '/api/v1/sub/category/store';
  static const String updateSubCategoryUri = '/api/v1/sub/category/update';
  static const String getSubCategoryListUri = '/api/v1/sub/category/list';
  static const String getUnitList = '/api/v1/unit/list';
  static const String addUnitUri = '/api/v1/unit/store';
  static const String deleteUnitUri = '/api/v1/unit/delete';
  static const String updateUnitUri = '/api/v1/unit/update';
  static const String addBrandUri = '/api/v1/brand/store';
  static const String getBrandListUri = '/api/v1/brand/list';
  static const String deleteBrandUri = '/api/v1/brand/delete';
  static const String updateBrandUri = '/api/v1/brand/update';
  static const String addSupplierUri = '/api/v1/supplier/store';
  static const String getSupplierListUri = '/api/v1/supplier/list';
  static const String searchSupplierUri = '/api/v1/supplier/search';
  static const String deleteSupplierUri = '/api/v1/supplier/delete';
  static const String updateSupplierUri = '/api/v1/supplier/update';
  static const String getAccountListUri = '/api/v1/account/list';
  static const String searchAccountUri = '/api/v1/account/search';
  static const String addNewAccount = '/api/v1/account/save';
  static const String updateAccountUri = '/api/v1/account/update';
  static const String deleteAccountUri = '/api/v1/account/delete';
  static const String addNewExpense = '/api/v1/transaction/expense';
  static const String updateExpenseUri = '/api/v1/transaction/update';
  static const String deleteExpenseUri = '/api/v1/transaction/delete';
  static const String getExpenseListUri = '/api/v1/transaction/exp/list';
  static const String expenseFilterByDate =
      '/api/v1/transaction/expense/search';
  static const String getCustomerListUri = '/api/v1/customer/list';
  static const String customerSearchUri = '/api/v1/customer/search';
  static const String addNewCustomerUri = '/api/v1/customer/store';
  static const String updateCustomerUri = '/api/v1/customer/update';
  static const String deleteCustomerUri = '/api/v1/customer/delete';
  static const String addNewCoupon = '/api/v1/coupon/store';
  static const String getCouponListUri = '/api/v1/coupon/list';
  static const String updateCouponUri = '/api/v1/coupon/update';
  static const String updateCouponStatus = '/api/v1/coupon/status';
  static const String deleteCouponUri = '/api/v1/coupon/delete';
  static const String addProductUri = '/api/v1/product/store';
  static const String updateProductUri = '/api/v1/product/update';
  static const String getProductUri = '/api/v1/product/list';
  static const String getLimitedStockProductUri =
      '/api/v1/dashboard/product/limited-stock';
  static const String getProfileUri = '/api/v1/profile';
  static const String updateShopUri = '/api/v1/update/shop';
  static const String getDashboardRevenueSummeryUri =
      '/api/v1/dashboard/revenue-summary';
  static const String getDownloadSampleFileUri =
      '/api/v1/product/download/excel/sample';
  static const String bulkExportProductUri = '/api/v1/product/export';
  static const String bulkImportProductUri = '/api/v1/product/import';
  static const String categoriesProductUri = '/api/v1/product/category-wise';
  static const String getProductFromProduceCodeUri =
      '/api/v1/product/code/search';
  static const String getCouponDiscount = '/api/v1/coupon/check';
  static const String placeOrderUri = '/api/v1/pos/place/order';
  static const String getProductFromProductCode = '/api/v1/product/code/search';
  static const String getRevenueChartData = '/api/v1/dashboard/monthly/revenue';
  static const String updateProductQuantity =
      '/api/v1/dashboard/quantity/increase';
  static const String productDeleteUri = '/api/v1/product/delete';
  static const String productSearchUri = '/api/v1/product/search';
  static const String deleteCategoryUri = '/api/v1/category/delete';
  static const String updateCategoryUri = '/api/v1/category/update';
  static const String updateCategoryStatusUri = '/api/v1/category/status';
  static const String transactionAddUri = '/api/v1/transaction/fund/transfer';
  static const String transactionListUri = '/api/v1/transaction/transfer-list';
  static const String transactionFilterUri = '/api/v1/transaction/filter';
  static const String transactionTypeListUri = '/api/v1/transaction/types';
  static const String transactionListExportUri =
      '/api/v1/transaction/transfer/export';
  static const String transactionAccountListUri =
      '/api/v1/transaction/transfer/accounts';
  static const String customerWiseOrderListUri = '/api/v1/pos/customer/orders';
  static const String customerWiseTransactionListUri =
      '/api/v1/customer/transaction';
  static const String supplierProfileUri = '/api/v1/supplier/details';
  static const String supplierProductListUri = '/api/v1/product/supplier/wise';
  static const String supplierTransactionListUri =
      '/api/v1/supplier/transactions';
  static const String supplierTransactionFilterListUri =
      '/api/v1/supplier/transactions/date/filter';
  static const String newPurchaseFromSupplier = '/api/v1/supplier/new/purchase';
  static const String supplierPayment = '/api/v1/supplier/payment';
  static const String addNewIncome = '/api/v1/income/store';
  static const String getInvoiceList = '/api/v1/income/list';
  static const String filterIncomeList = '/api/v1/income/filter';
  static const String customerBalanceUpdate = '/api/v1/customer/update/balance';
  static const String barCodeDownload = '/api/v1/product/barcode/generate';

  // Shared Key
  static const String theme = 'theme';
  static const String token = 'token';
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';
  static const String cartList = 'cart_list';
  static const String customerCartList = 'customer_cart_list';
  static const String userPassword = 'user_password';
  static const String userAddress = 'user_address';
  static const String userEmail = 'USER_EMAIL';
  static const String searchAddress = 'search_address';
  static const String topic = 'notify';
  static const String userCountryCode = 'user_country_code';

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.indonesia,
        languageName: 'Indonesia',
        countryCode: 'ID',
        languageCode: 'id'),
    LanguageModel(
        imageUrl: Images.unitedKingdom,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
  ];
}
