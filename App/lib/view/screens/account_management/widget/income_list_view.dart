import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/income_controller.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/view/base/account_shimmer.dart';
import 'package:gotoko/view/base/custom_loader.dart';
import 'package:gotoko/view/base/no_data_screen.dart';
import 'package:gotoko/view/screens/account_management/widget/income_info.dart';

class IncomeListView extends StatefulWidget {
  final ScrollController? scrollController;
  const IncomeListView({Key? key, this.scrollController}) : super(key: key);

  @override
  State<IncomeListView> createState() => _IncomeListViewState();
}

class _IncomeListViewState extends State<IncomeListView> {
  @override
  Widget build(BuildContext context) {
    int offset = 1;
    widget.scrollController?.addListener(() {
      if (widget.scrollController!.position.maxScrollExtent ==
              widget.scrollController!.position.pixels &&
          Get.find<IncomeController>().incomeList != null &&
          Get.find<IncomeController>().incomeList!.isNotEmpty &&
          !Get.find<IncomeController>().isLoading) {
        int? pageSize;
        pageSize = Get.find<IncomeController>().incomeListLength;

        if (offset < pageSize!) {
          offset++;
          Get.find<IncomeController>().showBottomLoader();
          Get.find<IncomeController>().getIncomeList(offset, reload: false);
        }
      }
    });

    return GetBuilder<IncomeController>(
      builder: (incomeController) {
        return Column(children: [
          incomeController.incomeList == null
              ? const CustomLoader()
              : !incomeController.isFirst
                  ? incomeController.incomeList!.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: incomeController.incomeList!.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (ctx, index) {
                            return IncomeCardViewWidget(
                                income: incomeController.incomeList![index],
                                index: index);
                          })
                      : const NoDataScreen()
                  : const AccountShimmer(),
          incomeController.isLoading
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
