import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/category_controller.dart';
import 'package:gotoko/data/model/response/sub_category_model.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_app_bar.dart';
import 'package:gotoko/view/base/custom_button.dart';
import 'package:gotoko/view/base/custom_drawer.dart';
import 'package:gotoko/view/base/custom_header.dart';
import 'package:gotoko/view/base/custom_loader.dart';
import 'package:gotoko/view/base/custom_snackbar.dart';
import 'package:gotoko/view/base/custom_text_field.dart';

class AddNewSubCategory extends StatefulWidget {
  final SubCategories? subCategory;
  const AddNewSubCategory({Key? key, this.subCategory}) : super(key: key);

  @override
  State<AddNewSubCategory> createState() => _AddNewSubCategoryState();
}

class _AddNewSubCategoryState extends State<AddNewSubCategory> {
  final TextEditingController _subCategoryController = TextEditingController();
  final FocusNode _subCategoryFocusNode = FocusNode();
  int? parentCategoryId = 0;
  String parentCategoryName = '';
  late bool update;
  @override
  void initState() {
    super.initState();

    update = widget.subCategory != null;
    if (update) {
      _subCategoryController.text = widget.subCategory!.name!;
      parentCategoryId = widget.subCategory!.parentId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(),
      appBar: const CustomAppBar(),
      body: GetBuilder<CategoryController>(builder: (categoryController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeader(
                title:
                    update ? 'update_sub_category'.tr : 'add_sub_category'.tr,
                headerImage: Images.addNewCategory),
            const SizedBox(
              height: Dimensions.paddingSizeDefault,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!update)
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'select_category_name'.tr,
                            style: fontSizeMedium.copyWith(
                                fontSize: Dimensions.fontSizeLarge),
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
                                        : update
                                            ? categoryController
                                                .selectedCategoryName
                                            : 'select'.tr));
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
                        ]),
                  Text(
                    'sub_category_name'.tr,
                    style: fontSizeMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  CustomTextField(
                    controller: _subCategoryController,
                    focusNode: _subCategoryFocusNode,
                    hintText: 'sub_category_hint'.tr,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                ],
              ),
            ),
            const SizedBox(
              height: Dimensions.paddingSizeLarge,
            ),
            categoryController.isSub
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width / 2 - 30,
                            vertical: Dimensions.paddingSizeLarge),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(25)),
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
                    child: categoryController.isLoading
                        ? const CustomLoader()
                        : CustomButton(
                            buttonText: update ? 'update'.tr : 'save'.tr,
                            onPressed: () {
                              if (categoryController.categoryIndex != 0) {
                                String subCategoryName =
                                    _subCategoryController.text.trim();
                                int? parentId = update
                                    ? widget.subCategory!.parentId
                                    : categoryController
                                        .categoryList[
                                            (categoryController.categoryIndex -
                                                1)]
                                        .id;
                                int? id =
                                    update ? widget.subCategory!.id : null;
                                categoryController.addSubCategory(
                                    subCategoryName, id, parentId, update);
                              } else {
                                showCustomSnackBar('select_category'.tr);
                              }
                            },
                          ),
                  ),
          ],
        );
      }),
    );
  }
}
