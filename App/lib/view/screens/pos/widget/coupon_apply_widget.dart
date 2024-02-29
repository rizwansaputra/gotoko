import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/cart_controller.dart';
import 'package:gotoko/controller/customer_controller.dart';
import 'package:gotoko/util/color_resources.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/view/base/custom_button.dart';
import 'package:gotoko/view/base/custom_field_with_title.dart';
import 'package:gotoko/view/base/custom_text_field.dart';

class CouponDialog extends StatelessWidget {
  const CouponDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      child: GetBuilder<CartController>(builder: (cartController) {
        return Container(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomFieldWithTitle(
                customTextField: CustomTextField(
                  hintText: 'coupon_code_hint'.tr,
                  controller: cartController.couponController,
                ),
                title: 'coupon_code'.tr,
                requiredField: true,
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                            buttonText: 'cancel'.tr,
                            buttonColor: Theme.of(context).hintColor,
                            textColor: ColorResources.getTextColor(),
                            isClear: true,
                            onPressed: () => Get.back())),
                    const SizedBox(width: Dimensions.paddingSizeDefault),
                    Expanded(
                        child: CustomButton(
                      buttonText: 'apply'.tr,
                      onPressed: () {
                        if (cartController.couponController.text
                            .trim()
                            .isNotEmpty) {
                          cartController.getCouponDiscount(
                              cartController.couponController.text.trim(),
                              Get.find<CustomerController>()
                                  .customerList[(Get.find<CustomerController>()
                                      .customerIds
                                      .indexOf(Get.find<CustomerController>()
                                          .customerIndex))]
                                  .id,
                              cartController.amount);
                        }

                        Get.back();
                      },
                    )),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
