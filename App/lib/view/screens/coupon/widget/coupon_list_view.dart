import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/coupon_controller.dart';
import 'package:gotoko/data/model/response/coupon_model.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/view/screens/coupon/widget/coupon_card_widget.dart';

class CouponListView extends StatelessWidget {
  final ScrollController? scrollController;
  const CouponListView({Key? key, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    scrollController?.addListener(() {
      if (scrollController!.position.maxScrollExtent ==
              scrollController!.position.pixels &&
          Get.find<CouponController>().couponList.isNotEmpty &&
          !Get.find<CouponController>().isLoading) {
        int? pageSize;
        pageSize = Get.find<CouponController>().couponListLength;

        if (offset < pageSize!) {
          offset++;
          Get.find<CouponController>().showBottomLoader();
          Get.find<CouponController>().getCouponListData(offset);
        }
      }
    });

    return GetBuilder<CouponController>(
      builder: (couponController) {
        List<Coupons> couponList;
        couponList = couponController.couponList;

        return Column(children: [
          !couponController.isFirst
              ? couponList.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: couponList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return CouponCardWidget(
                            coupon: couponList[index], index: index);
                      })
                  : const SizedBox.shrink()
              : const SizedBox.shrink(),
          couponController.isLoading
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
