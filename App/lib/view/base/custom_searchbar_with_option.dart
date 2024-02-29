import 'package:flutter/material.dart';
import 'package:gotoko/util/color_resources.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';

class CustomSearchbarWithOption extends StatelessWidget {
  final String? searchTitle;
  const CustomSearchbarWithOption({Key? key, this.searchTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: Dimensions.paddingSizeLarge,
          right: Dimensions.paddingSizeLarge),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: Dimensions.heightWidth50,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(Dimensions.fontSizeExtraLarge),
                color: ColorResources.whiteColor,
                border: Border.all(
                  width: 0.5,
                  color: ColorResources.blackColor.withOpacity(.3),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Row(
                  children: [
                    SizedBox(
                        height: Dimensions.paddingSizeLarge,
                        width: Dimensions.paddingSizeLarge,
                        child: Image.asset(Images.searchIcon)),
                    const SizedBox(width: Dimensions.paddingSizeDefault),
                    Expanded(
                        child: TextField(
                            decoration: InputDecoration.collapsed(
                                hintText: searchTitle))),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: Dimensions.paddingSizeExtraExtraLarge),
          Image.asset(Images.filterIcon,
              height: Dimensions.paddingSizeExtraLarge,
              width: Dimensions.paddingSizeExtraLarge),
        ],
      ),
    );
  }
}
