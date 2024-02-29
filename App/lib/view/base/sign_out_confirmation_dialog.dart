import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/auth_controller.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/screens/splash/splash_screen.dart';

class SignOutConfirmationDialog extends StatelessWidget {
  const SignOutConfirmationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeLarge, vertical: 50),
          child: Text('want_to_sign_out'.tr,
              style: fontSizeRegular, textAlign: TextAlign.center),
        ),
        const Divider(height: 0),
        Row(children: [
          Expanded(
              child: InkWell(
            onTap: () {
              Get.find<AuthController>().clearSharedData().then((condition) {
                Navigator.pop(context);
                Get.offAll(const SplashScreen());
                //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SplashScreen()), (route) => false);
              });
            },
            child: Container(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(10))),
              child: Text('yes'.tr,
                  style: fontSizeRegular.copyWith(
                      color: Theme.of(context).primaryColor)),
            ),
          )),
          Expanded(
              child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(10))),
              child: Text('no'.tr,
                  style: fontSizeRegular.copyWith(
                      color: Theme.of(context).cardColor)),
            ),
          )),
        ]),
      ]),
    );
  }
}
