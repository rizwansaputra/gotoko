import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/transaction_controller.dart';
import 'package:gotoko/data/model/response/transaction_model.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/view/base/account_shimmer.dart';
import 'package:gotoko/view/base/no_data_screen.dart';
import 'package:gotoko/view/screens/account_management/widget/transaction_list_card_widget.dart';

class CustomerTransactionListView extends StatelessWidget {
  final bool isHome;
  final ScrollController? scrollController;
  final int? customerId;
  const CustomerTransactionListView(
      {Key? key, this.scrollController, this.isHome = false, this.customerId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    final TransactionController transactionCtr =
        Get.find<TransactionController>();
    scrollController?.addListener(() {
      if (scrollController!.position.maxScrollExtent ==
              scrollController!.position.pixels &&
          transactionCtr.transactionList != null &&
          transactionCtr.transactionList!.isNotEmpty &&
          !transactionCtr.isLoading) {
        int? pageSize;
        pageSize = transactionCtr.transactionListLength;

        if (offset < pageSize! && !isHome) {
          offset++;
          transactionCtr.showBottomLoader();
          transactionCtr.getCustomerWiseTransactionListList(customerId, offset,
              reload: false);
        }
      }
    });

    return GetBuilder<TransactionController>(
      builder: (transactionController) {
        List<Transfers>? transactionList;
        transactionList = transactionController.transactionList;

        return Column(children: [
          transactionList == null
              ? const AccountShimmer()
              : transactionList.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: isHome && transactionList.length > 3
                          ? 3
                          : transactionList.length,
                      physics: isHome
                          ? const NeverScrollableScrollPhysics()
                          : const BouncingScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return TransactionCardViewWidget(
                            transfer: transactionList![index], index: index);
                      },
                    )
                  : const NoDataScreen(),
          transactionController.isLoading
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
