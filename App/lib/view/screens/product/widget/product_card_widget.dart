import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/product_controller.dart';
import 'package:gotoko/controller/splash_controller.dart';
import 'package:gotoko/data/model/response/product_model.dart';
import 'package:gotoko/helper/price_converter.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/animated_custom_dialog.dart';
import 'package:gotoko/view/base/custom_image.dart';
import 'package:gotoko/view/base/custom_snackbar.dart';
import 'package:gotoko/view/base/logout_dialog.dart';
import 'package:gotoko/view/screens/product/bar_code_generator.dart';
import 'package:gotoko/view/screens/product/widget/product_quantity_update_dialog.dart';
import 'package:gotoko/view/screens/product_setup_screen/add_product_screen.dart';
import 'package:gotoko/view/screens/user/widget/custom_divider.dart';

class ProductCardViewWidget extends StatelessWidget {
  final Products? product;
  const ProductCardViewWidget({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 5, color: Theme.of(context).primaryColor.withOpacity(0.06)),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: Dimensions.paddingSizeExtraSmall,
            horizontal: Dimensions.paddingSizeSmall,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeBorder),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          Dimensions.paddingSizeMediumBorder),
                      color: Theme.of(context).primaryColor.withOpacity(.12),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            Dimensions.paddingSizeMediumBorder),
                        child: CustomImage(
                          image:
                              '${Get.find<SplashController>().configModel!.baseUrls!.productImageUrl}/${product!.image}',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          placeholder: Images.placeholder,
                        ))),
                const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product!.title!,
                          style: fontSizeRegular.copyWith(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                                '${'code'.tr} : ${product!.productCode}',
                                style: fontSizeRegular.copyWith(
                                    color: Theme.of(context).hintColor,
                                    fontSize: Dimensions.fontSizeSmall)),
                          ),
                          GetBuilder<ProductController>(
                              builder: (productController) {
                            return InkWell(
                              onTap: () {
                                showAnimatedDialog(context,
                                    ProductQuantityUpdateDialog(
                                  onYesPressed: () {
                                    int quantity = 0;
                                    if (product != null &&
                                        product?.quantity != null) {
                                      quantity = product!.quantity! +
                                          int.parse(productController
                                              .productQuantityController.text
                                              .trim());
                                    }
                                    if (quantity < 1) {
                                      showCustomSnackBar(
                                          'quantity_should_be_greater_than_0'
                                              .tr);
                                    } else {
                                      productController.updateProductQuantity(
                                          product!.id, quantity);
                                      Get.back();
                                    }
                                  },
                                ), dismissible: false, isFlip: false);
                              },
                              child: Row(children: [
                                const Icon(Icons.add_circle),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.paddingSizeExtraSmall),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.paddingSizeExtraLarge,
                                        vertical:
                                            Dimensions.paddingSizeExtraSmall),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color:
                                              Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.paddingSizeMediumBorder),
                                    ),
                                    child: Text('${product!.quantity}'),
                                  ),
                                ),
                              ]),
                            );
                          })
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
              child: CustomDivider(color: Theme.of(context).hintColor),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: Dimensions.paddingSizeSmall),
                        child: Text(
                            '${'purchase_price'.tr} : ${PriceConverter.priceWithSymbol(product!.sellingPrice!)}',
                            style: fontSizeRegular.copyWith(
                              color: Theme.of(context).secondaryHeaderColor,
                              fontSize: Dimensions.fontSizeLarge,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: Dimensions.paddingSizeExtraSmall),
                        child: Text(
                            '${'selling_price'.tr} : ${PriceConverter.priceWithSymbol(product!.sellingPrice!)}',
                            style: fontSizeRegular.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: Dimensions.fontSizeLarge,
                            )),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('supplier_information'.tr,
                          style: fontSizeRegular.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: Dimensions.fontSizeLarge,
                          )),
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      product!.supplier != null
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  bottom: Dimensions.paddingSizeSmall),
                              child: Text(product!.supplier!.name ?? '',
                                  style: fontSizeRegular.copyWith(
                                    color: Theme.of(context).hintColor,
                                    fontSize: Dimensions.fontSizeLarge,
                                  )),
                            )
                          : const SizedBox(),
                      product!.supplier != null
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  bottom: Dimensions.paddingSizeExtraSmall),
                              child: Text(product!.supplier!.mobile ?? '',
                                  style: fontSizeRegular.copyWith(
                                    color: Theme.of(context).hintColor,
                                    fontSize: Dimensions.fontSizeLarge,
                                  )),
                            )
                          : const SizedBox(),
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(BarCodeGenerateScreen(product: product));
                    Get.find<ProductController>().setBarCodeQuantity(4);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeSmall),
                    child: SizedBox(
                        width: Dimensions.iconSizeSmall,
                        height: Dimensions.iconSizeSmall,
                        child: Image.asset(Images.barCode)),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          AddProductScreen(product: product))),
                  child: SizedBox(
                      width: Dimensions.iconSizeSmall,
                      height: Dimensions.iconSizeSmall,
                      child: Image.asset(Images.editIcon)),
                ),
                GetBuilder<ProductController>(builder: (productController) {
                  return InkWell(
                    onTap: () {
                      showAnimatedDialog(
                          context,
                          CustomDialog(
                            delete: true,
                            icon: Icons.exit_to_app_rounded,
                            title: '',
                            description:
                                'are_you_sure_you_want_to_delete_product'.tr,
                            onTapFalse: () => Navigator.of(context).pop(true),
                            onTapTrue: () {
                              productController.deleteProduct(product!.id);
                            },
                            onTapTrueText: 'yes'.tr,
                            onTapFalseText: 'cancel'.tr,
                          ),
                          dismissible: false,
                          isFlip: true);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeSmall),
                      child: SizedBox(
                          width: Dimensions.iconSizeSmall,
                          height: Dimensions.iconSizeSmall,
                          child: Image.asset(Images.deleteIcon)),
                    ),
                  );
                }),
              ],
            )
          ]),
        ),
        Container(
            height: 5, color: Theme.of(context).primaryColor.withOpacity(0.06)),
      ],
    );
  }
}
