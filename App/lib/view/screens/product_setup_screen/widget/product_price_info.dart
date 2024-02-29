import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/product_controller.dart';
import 'package:gotoko/controller/supplier_controller.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_text_field.dart';
import 'package:gotoko/view/base/custom_field_with_title.dart';

class ProductPriceInfo extends StatefulWidget {
  const ProductPriceInfo({Key? key}) : super(key: key);

  @override
  State<ProductPriceInfo> createState() => _ProductPriceInfoState();
}

class _ProductPriceInfoState extends State<ProductPriceInfo> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (productController) {
      return Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFieldWithTitle(
                    customTextField: CustomTextField(
                      hintText: 'selling_price_hint'.tr,
                      controller:
                          productController.productSellingPriceController,
                      inputType: TextInputType.number,
                    ),
                    title: 'selling_price'.tr,
                    requiredField: true,
                  ),
                  CustomFieldWithTitle(
                    customTextField: CustomTextField(
                      hintText: 'purchase_price_hint'.tr,
                      controller:
                          productController.productPurchasePriceController,
                      inputType: TextInputType.number,
                    ),
                    title: 'purchase_price'.tr,
                    requiredField: true,
                  ),
                  Container(
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
                              value: productController.discountTypeIndex == 0
                                  ? 'percent'
                                  : 'amount',
                              items: <String>['percent', 'amount']
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value.tr),
                                );
                              }).toList(),
                              onChanged: (value) {
                                productController
                                    .setSelectedDiscountType(value);
                                productController.setDiscountTypeIndex(
                                    value == 'percent' ? 0 : 1, true);
                              },
                              isExpanded: true,
                              underline: const SizedBox(),
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  CustomFieldWithTitle(
                    customTextField: CustomTextField(
                      hintText: 'discount_hint'.tr,
                      controller: productController.productDiscountController,
                      inputType: TextInputType.number,
                    ),
                    title: 'discount_percentage'.tr,
                    requiredField: true,
                  ),
                  CustomFieldWithTitle(
                    customTextField: CustomTextField(
                      hintText: 'tax_hint'.tr,
                      controller: productController.productTaxController,
                      inputType: TextInputType.number,
                    ),
                    title: '${'tax'.tr}  (%)',
                    requiredField: true,
                  ),
                  GetBuilder<SupplierController>(builder: (supplierController) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(
                          Dimensions.paddingSizeDefault,
                          0,
                          Dimensions.paddingSizeDefault,
                          0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'select_supplier'.tr,
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
                                    width: .5,
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(.7)),
                                borderRadius: BorderRadius.circular(
                                    Dimensions.paddingSizeMediumBorder)),
                            child: DropdownButton<int>(
                              value: supplierController.supplierIndex,
                              items: supplierController.supplierIds
                                  .map((int? value) {
                                return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value != 0
                                        ? supplierController
                                            .supplierList[(supplierController
                                                    .supplierIds
                                                    .indexOf(value) -
                                                1)]
                                            .name!
                                        : 'select'.tr));
                              }).toList(),
                              onChanged: (int? value) {
                                supplierController.setSupplierIndex(
                                    value, true);
                              },
                              isExpanded: true,
                              underline: const SizedBox(),
                            ),
                          ),
                          const SizedBox(height: Dimensions.paddingSizeSmall),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
