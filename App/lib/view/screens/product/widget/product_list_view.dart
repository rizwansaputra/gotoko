import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/product_controller.dart';
import 'package:gotoko/data/model/response/product_model.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/view/screens/product/widget/product_card_widget.dart';

class ProductListView extends StatelessWidget {
  final ScrollController? scrollController;
  const ProductListView({Key? key, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    scrollController?.addListener(() {
      if (scrollController!.position.maxScrollExtent ==
              scrollController!.position.pixels &&
          Get.find<ProductController>().productList.isNotEmpty &&
          !Get.find<ProductController>().isLoading) {
        int? pageSize;
        pageSize = Get.find<ProductController>().productListLength;

        if (offset < pageSize!) {
          offset++;
          Get.find<ProductController>().showBottomLoader();
          Get.find<ProductController>().getProductList(offset);
        }
      }
    });

    return GetBuilder<ProductController>(
      builder: (productController) {
        List<Products> productList;
        productList = productController.productList;

        return Column(children: [
          !productController.isFirst
              ? productList.isNotEmpty
                  ? ListView.builder(
                      itemCount: productList.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return ProductCardViewWidget(
                            product: productList[index]);
                      })
                  : const SizedBox.shrink()
              : const SizedBox.shrink(),
          productController.isLoading
              ? Center(
                  child: Padding(
                  padding: const EdgeInsets.all(Dimensions.iconSizeExtraSmall),
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor)),
                ))
              : const SizedBox.shrink(),
        ]);
      },
    );
  }
}
