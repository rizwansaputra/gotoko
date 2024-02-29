import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/unit_controller.dart';
import 'package:gotoko/data/model/response/unit_model.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_app_bar.dart';
import 'package:gotoko/view/base/custom_button.dart';
import 'package:gotoko/view/base/custom_drawer.dart';
import 'package:gotoko/view/base/custom_header.dart';
import 'package:gotoko/view/base/custom_text_field.dart';

class AddNewUnit extends StatefulWidget {
  final Units? unit;
  const AddNewUnit({Key? key, this.unit}) : super(key: key);

  @override
  State<AddNewUnit> createState() => _AddNewUnitState();
}

class _AddNewUnitState extends State<AddNewUnit> {
  late bool update;
  final TextEditingController _unitController = TextEditingController();
  final FocusNode _unitFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    update = widget.unit != null;
    if (update) {
      _unitController.text = widget.unit!.unitType!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      endDrawer: const CustomDrawer(),
      body: GetBuilder<UnitController>(builder: (unitController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(
              isBackButtonExist: true,
            ),
            const SizedBox(
              height: Dimensions.paddingSizeDefault,
            ),
            CustomHeader(
                title: update ? 'update_unit'.tr : 'add_unit'.tr,
                headerImage: Images.productUnit),
            const SizedBox(
              height: Dimensions.paddingSizeDefault,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'unit_name'.tr,
                    style: fontSizeMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  CustomTextField(
                    controller: _unitController,
                    focusNode: _unitFocusNode,
                    hintText: 'unit_name_hint'.tr,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                ],
              ),
            ),
            const SizedBox(
              height: Dimensions.paddingSizeLarge,
            ),
            unitController.isLoading
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
                    child: unitController.isLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            buttonText: update ? 'update'.tr : 'save'.tr,
                            onPressed: () async {
                              String unitName = _unitController.text.trim();
                              int? unitId = update ? widget.unit!.id : null;
                              await unitController.addUnit(
                                  unitName, unitId, update);
                            }),
                  ),
          ],
        );
      }),
    ));
  }
}
