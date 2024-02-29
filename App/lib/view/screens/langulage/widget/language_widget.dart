import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/localization_controller.dart';
import 'package:gotoko/data/model/response/language_model.dart';
import 'package:gotoko/util/app_constants.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_ink_well.dart';

class LanguageWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final LocalizationController localizationController;
  final int index;
  const LanguageWidget(
      {Key? key,
      required this.languageModel,
      required this.localizationController,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        boxShadow: [
          BoxShadow(
              color: Colors.grey[Get.isDarkMode ? 800 : 200]!,
              blurRadius: 5,
              spreadRadius: 1)
        ],
      ),
      child: CustomInkWell(
        onTap: () {
          localizationController.setLanguage(Locale(
            AppConstants.languages[index].languageCode!,
            AppConstants.languages[index].countryCode,
          ));
          localizationController.setSelectIndex(index);
        },
        radius: Dimensions.radiusSmall,
        child: Stack(children: [
          Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusSmall),
                      border: Border.all(
                          color: Theme.of(context).textTheme.bodyLarge!.color!,
                          width: 1)),
                  alignment: Alignment.center,
                  child: Image.asset(languageModel.imageUrl!,
                      width: 36, height: 36)),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              Text(languageModel.languageName!,
                  style: fontSizeMedium.copyWith(
                      color: Theme.of(context).primaryColor)),
            ]),
          ),
          localizationController.selectedIndex == index
              ? Positioned(
                  top: 10,
                  right: 10,
                  child: Icon(Icons.check_circle,
                      color: Theme.of(context).primaryColor, size: 25),
                )
              : const SizedBox(),
        ]),
      ),
    );
  }
}
