import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/order_controller.dart';
import 'package:gotoko/data/model/response/order_model.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/view/base/custom_loader.dart';
import 'package:gotoko/view/base/no_data_screen.dart';
import 'package:gotoko/view/screens/order/widget/order_card_widget.dart';

class OrderListView extends StatelessWidget {
  final ScrollController? scrollController;
  const OrderListView({Key? key, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    scrollController?.addListener(() {
      if (scrollController!.position.maxScrollExtent ==
              scrollController!.position.pixels &&
          Get.find<OrderController>().orderList.isNotEmpty &&
          !Get.find<OrderController>().isLoading) {
        int? pageSize;
        pageSize = Get.find<OrderController>().orderListLength;

        if (Get.find<OrderController>().offset < pageSize!) {
          Get.find<OrderController>()
              .setOffset(Get.find<OrderController>().offset);
          Get.find<OrderController>().showBottomLoader();
          Get.find<OrderController>()
              .getOrderList(Get.find<OrderController>().offset.toString());
        }
      }
    });

    return GetBuilder<OrderController>(
      builder: (orderController) {
        List<Orders> orderList;
        orderList = orderController.orderList;

        return Column(children: [
          !orderController.isFirst
              ? orderList.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: orderList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return OrderCardWidget(order: orderList[index]);
                      })
                  : const NoDataScreen()
              : const CustomLoader(),
          orderController.isLoading && !orderController.isFirst
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
