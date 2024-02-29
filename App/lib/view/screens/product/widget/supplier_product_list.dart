import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/supplier_controller.dart';
import 'package:gotoko/data/model/response/product_model.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/view/base/custom_loader.dart';
import 'package:gotoko/view/base/no_data_screen.dart';
import 'package:gotoko/view/screens/product/widget/product_card_widget.dart';

class SupplierProductListView extends StatelessWidget {
  final int? supplierId;
  final ScrollController? scrollController;
  const SupplierProductListView(
      {Key? key, this.scrollController, this.supplierId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    scrollController?.addListener(() {
      if (scrollController!.position.maxScrollExtent ==
              scrollController!.position.pixels &&
          Get.find<SupplierController>().supplierProductList.isNotEmpty &&
          !Get.find<SupplierController>().isLoading) {
        int? pageSize;
        pageSize = Get.find<SupplierController>().supplierProductListLength;

        if (offset < pageSize!) {
          offset++;
          Get.find<SupplierController>().showBottomLoader();
          Get.find<SupplierController>()
              .getSupplierProductList(offset, supplierId, reload: false);
        }
      }
    });

    return GetBuilder<SupplierController>(
      builder: (supplierProductController) {
        List<Products> productList;
        productList = supplierProductController.supplierProductList;

        return Column(children: [
          !supplierProductController.isFirst
              ? productList.isNotEmpty
                  ? ListView.builder(
                      itemCount: productList.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return ProductCardViewWidget(
                            product: productList[index]);
                      })
                  : const NoDataScreen()
              : const CustomLoader(),
          supplierProductController.isGetting &&
                  !supplierProductController.isFirst
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
