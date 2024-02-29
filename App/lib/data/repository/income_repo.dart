import 'package:get/get.dart';
import 'package:gotoko/data/api/api_client.dart';
import 'package:gotoko/data/model/response/income_model.dart';
import 'package:gotoko/util/app_constants.dart';

class IncomeRepo {
  ApiClient apiClient;
  IncomeRepo({required this.apiClient});

  Future<Response> getIncomeList(int offset) async {
    return await apiClient
        .getData('${AppConstants.getInvoiceList}?limit=10&offset=$offset');
  }

  Future<Response> getIncomesFilter(String startDate, String endDate) async {
    return await apiClient.getData(
        '${AppConstants.filterIncomeList}?from=$startDate&to=$endDate');
  }

  Future<Response> addNewIncome(Incomes income) async {
    return await apiClient.postData(AppConstants.addNewIncome, {
      'account_id': income.accountId,
      'amount': income.amount,
      'description': income.description,
      'date': income.date
    });
  }
}
