import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/category_controller.dart';
import 'package:gotoko/data/model/response/category_model.dart';
import 'package:gotoko/util/color_resources.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_header.dart';
import 'package:gotoko/view/base/custom_search_field.dart';
import 'package:gotoko/view/base/no_data_screen.dart';
import 'package:gotoko/view/base/product_shimmer.dart';
import 'package:gotoko/view/screens/product/widget/category_item_card_widget.dart';
import 'package:gotoko/view/screens/product/widget/item_card_widget.dart';
import 'package:gotoko/view/screens/product/widget/product_search_dialog.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({Key? key}) : super(key: key);

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Get.find<CategoryController>().getSearchProductList('');
    Get.find<CategoryController>().changeSelectedIndex(0);
    if (Get.find<CategoryController>().categoryList.isNotEmpty) {
      Get.find<CategoryController>().getCategoryWiseProductList(
          Get.find<CategoryController>().categoryList[0].id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<CategoryController>().getSearchProductList('', isReset: true);
        searchController.clear();
      },
      child: Scaffold(
        body: Column(
          children: [
            CustomHeader(title: 'products'.tr, headerImage: Images.product),
            GetBuilder<CategoryController>(builder: (searchProductController) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault,
                    vertical: Dimensions.paddingSizeSmall),
                child: CustomSearchField(
                  controller: searchController,
                  hint: 'search_product_by_name_or_barcode'.tr,
                  prefix: Icons.search,
                  iconPressed: () => () {},
                  onSubmit: (text) => () {},
                  onChanged: (value) {
                    searchProductController.getSearchProductList(value);
                  },
                  isFilter: false,
                ),
              );
            }),
            Expanded(
                child: Stack(
              children: [
                GetBuilder<CategoryController>(
                  builder: (categoryController) {
                    return categoryController.categoryList.isNotEmpty
                        ? Row(children: [
                            Container(
                              width: 100,
                              margin: const EdgeInsets.only(top: 3),
                              height: double.infinity,
                              decoration: BoxDecoration(
                                  color: ColorResources
                                      .getCategoryWithProductColor(),
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(
                                          Dimensions.paddingSizeLarge))),
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount:
                                    categoryController.categoryList.length,
                                padding: const EdgeInsets.all(0),
                                itemBuilder: (context, index) {
                                  Categories category =
                                      categoryController.categoryList[index];
                                  return InkWell(
                                    onTap: () {
                                      Get.find<CategoryController>()
                                          .changeSelectedIndex(index);
                                      Get.find<CategoryController>()
                                          .getCategoryWiseProductList(
                                              categoryController
                                                  .categoryList[index].id);
                                    },
                                    child: CategoryItem(
                                      title: category.name,
                                      icon: category.image,
                                      isSelected: categoryController
                                              .categorySelectedIndex ==
                                          index,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                                width: Dimensions.paddingSizeMediumBorder),
                            !categoryController.isCategory
                                ? categoryController
                                        .categoriesProductList!.isNotEmpty
                                    ? Expanded(
                                        child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(
                                                Dimensions.paddingSizeDefault),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'all_product_from'.tr,
                                                  style:
                                                      fontSizeRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeSmall),
                                                ),
                                                const SizedBox(
                                                    width: Dimensions
                                                        .paddingSizeSmall),
                                                Expanded(
                                                  child: Text(
                                                    ' ${categoryController.categoryList[categoryController.categorySelectedIndex!].name}',
                                                    textAlign: TextAlign.start,
                                                    maxLines: 3,
                                                    style: fontSizeRegular.copyWith(
                                                        color: Theme.of(context)
                                                            .secondaryHeaderColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: Dimensions
                                                      .paddingSizeExtraSmall),
                                              child: GridView.builder(
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  mainAxisSpacing: 5,
                                                  crossAxisSpacing: 5,
                                                  childAspectRatio: 0.5,
                                                ),
                                                padding:
                                                    const EdgeInsets.all(0),
                                                itemCount: categoryController
                                                    .categoriesProductList!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return ItemCardWidget(
                                                      categoriesProduct:
                                                          categoryController
                                                                  .categoriesProductList![
                                                              index],
                                                      index: index);
                                                },
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                              height:
                                                  Dimensions.paddingSizeDefault)
                                        ],
                                      ))
                                    : const Expanded(child: NoDataScreen())
                                : const Expanded(child: ProductShimmer()),
                          ])
                        : const NoDataScreen();
                  },
                ),
                const ProductSearchDialog(),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
