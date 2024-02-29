import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/expense_controller.dart';
import 'package:gotoko/data/model/response/expense_model.dart';
import 'package:gotoko/view/base/account_shimmer.dart';
import 'package:gotoko/view/base/no_data_screen.dart';
import 'package:gotoko/view/screens/account_management/widget/expense_info_view.dart';

class ExpenseListView extends StatelessWidget {
  final bool isHome;
  final ScrollController? scrollController;
  const ExpenseListView({Key? key, this.scrollController, this.isHome = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    scrollController?.addListener(() {
      if (scrollController!.position.maxScrollExtent ==
              scrollController!.position.pixels &&
          Get.find<ExpenseController>().expenseList.isNotEmpty &&
          !Get.find<ExpenseController>().isLoading) {
        int? pageSize;
        pageSize = Get.find<ExpenseController>().expenseListLength;

        if (offset < pageSize! && !isHome) {
          offset++;
          Get.find<ExpenseController>().showBottomLoader();
          Get.find<ExpenseController>().getExpenseList(offset);
        }
      }
    });

    return GetBuilder<ExpenseController>(
      builder: (expanseController) {
        List<Expenses> expensetList;
        expensetList = expanseController.expenseList;

        return Column(children: [
          expensetList.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: isHome && expensetList.length > 3
                      ? 3
                      : expensetList.length,
                  physics: isHome
                      ? const NeverScrollableScrollPhysics()
                      : const BouncingScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    return ExpenseCardViewWidget(
                        expense: expensetList[index], index: index);
                  })
              : const NoDataScreen(),
          expanseController.isLoading
              ? const AccountShimmer()
              : const SizedBox(),
        ]);
      },
    );
  }
}
