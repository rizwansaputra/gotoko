import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/coupon_controller.dart';
import 'package:gotoko/data/model/response/coupon_model.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/styles.dart';

class SearchedCouponItemWidget extends StatelessWidget {
  final Coupons? coupon;
  const SearchedCouponItemWidget({Key? key, this.coupon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<CouponController>(builder: (couponController) {
        return Row(children: [
          Text(
            '${'coupon_title'.tr} : ${coupon!.title}',
            style:
                fontSizeRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            width: Dimensions.paddingSizeDefault,
          ),
          Expanded(
              child: Text(
            '${'coupon_code'.tr} : ${coupon!.couponCode}',
            style:
                fontSizeRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ))
        ]);
      }),
    );
  }
}
