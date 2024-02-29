import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/cart_controller.dart';
import 'package:gotoko/util/color_resources.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_button.dart';
import 'package:gotoko/view/base/custom_field_with_title.dart';
import 'package:gotoko/view/base/custom_text_field.dart';

class ExtraDiscountAndCouponDialog extends StatelessWidget {
  final double totalAmount;
  const ExtraDiscountAndCouponDialog({Key? key, required this.totalAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      child: GetBuilder<CartController>(builder: (cartController) {
        return Container(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          height: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Text('extra_discount'.tr,
                    style: fontSizeMedium.copyWith(
                        color: Theme.of(context).secondaryHeaderColor)),
              ),
              GetBuilder<CartController>(builder: (cartController) {
                return Container(
                  padding: const EdgeInsets.fromLTRB(
                      Dimensions.paddingSizeDefault,
                      0,
                      Dimensions.paddingSizeDefault,
                      0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'discount_type'.tr,
                          style: fontSizeRegular.copyWith(
                              color: Theme.of(context).primaryColor),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeSmall),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            border: Border.all(
                                width: .7,
                                color: Theme.of(context)
                                    .hintColor
                                    .withOpacity(.3)),
                            borderRadius: BorderRadius.circular(
                                Dimensions.paddingSizeExtraSmall),
                          ),
                          child: DropdownButton<String>(
                            value: cartController.discountTypeIndex == 0
                                ? 'amount'
                                : 'percent',
                            items: <String>['amount', 'percent']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value.tr),
                              );
                            }).toList(),
                            onChanged: (value) {
                              cartController.setSelectedDiscountType(value);
                              cartController.setDiscountTypeIndex(
                                  value == 'amount' ? 0 : 1, true);
                            },
                            isExpanded: true,
                            underline: const SizedBox(),
                          ),
                        ),
                      ]),
                );
              }),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              CustomFieldWithTitle(
                customTextField: CustomTextField(
                  hintText: 'discount_hint'.tr,
                  controller: cartController.extraDiscountController,
                  inputType: TextInputType.number,
                ),
                title: 'discount_percentage'.tr,
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
                        cartController
                            .applyCouponCodeAndExtraDiscount(totalAmount);
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
