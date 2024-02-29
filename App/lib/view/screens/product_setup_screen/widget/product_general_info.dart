import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/brand_controller.dart';
import 'package:gotoko/controller/category_controller.dart';
import 'package:gotoko/controller/product_controller.dart';
import 'package:gotoko/controller/splash_controller.dart';
import 'package:gotoko/controller/unit_controller.dart';
import 'package:gotoko/data/model/response/product_model.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_text_field.dart';
import 'package:gotoko/view/base/custom_field_with_title.dart';

class ProductGeneralInfo extends StatefulWidget {
  final Products? product;
  const ProductGeneralInfo({Key? key, this.product}) : super(key: key);

  @override
  State<ProductGeneralInfo> createState() => _ProductGeneralInfoState();
}

extension RandomOfDigits on Random {
  int nextIntOfDigits(int digitCount) {
    assert(1 <= digitCount && digitCount <= 9);
    int? min = (digitCount == 1 ? 0 : pow(10, digitCount - 1)) as int?;
    int? max = pow(10, digitCount) as int?;
    return min! + nextInt(max! - min);
  }
}

class _ProductGeneralInfoState extends State<ProductGeneralInfo> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height * 0.5;
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
                        hintText: 'product_name_hint'.tr,
                        controller: productController.productNameController),
                    title: 'product_name'.tr,
                    requiredField: true,
                  ),
                  GetBuilder<BrandController>(builder: (brandController) {
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
                            'select_brand'.tr,
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
                              menuMaxHeight: height,
                              value: brandController.brandIndex,
                              items: brandController.brandIds.map((int? value) {
                                return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value != 0
                                        ? brandController
                                            .brandList![(brandController
                                                    .brandIds
                                                    .indexOf(value) -
                                                1)]
                                            .name!
                                        : 'select'.tr));
                              }).toList(),
                              onChanged: (int? value) {
                                brandController.setBrandIndex(value, true);
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
                  GetBuilder<CategoryController>(builder: (categoryController) {
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
                            'select_category'.tr,
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
                                  Dimensions.paddingSizeMediumBorder),
                            ),
                            child: DropdownButton<int>(
                              menuMaxHeight: height,
                              value: categoryController.categoryIndex,
                              items: categoryController.categoryIds
                                  .map((int? value) => DropdownMenuItem<int>(
                                        value: categoryController.categoryIds
                                            .indexOf(value),
                                        child: Text(
                                          value != 0
                                              ? categoryController
                                                  .categoryList[
                                                      (categoryController
                                                              .categoryIds
                                                              .indexOf(value) -
                                                          1)]
                                                  .name!
                                              : 'select'.tr,
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (int? value) => categoryController
                                  .setCategoryIndex(value!, true),
                              isExpanded: true,
                              underline: const SizedBox(),
                            ),
                          ),
                          const SizedBox(height: Dimensions.paddingSizeSmall),
                        ],
                      ),
                    );
                  }),
                  GetBuilder<CategoryController>(builder: (categoryController) {
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
                            'select_sub_category'.tr,
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
                              menuMaxHeight: height,
                              value: categoryController.subCategoryIndex,
                              hint: Text('select'.tr),
                              items: categoryController.subCategoryIds
                                  ?.map((int? value) {
                                return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(
                                        '${categoryController.subCategoryList?[(categoryController.subCategoryIds!.indexOf(value))].name}'));
                              }).toList(),
                              onChanged: (int? value) {
                                categoryController.setSubCategoryIndex(
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
                  GetBuilder<UnitController>(builder: (unitController) {
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
                            'select_unit'.tr,
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
                              value: unitController.unitIndex,
                              items: unitController.unitIds.map((int? value) {
                                return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value != 0
                                        ? unitController
                                            .unitList![(unitController.unitIds
                                                    .indexOf(value) -
                                                1)]
                                            .unitType!
                                        : 'select'.tr));
                              }).toList(),
                              onChanged: (int? value) {
                                unitController.setUnitIndex(value, true);
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
                  CustomFieldWithTitle(
                    customTextField: CustomTextField(
                      hintText: 'sku_hint'.tr,
                      controller: productController.unitValueController,
                      inputType: TextInputType.number,
                    ),
                    title: 'unit_value'.tr,
                    requiredField: true,
                  ),
                  CustomFieldWithTitle(
                    onTap: () {
                      var rng = Random();
                      //var code = rng.nextInt(900000) + 100000;
                      var number = "";
                      var randomnumber = Random();
                      //chnage i < 15 on your digits need
                      for (var i = 0; i < 13; i++) {
                        number = number + randomnumber.nextInt(9).toString();
                      }
                      productController.productSkuController.text =
                          number.toString();
                    },
                    isSKU: true,
                    customTextField: CustomTextField(
                        hintText: 'sku_hint'.tr,
                        controller: productController.productSkuController),
                    title: 'sku'.tr,
                    requiredField: true,
                  ),
                  CustomFieldWithTitle(
                    customTextField: CustomTextField(
                      hintText: 'stock_quantity_hint'.tr,
                      controller: productController.productStockController,
                      inputType: TextInputType.number,
                    ),
                    title: 'stock_quantity'.tr,
                    requiredField: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                        Dimensions.paddingSizeDefault,
                        0,
                        Dimensions.paddingSizeDefault,
                        0),
                    child: Text(
                      'product_image'.tr,
                      style: fontSizeRegular.copyWith(
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  GetBuilder<ProductController>(builder: (productController) {
                    return Align(
                        alignment: Alignment.center,
                        child: Stack(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                Dimensions.paddingSizeSmall),
                            child: productController.productImage != null
                                ? Image.file(
                                    File(productController.productImage!.path),
                                    width: 150,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  )
                                : widget.product != null
                                    ? FadeInImage.assetNetwork(
                                        placeholder: Images.placeholder,
                                        image:
                                            '${Get.find<SplashController>().baseUrls!.productImageUrl}/${widget.product!.image ?? ''}',
                                        height: 120,
                                        width: 150,
                                        fit: BoxFit.cover,
                                        imageErrorBuilder: (c, o, s) =>
                                            Image.asset(Images.placeholder,
                                                height: 120,
                                                width: 150,
                                                fit: BoxFit.cover),
                                      )
                                    : Image.asset(
                                        Images.placeholder,
                                        height: 120,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            top: 0,
                            left: 0,
                            child: InkWell(
                              onTap: () => productController.pickImage(false),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.paddingSizeSmall),
                                  border: Border.all(
                                      width: 1,
                                      color: Theme.of(context).primaryColor),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(25),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.white),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.camera_alt,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ]));
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
