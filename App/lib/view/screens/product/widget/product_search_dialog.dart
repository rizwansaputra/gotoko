import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/category_controller.dart';
import 'package:gotoko/controller/theme_controller.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/view/screens/product/widget/searched_product_item_widget.dart';

class ProductSearchDialog extends StatelessWidget {
  const ProductSearchDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (searchedProductController) {
      return searchedProductController.searchedProductList != null &&
              searchedProductController.searchedProductList!.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraLarge),
              child: Container(
                height: 400,
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.paddingSizeSmall),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[
                              Get.find<ThemeController>().darkTheme
                                  ? 800
                                  : 400]!,
                          spreadRadius: .5,
                          blurRadius: 12,
                          offset: const Offset(3, 5))
                    ]),
                child: ListView.builder(
                    itemCount:
                        searchedProductController.searchedProductList!.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      return SearchedProductItemWidget(
                          product: searchedProductController
                              .searchedProductList![index]);
                    }),
              ),
            )
          : const SizedBox.shrink();
    });
  }
}
