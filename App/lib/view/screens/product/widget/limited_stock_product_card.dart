import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/product_controller.dart';
import 'package:gotoko/controller/splash_controller.dart';
import 'package:gotoko/data/model/response/limite_stock_product_model.dart';
import 'package:gotoko/helper/price_converter.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/animated_custom_dialog.dart';
import 'package:gotoko/view/base/custom_image.dart';
import 'package:gotoko/view/base/custom_snackbar.dart';
import 'package:gotoko/view/screens/product/widget/product_quantity_update_dialog.dart';
import 'package:gotoko/view/screens/user/widget/custom_divider.dart';

class LimitedStockProductCardViewWidget extends StatelessWidget {
  final StockLimitedProducts? product;
  final bool isHome;
  final int? index;
  const LimitedStockProductCardViewWidget(
      {Key? key, this.product, this.isHome = false, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isHome
        ? Container(
            height: 40,
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('${index! + 1}.',
                        style: fontSizeRegular.copyWith(
                            color: Theme.of(context).primaryColor)),
                    const SizedBox(width: Dimensions.paddingSizeLarge),
                    Expanded(
                        child: Text('${product!.name}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: fontSizeRegular.copyWith(
                                color: Theme.of(context).primaryColor))),
                    const Spacer(),
                    Text('${product!.quantity}',
                        style: fontSizeRegular.copyWith(
                            color: Theme.of(context).primaryColor)),
                  ],
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                CustomDivider(color: Theme.of(context).hintColor, height: .5)
              ],
            ),
          )
        : Column(
            children: [
              Container(
                  height: 5,
                  color: Theme.of(context).primaryColor.withOpacity(0.06)),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.paddingSizeExtraSmall,
                  horizontal: Dimensions.paddingSizeSmall,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(
                                  Dimensions.paddingSizeBorder),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.paddingSizeMediumBorder),
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(.12),
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
                          const SizedBox(
                              width: Dimensions.paddingSizeExtraSmall),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product!.name!,
                                    style: fontSizeRegular.copyWith(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                          '${'code'.tr} : ${product!.productCode}',
                                          style: fontSizeRegular.copyWith(
                                              color:
                                                  Theme.of(context).hintColor,
                                              fontSize:
                                                  Dimensions.fontSizeSmall)),
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
                                                        .productQuantityController
                                                        .text
                                                        .trim());
                                              }

                                              if (quantity < 1) {
                                                showCustomSnackBar(
                                                    'quantity_should_be_greater_than_0'
                                                        .tr);
                                              } else {
                                                productController
                                                    .updateProductQuantity(
                                                        product!.id, quantity);
                                                Get.back();
                                              }

                                              // productController.updateProductQuantity(product!.id, quantity);
                                            },
                                          ), dismissible: false, isFlip: false);
                                        },
                                        child: Row(children: [
                                          const Icon(Icons.add_circle),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: Dimensions
                                                    .paddingSizeExtraSmall),
                                            child: Container(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: Dimensions
                                                      .paddingSizeExtraLarge,
                                                  vertical: Dimensions
                                                      .paddingSizeExtraSmall),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                borderRadius: BorderRadius
                                                    .circular(Dimensions
                                                        .paddingSizeMediumBorder),
                                              ),
                                              child:
                                                  Text('${product!.quantity}'),
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
                        padding: const EdgeInsets.only(
                            bottom: Dimensions.paddingSizeSmall),
                        child:
                            CustomDivider(color: Theme.of(context).hintColor),
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
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                        fontSize: Dimensions.fontSizeLarge,
                                      )),
                                ),
                                Text('supplier_information'.tr,
                                    style: fontSizeRegular.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: Dimensions.fontSizeLarge,
                                    )),
                                const SizedBox(
                                    height: Dimensions.paddingSizeSmall),
                                product!.supplier != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            bottom:
                                                Dimensions.paddingSizeSmall),
                                        child:
                                            Text(product!.supplier!.name ?? '',
                                                style: fontSizeRegular.copyWith(
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                  fontSize:
                                                      Dimensions.fontSizeLarge,
                                                )),
                                      )
                                    : const SizedBox(),
                                product!.supplier != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: Dimensions
                                                .paddingSizeExtraSmall),
                                        child: Text(
                                            product!.supplier!.mobile ?? '',
                                            style: fontSizeRegular.copyWith(
                                              color:
                                                  Theme.of(context).hintColor,
                                              fontSize:
                                                  Dimensions.fontSizeLarge,
                                            )),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ]),
              ),
              Container(
                  height: 5,
                  color: Theme.of(context).primaryColor.withOpacity(0.06)),
            ],
          );
  }
}
