import 'package:get/get.dart';
import 'package:gotoko/data/api/api_client.dart';
import 'package:gotoko/data/model/response/transaction_model.dart';
import 'package:gotoko/util/app_constants.dart';

class TransactionRepo {
  ApiClient apiClient;
  TransactionRepo({required this.apiClient});

  Future<Response> getTransactionAccountList(int offset) async {
    return await apiClient.getData(
        '${AppConstants.transactionAccountListUri}?limit=10&offset=$offset');
  }

  Future<Response> getCustomerWiseTransactionList(
      int? customerId, int offset) async {
    return await apiClient.getData(
        '${AppConstants.customerWiseTransactionListUri}?customer_id=$customerId&limit=10&offset=$offset');
  }

  Future<Response> getTransactionTypeList() async {
    return await apiClient.getData(AppConstants.transactionTypeListUri);
  }

  Future<Response> getTransactionList(int offset) async {
    return await apiClient
        .getData('${AppConstants.transactionListUri}?limit=10&offset=$offset');
  }

  Future<Response> exportTransactionList(String startDate, String endDate,
      int accountId, String transactionType) async {
    return await apiClient.getData(
        '${AppConstants.transactionListExportUri}?from=$startDate&to=$endDate&account_id=$accountId&transaction_type=$transactionType');
  }

  Future<Response> getTransactionFilter(String startDate, String endDate,
      int? accountId, String? transactionType, int offset) async {
    return await apiClient.getData('${AppConstants.transactionFilterUri}?'
        'from=$startDate&to=$endDate&account_id=$accountId&tran_type=$transactionType&limit=10&offset=$offset');
  }

  Future<Response> addNewTransaction(
      Transfers transfer, int? fromAccountId, int? toAccountId) async {
    return await apiClient.postData(AppConstants.transactionAddUri, {
      'account_from_id': fromAccountId,
      'account_to_id': toAccountId,
      'amount': transfer.amount,
      'description': transfer.description,
      'date': transfer.date
    });
  }
}
