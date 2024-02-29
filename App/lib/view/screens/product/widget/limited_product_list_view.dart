import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/product_controller.dart';
import 'package:gotoko/data/model/response/limite_stock_product_model.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/view/base/no_data_screen.dart';
import 'package:gotoko/view/screens/product/widget/limited_stock_product_card.dart';

class LimitedStockProductListView extends StatelessWidget {
  final bool isHome;
  final ScrollController? scrollController;
  const LimitedStockProductListView(
      {Key? key, this.scrollController, this.isHome = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int offset = 1;

    scrollController?.addListener(() {
      if (scrollController!.position.maxScrollExtent ==
              scrollController!.position.pixels &&
          Get.find<ProductController>().limitedStockProductList.isNotEmpty &&
          !Get.find<ProductController>().isLoading) {
        int? pageSize;
        pageSize = Get.find<ProductController>().limitedStockProductListLength;

        if (offset < pageSize! && !isHome) {
          offset++;
          Get.find<ProductController>().showBottomLoader();
          Get.find<ProductController>().getLimitedStockProductList(offset);
        }
      }
    });

    return GetBuilder<ProductController>(
      builder: (limitedStockProductController) {
        List<StockLimitedProducts> limitedStockProductList;
        limitedStockProductList =
            limitedStockProductController.limitedStockProductList;

        return Column(children: [
          !limitedStockProductController.isFirst
              ? limitedStockProductList.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: isHome && limitedStockProductList.length > 2
                          ? 3
                          : limitedStockProductList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return LimitedStockProductCardViewWidget(
                            product: limitedStockProductList[index],
                            index: index,
                            isHome: isHome);
                      })
                  : const NoDataScreen()
              : const SizedBox.shrink(),
          limitedStockProductController.isLoading
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
