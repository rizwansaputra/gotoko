import 'package:flutter/material.dart';
import 'package:gotoko/helper/gradient_color_helper.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/styles.dart';

class CustomCategoryButton extends StatelessWidget {
  final String icon;
  final String buttonText;
  final bool isSelected;
  final double padding;
  final bool isDrawer;
  final Function? onTap;
  const CustomCategoryButton({
    Key? key,
    required this.icon,
    required this.buttonText,
    this.isSelected = false,
    this.padding = Dimensions.paddingSizeDefault,
    this.isDrawer = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Padding(
        padding: isDrawer
            ? const EdgeInsets.all(0.0)
            : const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault,
                vertical: Dimensions.paddingSizeSmall),
        child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: isDrawer
                  ? BorderRadius.zero
                  : BorderRadius.circular(Dimensions.paddingSizeSmall),
              gradient: GradientColorHelper.gradientColor(opacity: 0.03),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: padding),
              child: Column(children: [
                Image.asset(
                  icon,
                  width: 30,
                  color: isSelected
                      ? Theme.of(context).secondaryHeaderColor
                      : Theme.of(context).primaryColor,
                ),
                Text(
                  buttonText,
                  style: fontSizeMedium.copyWith(
                    color: isSelected
                        ? Theme.of(context).secondaryHeaderColor
                        : Theme.of(context).primaryColor,
                    fontSize: Dimensions.fontSizeExtraLarge,
                  ),
                ),
              ]),
            )),
      ),
    );
  }
}
