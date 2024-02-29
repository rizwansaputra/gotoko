import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/coupon_controller.dart';
import 'package:gotoko/data/model/response/coupon_model.dart';
import 'package:gotoko/util/color_resources.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/animated_custom_dialog.dart';
import 'package:gotoko/view/base/logout_dialog.dart';
import 'package:gotoko/view/screens/coupon/add_coupon_screen.dart';

class CouponCardWidget extends StatelessWidget {
  final int? index;
  final Coupons? coupon;
  const CouponCardWidget({Key? key, this.coupon, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return coupon != null
        ? Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault,
                vertical: Dimensions.paddingSizeMediumBorder),
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(
                      Dimensions.paddingSizeDefault,
                      Dimensions.paddingSizeDefault,
                      Dimensions.paddingSizeDefault,
                      Dimensions.paddingSizeDefault),
                  decoration: BoxDecoration(color: Theme.of(context).cardColor),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                  child: Text('${coupon!.title}',
                                      style: fontSizeBold.copyWith(
                                        fontSize: Dimensions.fontSizeDefault,
                                        overflow: TextOverflow.ellipsis,
                                      ))),
                              const SizedBox(
                                  width: Dimensions.paddingSizeExtraSmall),
                              Text(
                                "(${"code".tr}:${coupon!.couponCode})",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: fontSizeRegular.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: ColorResources.primaryColor
                                      .withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall),
                          Text(
                              '${'discount_type'.tr} : ${coupon!.discountType!}',
                              style: fontSizeRegular.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: ColorResources.primaryColor
                                      .withOpacity(0.8))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${'validity'.tr} : ${coupon!.expireDate!}',
                                  style: fontSizeRegular.copyWith(
                                      fontSize: Dimensions.fontSizeSmall,
                                      color: ColorResources.primaryColor
                                          .withOpacity(0.8))),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.paddingSizeSmall),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GetBuilder<CouponController>(
                                        builder: (couponController) => Switch(
                                            value: coupon!.status == 1,
                                            activeColor:
                                                ColorResources.primaryColor,
                                            onChanged: (value) =>
                                                couponController
                                                    .toggleCouponStatus(
                                                        coupon!.id,
                                                        coupon!.status == 1
                                                            ? 0
                                                            : 1,
                                                        index))),
                                    InkWell(
                                        onTap: () {
                                          Get.to(() => AddCouponScreen(
                                                coupon: coupon,
                                              ));
                                        },
                                        child: SizedBox(
                                            height: Dimensions
                                                .paddingSizeExtraExtraLarge,
                                            width: Dimensions
                                                .paddingSizeExtraExtraLarge,
                                            child:
                                                Image.asset(Images.editIcon))),
                                    GetBuilder<CouponController>(
                                        builder: (couponController) {
                                      return InkWell(
                                          onTap: () {
                                            showAnimatedDialog(
                                                context,
                                                CustomDialog(
                                                  delete: true,
                                                  icon:
                                                      Icons.exit_to_app_rounded,
                                                  title: '',
                                                  description:
                                                      'are_you_sure_you_want_to_delete_coupon'
                                                          .tr,
                                                  onTapFalse: () =>
                                                      Navigator.of(context)
                                                          .pop(true),
                                                  onTapTrue: () {
                                                    couponController
                                                        .deleteCoupon(
                                                            coupon!.id);
                                                  },
                                                  onTapTrueText: 'yes'.tr,
                                                  onTapFalseText: 'cancel'.tr,
                                                ),
                                                dismissible: false,
                                                isFlip: true);
                                          },
                                          child: SizedBox(
                                              height: Dimensions
                                                  .paddingSizeExtraLarge,
                                              width: Dimensions
                                                  .paddingSizeExtraLarge,
                                              child: Image.asset(
                                                  Images.deleteIcon)));
                                    }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                  '${'min_purchase'.tr} : ${coupon!.minPurchase!}',
                                  style: fontSizeRegular.copyWith(
                                      fontSize: Dimensions.fontSizeSmall,
                                      color: ColorResources.primaryColor
                                          .withOpacity(0.8))),
                              const SizedBox(
                                  width: Dimensions.paddingSizeExtraSmall),
                              Text(
                                  '${'max_discount'.tr} : ${coupon!.maxDiscount!}',
                                  style: fontSizeRegular.copyWith(
                                      fontSize: Dimensions.fontSizeSmall,
                                      color: ColorResources.primaryColor
                                          .withOpacity(0.8))),
                            ],
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
