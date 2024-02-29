import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/supplier_controller.dart';
import 'package:gotoko/data/model/response/supplier_model.dart';
import 'package:gotoko/data/model/response/transaction_model.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/view/base/account_shimmer.dart';
import 'package:gotoko/view/base/no_data_screen.dart';
import 'package:gotoko/view/screens/account_management/widget/transaction_list_card_widget.dart';

class SupplierTransactionListView extends StatelessWidget {
  final Suppliers? supplier;
  final ScrollController? scrollController;
  const SupplierTransactionListView(
      {Key? key, this.scrollController, this.supplier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    scrollController?.addListener(() {
      if (scrollController!.position.maxScrollExtent ==
              scrollController!.position.pixels &&
          Get.find<SupplierController>().supplierTransactionList.isNotEmpty &&
          !Get.find<SupplierController>().isLoading) {
        int? pageSize;
        pageSize = Get.find<SupplierController>().supplierTransactionListLength;

        if (offset < pageSize!) {
          offset++;
          Get.find<SupplierController>().showBottomLoader();
          Get.find<SupplierController>()
              .getSupplierTransactionList(offset, supplier!.id, reload: false);
        }
      }
    });

    return GetBuilder<SupplierController>(
      builder: (supplierController) {
        List<Transfers> transactionList;
        transactionList = supplierController.supplierTransactionList;

        return Column(children: [
          !supplierController.isFirst
              ? transactionList.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: transactionList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return TransactionCardViewWidget(
                            transfer: transactionList[index], index: index);
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
