import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/util/color_resources.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/view/base/custom_button.dart';

class ConfirmPurchaseDialog extends StatelessWidget {
  final Function? onYesPressed;
  const ConfirmPurchaseDialog({Key? key, required this.onYesPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
        child: Container(
          padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
          height: 210,
          child: Column(
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: Image.asset(Images.confirmPurchase),
              ),
              Text('confirm_purchase'.tr),
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: SizedBox(
                  height: 40,
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
                        buttonText: 'yes'.tr,
                        onPressed: () {
                          onYesPressed!();
                          Get.back();
                        },
                      )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
