import 'package:get/get.dart';
import 'package:gotoko/data/api/api_client.dart';
import 'package:gotoko/util/app_constants.dart';

class OrderRepo {
  ApiClient apiClient;
  OrderRepo({required this.apiClient});

  Future<Response> getOrderList(String offset) async {
    return await apiClient
        .getData('${AppConstants.orderListUri}?limit=10&offset=$offset');
  }

  Future<Response> getInvoiceData(int? orderId) async {
    return await apiClient.getData('${AppConstants.invoice}?order_id=$orderId');
  }
}
