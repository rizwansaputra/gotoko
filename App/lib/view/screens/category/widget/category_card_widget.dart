import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/category_controller.dart';
import 'package:gotoko/controller/splash_controller.dart';
import 'package:gotoko/data/model/response/category_model.dart';
import 'package:gotoko/util/color_resources.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/animated_custom_dialog.dart';
import 'package:gotoko/view/base/logout_dialog.dart';
import 'package:gotoko/view/screens/category/widget/add_new_category.dart';

class CategoryCardWidget extends StatelessWidget {
  final Categories? category;
  final int? index;
  const CategoryCardWidget({Key? key, this.category, this.index})
      : super(key: key);

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
            Container(
              height: Dimensions.productImageSize,
              width: Dimensions.productImageSize,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.placeholder,
                  fit: BoxFit.cover,
                  height: Dimensions.productImageSize,
                  image:
                      '${Get.find<SplashController>().baseUrls!.categoryImageUrl}/${category!.image}',
                  imageErrorBuilder: (c, o, s) => Image.asset(
                    Images.placeholder,
                    fit: BoxFit.cover,
                    height: Dimensions.productImageSize,
                  ),
                ),
              ),
            ),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            Expanded(
                child: Text(
              category!.name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: fontSizeRegular.copyWith(
                  color: Theme.of(context).primaryColor),
            )),
            GetBuilder<CategoryController>(builder: (categoryController) {
              return Switch(
                  value: category!.status == 1,
                  activeColor: ColorResources.primaryColor,
                  onChanged: (value) => categoryController.categoryStatusOnOff(
                      category!.id, category!.status == 1 ? 0 : 1, index));
            }),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            InkWell(
              onTap: () => Get.to(AddNewCategory(
                category: category,
              )),
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
                            'are_you_sure_you_want_to_delete_category'.tr,
                        onTapFalse: () => Navigator.of(context).pop(true),
                        onTapTrue: () {
                          categoryController.deleteCategory(category!.id);
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
