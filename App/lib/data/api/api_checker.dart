import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:gotoko/controller/splash_controller.dart';
import 'package:gotoko/view/base/custom_snackbar.dart';
import 'package:gotoko/view/screens/auth/log_in_screen.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      Get.find<SplashController>().removeSharedData();
      Get.to(() => const LogInScreen());
      // TODO: Auth Login
    } else {
      showCustomSnackBar(response.statusText);
    }
  }

  static Future<Response> getResponse(http.StreamedResponse response) async {
    var r = await http.Response.fromStream(response);
    String error = '';
    try {
      error = jsonDecode(r.body)['errors'][0]['message'];
    } catch (e) {
      error = jsonDecode(r.body)['message'] ?? 'failed'.tr;
    }
    return Response(statusText: error, statusCode: response.statusCode);
  }
}
