import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/supplier_controller.dart';
import 'package:gotoko/data/model/response/supplier_model.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/view/base/account_shimmer.dart';
import 'package:gotoko/view/base/no_data_screen.dart';
import 'package:gotoko/view/screens/user/widget/supplier_card_view_widget.dart';

class SupplierListView extends StatelessWidget {
  final ScrollController? scrollController;
  const SupplierListView({Key? key, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    scrollController?.addListener(() {
      if (scrollController!.position.maxScrollExtent ==
              scrollController!.position.pixels &&
          Get.find<SupplierController>().supplierList.isNotEmpty &&
          !Get.find<SupplierController>().isGetting) {
        int? pageSize;
        pageSize = Get.find<SupplierController>().supplierListLength;

        if (offset < pageSize!) {
          offset++;
          Get.find<SupplierController>().showBottomLoader();
          Get.find<SupplierController>().getSupplierList(offset, reload: false);
        }
      }
    });

    return GetBuilder<SupplierController>(
      builder: (supplierController) {
        List<Suppliers> supplierList;
        supplierList = supplierController.supplierList;

        return Column(children: [
          !supplierController.isFirst
              ? supplierList.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: supplierList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return SupplierCardViewWidget(
                            supplier: supplierList[index]);
                      })
                  : const NoDataScreen()
              : const AccountShimmer(),
          supplierController.isLoading
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
