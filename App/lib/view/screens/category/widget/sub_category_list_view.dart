import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/category_controller.dart';
import 'package:gotoko/data/model/response/sub_category_model.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/view/screens/category/widget/sub_category_card_widget.dart';

class SubCategoryListView extends StatelessWidget {
  const SubCategoryListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (categoryController) {
        List<SubCategories> subCategoryList;
        subCategoryList = categoryController.subCategoryList ?? [];

        return Column(children: [
          subCategoryList.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: subCategoryList.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    return SubCategoryCardWidget(
                        subCategory: subCategoryList[index]);
                  })
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
