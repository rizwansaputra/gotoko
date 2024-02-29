import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/localization_controller.dart';
import 'package:gotoko/util/app_constants.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_app_bar.dart';
import 'package:gotoko/view/base/custom_button.dart';
import 'package:gotoko/view/base/custom_drawer.dart';
import 'package:gotoko/view/base/custom_snackbar.dart';
import 'widget/language_widget.dart';

class ChooseLanguageScreen extends StatelessWidget {
  const ChooseLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      endDrawer: const CustomDrawer(),
      body: GetBuilder<LocalizationController>(
        builder: (localizationController) {
          return Column(children: [
            Expanded(
              child: Center(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(Images.logo)),
                                ),
                              ),
                            ),
                            const SizedBox(
                                height: Dimensions.paddingSizeExtraLarge),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeExtraSmall),
                              child: Text('select_language'.tr,
                                  style: fontSizeMedium.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: Dimensions.fontSizeExtraLarge,
                                  )),
                            ),
                            const SizedBox(
                                height: Dimensions.paddingSizeExtraSmall),
                            GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: (1 / 1),
                              ),
                              itemCount:
                                  localizationController.languages.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => LanguageWidget(
                                languageModel:
                                    localizationController.languages[index],
                                localizationController: localizationController,
                                index: index,
                              ),
                            ),
                            const SizedBox(height: Dimensions.paddingSizeLarge),
                            Text('you_can_change_language'.tr,
                                style: fontSizeRegular.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).disabledColor,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: Dimensions.paddingSizeDefault,
                right: Dimensions.paddingSizeDefault,
                bottom: Dimensions.paddingSizeExtraLarge,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      buttonText: 'save'.tr,
                      onPressed: () {
                        if (localizationController.languages.isNotEmpty &&
                            localizationController.selectedIndex != -1) {
                          localizationController.setLanguage(
                            Locale(
                              AppConstants
                                  .languages[
                                      localizationController.selectedIndex]
                                  .languageCode!,
                              AppConstants
                                  .languages[
                                      localizationController.selectedIndex]
                                  .countryCode,
                            ),
                          );
                          Get.back();
                        } else {
                          showCustomSnackBar('select_a_language'.tr,
                              isError: false);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]);
        },
      ),
    );
  }
}
