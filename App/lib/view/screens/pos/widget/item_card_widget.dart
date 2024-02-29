import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/cart_controller.dart';
import 'package:gotoko/controller/splash_controller.dart';
import 'package:gotoko/controller/theme_controller.dart';
import 'package:gotoko/data/model/response/cart_model.dart';
import 'package:gotoko/helper/price_converter.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_divider.dart';
import 'package:gotoko/view/base/custom_image.dart';

class ItemCartWidget extends StatelessWidget {
  final CartModel? cartModel;
  final int? index;
  const ItemCartWidget({Key? key, this.cartModel, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.paddingSizeBorder),
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (DismissDirection direction) {
          Get.find<CartController>().removeFromCart(index!);
        },
        child: Container(
          decoration:
              BoxDecoration(color: Theme.of(context).cardColor, boxShadow: [
            BoxShadow(
                color: Colors
                    .grey[Get.find<ThemeController>().darkTheme ? 800 : 200]!,
                spreadRadius: 0.5,
                blurRadius: 0.3)
          ]),
          padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeExtraSmall,
              Dimensions.paddingSizeSmall, 0, Dimensions.paddingSizeSmall),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: Dimensions.productImageSize,
                          width: Dimensions.productImageSize,
                          padding: const EdgeInsets.all(
                              Dimensions.paddingSizeBorder),
                          child: CustomImage(
                              image:
                                  '${Get.find<SplashController>().configModel!.baseUrls!.productImageUrl}/${cartModel!.product!.image}',
                              placeholder: Images.placeholder,
                              fit: BoxFit.cover,
                              width: Dimensions.productImageSizeItem,
                              height: Dimensions.productImageSizeItem),
                        ),
                        const SizedBox(width: Dimensions.paddingSizeSmall),
                        Expanded(
                            child: Text(
                          '${cartModel!.product!.title}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: fontSizeRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall),
                        )),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child:
                        GetBuilder<CartController>(builder: (cartController) {
                      return Row(
                        children: [
                          InkWell(
                            onTap: () {
                              cartController.setQuantity(false, index);
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeExtraSmall),
                              child: Icon(Icons.remove_circle),
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.paddingSizeBorder),
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).primaryColor),
                            ),
                            child: Center(
                                child: Text(
                              cartModel!.quantity.toString(),
                              style: fontSizeRegular.copyWith(
                                  color: Theme.of(context).primaryColor),
                            )),
                          ),
                          InkWell(
                            onTap: () {
                              cartController.setQuantity(true, index);
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeExtraSmall),
                              child: Icon(Icons.add_circle),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(
                          PriceConverter.priceWithSymbol(cartModel!.price!),
                          style: fontSizeRegular.copyWith(
                              color: Theme.of(context).secondaryHeaderColor))),
                ],
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault),
                child: CustomDivider(
                  height: .4,
                  color: Theme.of(context).hintColor.withOpacity(.5),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
