import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/category_controller.dart';
import 'package:gotoko/data/model/response/category_model.dart';
import 'package:gotoko/util/dimensions.dart';

import 'category_card_widget.dart';

class CategoryListView extends StatelessWidget {
  final ScrollController? scrollController;
  const CategoryListView({Key? key, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    scrollController?.addListener(() {
      if (scrollController!.position.maxScrollExtent ==
              scrollController!.position.pixels &&
          Get.find<CategoryController>().categoryList.isNotEmpty &&
          !Get.find<CategoryController>().isGetting) {
        int? pageSize;
        pageSize = Get.find<CategoryController>().categoryListLength;

        if (offset < pageSize!) {
          offset++;
          Get.find<CategoryController>().showBottomLoader();
          Get.find<CategoryController>().getCategoryList(offset);
        }
      }
    });

    return GetBuilder<CategoryController>(
      builder: (categoryController) {
        List<Categories> categoryList;
        categoryList = categoryController.categoryList;

        return Column(children: [
          !categoryController.isFirst
              ? categoryList.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: categoryList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return CategoryCardWidget(
                          category: categoryList[index],
                          index: index,
                        );
                      })
                  : const SizedBox.shrink()
              : const SizedBox.shrink(),
          categoryController.isLoading
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
