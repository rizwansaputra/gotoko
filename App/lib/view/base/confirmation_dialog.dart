import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmationDialog extends StatelessWidget {
  final String icon;
  final String? title;
  final String description;
  final Function onYesPressed;
  final bool isLogOut;
  final Function? onNoPressed;
  const ConfirmationDialog(
      {Key? key,
      required this.icon,
      this.title,
      required this.description,
      required this.onYesPressed,
      this.isLogOut = false,
      this.onNoPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
          width: 500,
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                child: Image.asset(icon, width: 50, height: 50),
              ),
              title != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeLarge),
                      child: Text(
                        title!,
                        textAlign: TextAlign.center,
                        style: fontSizeMedium.copyWith(
                            fontSize: Dimensions.fontSizeExtraLarge,
                            color: Colors.red),
                      ),
                    )
                  : const SizedBox(),
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                child: Text(description,
                    style: fontSizeMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              Row(children: [
                Expanded(
                    child: TextButton(
                  onPressed: () => isLogOut
                      ? onYesPressed()
                      : onNoPressed != null
                          ? onNoPressed!()
                          : Get.back(),
                  style: TextButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).disabledColor.withOpacity(0.3),
                    minimumSize: const Size(Dimensions.webMaxWidth, 40),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSmall)),
                  ),
                  child: Text(
                    isLogOut ? 'yes'.tr : 'no'.tr,
                    textAlign: TextAlign.center,
                    style: fontSizeBold.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                )),
                const SizedBox(width: Dimensions.paddingSizeLarge),
                Expanded(
                    child: CustomButton(
                  buttonText: isLogOut ? 'no'.tr : 'yes'.tr,
                  onPressed: () => isLogOut ? Get.back() : onYesPressed(),
                  radius: Dimensions.radiusSmall,
                  height: 40,
                )),
              ]),
            ]),
          )),
    );
  }
}
