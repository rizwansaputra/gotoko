import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/brand_controller.dart';
import 'package:gotoko/controller/category_controller.dart';
import 'package:gotoko/data/model/response/brand_model.dart';
import 'package:gotoko/view/base/brand_shimmer.dart';
import 'package:gotoko/view/base/no_data_screen.dart';
import 'package:gotoko/view/screens/brand/widget/brand_card_widget.dart';

class BrandListView extends StatelessWidget {
  final ScrollController? scrollController;
  const BrandListView({Key? key, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    scrollController?.addListener(() {
      if (scrollController!.position.maxScrollExtent ==
              scrollController!.position.pixels &&
          Get.find<BrandController>().brandList!.isNotEmpty &&
          !Get.find<BrandController>().isLoading) {
        int? pageSize;
        pageSize = Get.find<CategoryController>().categoryListLength;

        if (offset < pageSize!) {
          offset++;
          Get.find<BrandController>().showBottomLoader();
          Get.find<BrandController>().getBrandList(offset);
        }
      }
    });

    return GetBuilder<BrandController>(
      builder: (brandController) {
        List<Brands>? brandList;
        brandList = brandController.brandList;

        return Column(children: [
          brandList != null
              ? brandList.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: brandList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return BrandCardWidget(brand: brandList![index]);
                      })
                  : const BrandShimmer()
              : const NoDataScreen(),
          //brandController.isLoading ? BrandShimmer() : SizedBox.shrink(),
        ]);
      },
    );
  }
}
