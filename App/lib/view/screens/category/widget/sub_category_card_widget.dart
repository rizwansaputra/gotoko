import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/category_controller.dart';
import 'package:gotoko/data/model/response/sub_category_model.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/animated_custom_dialog.dart';
import 'package:gotoko/view/base/logout_dialog.dart';
import 'package:gotoko/view/screens/category/widget/add_new_sub_category.dart';

class SubCategoryCardWidget extends StatelessWidget {
  final SubCategories? subCategory;
  const SubCategoryCardWidget({Key? key, this.subCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeBorder),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault,
            vertical: Dimensions.paddingSizeExtraSmall),
        child: Row(
          children: [
            Expanded(
                child: Text(
              subCategory!.name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: fontSizeRegular.copyWith(
                  color: Theme.of(context).primaryColor),
            )),

            // GetBuilder<CategoryController>(
            //     builder: (categoryController) {
            //       return Switch(
            //           value: subCategory.status == 1,
            //           activeColor: ColorResources.primaryColor,
            //           onChanged: (value) => categoryController.subCategoryStatusOnOff(subCategory.id, subCategory.status == 1? 0 : 1 ));
            //     }
            // ),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall),

            InkWell(
              onTap: () => Get.to(AddNewSubCategory(subCategory: subCategory)),
              child: SizedBox(
                  width: Dimensions.iconSizeDefault,
                  child: Image.asset(Images.editIcon)),
            ),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall),

            GetBuilder<CategoryController>(builder: (categoryController) {
              return InkWell(
                onTap: () {
                  showAnimatedDialog(
                      context,
                      CustomDialog(
                        delete: true,
                        icon: Icons.exit_to_app_rounded,
                        title: '',
                        description:
                            'are_you_sure_you_want_to_delete_sub_category'.tr,
                        onTapFalse: () => Get.back(),
                        onTapTrue: () {
                          categoryController.deleteSubCategory(subCategory!);
                        },
                        onTapTrueText: 'yes'.tr,
                        onTapFalseText: 'cancel'.tr,
                      ),
                      dismissible: false,
                      isFlip: true);
                },
                child: SizedBox(
                    width: Dimensions.iconSizeDefault,
                    child: Image.asset(Images.deleteIcon)),
              );
            }),
          ],
        ),
      ),
    );
  }
}
