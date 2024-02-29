import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyCartScreen extends StatelessWidget {
  final bool isCart;
  final String text;
  const EmptyCartScreen({Key? key, required this.text, this.isCart = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              isCart ? Images.cart : Images.emptyBox,
              width: MediaQuery.of(context).size.height * 0.22,
              height: MediaQuery.of(context).size.height * 0.22,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Text(
              isCart ? 'cart_is_empty'.tr : text,
              style: fontSizeMedium.copyWith(
                  fontSize: MediaQuery.of(context).size.height * 0.0175,
                  color: Theme.of(context).disabledColor),
              textAlign: TextAlign.center,
            ),
          ]),
    );
  }
}
