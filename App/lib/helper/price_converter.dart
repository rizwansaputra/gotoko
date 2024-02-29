import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/splash_controller.dart';
import 'package:intl/intl.dart';

class PriceConverter {
  static String convertPrice(BuildContext context, double? price,
      {double? discount, String? discountType}) {
    if (discount != null) {
      if (discountType == 'amount' || discountType == null) {
        price = price! - discount;
      } else if (discountType == 'percent') {
        price = price! - ((discount / 100) * price);
      }
    }
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return currencyFormatter.format(price);
    //return '${Get.find<SplashController>().configModel!.currencySymbol} '
    //    '${price!.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  static String convertWithDiscount(BuildContext context, double price,
      double discount, String discountType) {
    if (discountType == 'amount') {
      price = price - discount;
    } else if (discountType == 'percent') {
      price = price - ((discount / 100) * price);
    }
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return currencyFormatter.format(price);
    //return '${Get.find<SplashController>().configModel!.currencySymbol}'
    //   '$price';
  }

  static double discountCalculation(BuildContext context, double price,
      double discount, String? discountType) {
    if (discountType == 'amount') {
      discount = discount;
    } else if (discountType == 'percent') {
      discount = ((discount / 100) * price);
    }
    return discount;
  }

  static String discountCalculationWithOutSymbol(BuildContext context,
      double price, double discount, String? discountType) {
    if (discountType == 'amount') {
      discount = discount;
    } else if (discountType == 'percent') {
      discount = ((discount / 100) * price);
    }
    return discount.toStringAsFixed(2);
  }

  static String calculation(
      double amount, double discount, String type, int quantity) {
    double calculatedAmount = 0;
    if (type == 'amount') {
      calculatedAmount = discount * quantity;
    } else if (type == 'percent') {
      calculatedAmount = (discount / 100) * (amount * quantity);
    }
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return currencyFormatter.format(calculatedAmount);
    //return '${Get.find<SplashController>().configModel!.currencySymbol} ${calculatedAmount.toStringAsFixed(2)}';
  }

  static String percentageCalculation(BuildContext context, String price,
      String discount, String discountType) {
    return '$discount${discountType == 'percent' ? '%' : '${Get.find<SplashController>().configModel!.currencySymbol}'} OFF';
  }

  static String priceWithSymbol(double amount) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return currencyFormatter.format(amount);
    // return '${Get.find<SplashController>().configModel!.currencySymbol} ${amount.toStringAsFixed(2)}';
  }
}
