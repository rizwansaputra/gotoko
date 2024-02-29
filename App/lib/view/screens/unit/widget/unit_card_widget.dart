import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/unit_controller.dart';
import 'package:gotoko/data/model/response/unit_model.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/animated_custom_dialog.dart';
import 'package:gotoko/view/base/logout_dialog.dart';
import 'package:gotoko/view/screens/unit/widget/add_new_unit_screen.dart';

class UnitCardWidget extends StatelessWidget {
  final Units? unit;
  const UnitCardWidget({Key? key, this.unit}) : super(key: key);

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
              unit!.unitType!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: fontSizeRegular.copyWith(
                  color: Theme.of(context).primaryColor),
            )),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            InkWell(
              onTap: () => Get.to(AddNewUnit(unit: unit)),
              child: SizedBox(
                  width: Dimensions.iconSizeDefault,
                  child: Image.asset(Images.editIcon)),
            ),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            GetBuilder<UnitController>(builder: (unitController) {
              return InkWell(
                onTap: () {
                  showAnimatedDialog(
                      context,
                      CustomDialog(
                        delete: true,
                        icon: Icons.exit_to_app_rounded,
                        title: '',
                        description: 'are_you_sure_you_want_to_delete_unit'.tr,
                        onTapFalse: () => Navigator.of(context).pop(true),
                        onTapTrue: () {
                          unitController.deleteUnit(unit!.id);
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
