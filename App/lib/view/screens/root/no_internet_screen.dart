import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoInternetScreen extends StatelessWidget {
  final Widget? child;
  const NoInternetScreen({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Images.noInternet, width: 150, height: 150),
            Text('oops'.tr,
                style: fontSizeBold.copyWith(
                  fontSize: 30,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                )),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Text(
              'no_internet_connection'.tr,
              textAlign: TextAlign.center,
              style: fontSizeRegular,
            ),
            const SizedBox(height: 40),
            Container(
              height: 45,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: CustomButton(
                onPressed: () async {
                  if (await Connectivity().checkConnectivity() !=
                      ConnectivityResult.none) {
                    Navigator.pushReplacement(Get.context!,
                        MaterialPageRoute(builder: (_) => child!));
                  }
                },
                buttonText: 'retry'.tr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
