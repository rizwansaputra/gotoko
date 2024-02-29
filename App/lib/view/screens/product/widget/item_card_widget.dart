import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/cart_controller.dart';
import 'package:gotoko/controller/splash_controller.dart';
import 'package:gotoko/data/model/response/cart_model.dart';
import 'package:gotoko/data/model/response/categories_product_model.dart';
import 'package:gotoko/helper/price_converter.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_image.dart';
import 'package:gotoko/view/base/custom_snackbar.dart';

class ItemCardWidget extends StatelessWidget {
  final int? index;
  final CategoriesProduct? categoriesProduct;
  const ItemCardWidget({Key? key, this.categoriesProduct, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {
      return InkWell(
        onTap: () {
          if (categoriesProduct!.quantity! < 1) {
            showCustomSnackBar('stock_out'.tr);
          } else {
            CartModel cartModel = CartModel(
                categoriesProduct!.sellingPrice,
                categoriesProduct!.discount,
                1,
                categoriesProduct!.tax,
                categoriesProduct);
            cartController.addToCart(cartModel);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeBorder),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeBorder),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(.03),
                    borderRadius:
                        BorderRadius.circular(Dimensions.paddingSizeBorder),
                  ),
                  width: Dimensions.productImageSizeItem,
                  height: Dimensions.productImageSizeItem,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(Dimensions.paddingSizeBorder),
                    child: CustomImage(
                        image:
                            '${Get.find<SplashController>().configModel!.baseUrls!.productImageUrl}/${categoriesProduct!.image}',
                        placeholder: Images.placeholder,
                        fit: BoxFit.cover,
                        width: Dimensions.productImageSizeItem,
                        height: Dimensions.productImageSizeItem),
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
              SizedBox(
                  height: 30,
                  child: Text(
                    categoriesProduct!.title!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: fontSizeRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault),
                    textAlign: TextAlign.center,
                  )),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              categoriesProduct!.discount! > 0
                  ? Text(
                      PriceConverter.priceWithSymbol(
                        categoriesProduct!.sellingPrice!,
                      ),
                      style: fontSizeRegular.copyWith(
                          color: Theme.of(context).primaryColor,
                          decoration: TextDecoration.lineThrough),
                    )
                  : const SizedBox(),
              const SizedBox(height: Dimensions.paddingSizeBorder),
              Text(
                PriceConverter.convertPrice(
                    context, categoriesProduct!.sellingPrice,
                    discount: categoriesProduct!.discount,
                    discountType: categoriesProduct!.discountType),
                style: fontSizeRegular.copyWith(
                    color: Theme.of(context).secondaryHeaderColor),
              ),
            ],
          ),
        ),
      );
    });
  }
}
