import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/category_controller.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_app_bar.dart';
import 'package:gotoko/view/base/custom_drawer.dart';
import 'package:gotoko/view/base/custom_header.dart';
import 'package:gotoko/view/screens/category/widget/add_new_sub_category.dart';
import 'package:gotoko/view/screens/category/widget/sub_category_list_view.dart';

class SubCategoryListViewScreen extends StatefulWidget {
  const SubCategoryListViewScreen({Key? key}) : super(key: key);

  @override
  State<SubCategoryListViewScreen> createState() =>
      _SubCategoryListViewScreenState();
}

class _SubCategoryListViewScreenState extends State<SubCategoryListViewScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    final categoryController = Get.find<CategoryController>();
    int offset = 1;
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
              _scrollController.position.pixels &&
          categoryController.subCategoryList != null &&
          categoryController.subCategoryList!.isNotEmpty) {
        int? pageSize;
        pageSize = categoryController.subCategoryListLength;

        if (offset < pageSize!) {
          offset++;
          categoryController.showBottomLoader();
          categoryController.getSubCategoryList(
              offset,
              categoryController
                  .categoryList[categoryController.categoryIndex - 1].id);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      endDrawer: const CustomDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          color: Theme.of(context).cardColor,
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {},
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    CustomHeader(
                        title: 'sub_category_list'.tr,
                        headerImage: Images.categories),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    GetBuilder<CategoryController>(
                        builder: (categoryController) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(
                            Dimensions.paddingSizeDefault,
                            0,
                            Dimensions.paddingSizeDefault,
                            0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'select_category'.tr,
                              style: fontSizeRegular.copyWith(
                                  color: Theme.of(context).primaryColor),
                            ),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Container(
                              height: 50,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeSmall),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  border: Border.all(
                                      width: .5,
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(.7)),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.paddingSizeMediumBorder)),
                              child: DropdownButton<int>(
                                value: categoryController.categoryIndex,
                                items: categoryController.categoryIds
                                    .map((int? value) {
                                  return DropdownMenuItem<int>(
                                      value: categoryController.categoryIds
                                          .indexOf(value),
                                      child: Text(value != 0
                                          ? categoryController
                                              .categoryList[(categoryController
                                                      .categoryIds
                                                      .indexOf(value) -
                                                  1)]
                                              .name!
                                          : 'select'));
                                }).toList(),
                                onChanged: (int? value) {
                                  categoryController.setCategoryIndex(
                                      value!, true);
                                },
                                isExpanded: true,
                                underline: const SizedBox(),
                              ),
                            ),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    const SubCategoryListView(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Get.to(const AddNewSubCategory());
        },
        child: Image.asset(Images.addCategoryIcon),
      ),
    );
  }
}
