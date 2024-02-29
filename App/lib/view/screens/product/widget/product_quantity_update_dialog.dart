import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/product_controller.dart';
import 'package:gotoko/util/color_resources.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/view/base/custom_button.dart';
import 'package:gotoko/view/base/custom_field_with_title.dart';
import 'package:gotoko/view/base/custom_text_field.dart';

class ProductQuantityUpdateDialog extends StatelessWidget {
  final Function onYesPressed;
  const ProductQuantityUpdateDialog({Key? key, required this.onYesPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
        child: GetBuilder<ProductController>(builder: (productController) {
          return Container(
            padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomFieldWithTitle(
                  customTextField: CustomTextField(
                    hintText: 'product_quantity_hint'.tr,
                    controller: productController.productQuantityController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9-]'))
                    ],
                    inputType: TextInputType.number,
                  ),
                  title: 'update_product_quantity'.tr,
                  requiredField: true,
                  toolTipsMessage: 'to_decrease_product'.tr,
                ),
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
                          onPressed: () => onYesPressed(),
                        )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }));
  }
}
