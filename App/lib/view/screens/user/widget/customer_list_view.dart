import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/customer_controller.dart';
import 'package:gotoko/data/model/response/customer_model.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/view/base/account_shimmer.dart';
import 'package:gotoko/view/base/no_data_screen.dart';
import 'package:gotoko/view/screens/user/widget/customer_card_view_widget.dart';

class CustomerListView extends StatelessWidget {
  final ScrollController? scrollController;
  const CustomerListView({Key? key, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    scrollController?.addListener(() {
      if (scrollController!.position.maxScrollExtent ==
              scrollController!.position.pixels &&
          Get.find<CustomerController>().customerList.isNotEmpty &&
          !Get.find<CustomerController>().isGetting) {
        int? pageSize;
        pageSize = Get.find<CustomerController>().customerListLength;

        if (offset < pageSize!) {
          offset++;
          Get.find<CustomerController>().showBottomLoader();
          Get.find<CustomerController>().getCustomerList(offset);
        }
      }
    });

    return GetBuilder<CustomerController>(
      builder: (customerController) {
        List<Customers> customerList;
        customerList = customerController.customerList;

        return Column(children: [
          !customerController.isFirst
              ? customerList.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: customerList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return CustomerCardViewWidget(
                            customer: customerList[index]);
                      })
                  : const AccountShimmer()
              : const NoDataScreen(),
          customerController.isLoading
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
