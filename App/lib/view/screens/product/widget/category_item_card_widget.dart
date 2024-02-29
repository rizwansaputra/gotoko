import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/splash_controller.dart';
import 'package:gotoko/util/color_resources.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';

class CategoryItem extends StatelessWidget {
  final String? title;
  final String? icon;
  final bool isSelected;
  const CategoryItem(
      {Key? key,
      required this.title,
      required this.icon,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeExtraSmall, horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isSelected ? Theme.of(context).primaryColor : null,
      ),
      child: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 2,
                  color: isSelected
                      ? Theme.of(context).highlightColor
                      : Theme.of(context).hintColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                placeholder: Images.placeholder,
                fit: BoxFit.cover,
                image:
                    '${Get.find<SplashController>().baseUrls!.categoryImageUrl}/$icon',
                imageErrorBuilder: (c, o, s) =>
                    Image.asset(Images.placeholder, fit: BoxFit.cover),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeExtraSmall),
            child: Text(title!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: fontSizeBold.copyWith(
                  fontSize: Dimensions.fontSizeSmall,
                  color: isSelected
                      ? Theme.of(context).cardColor
                      : ColorResources.getTitleColor(),
                )),
          ),
        ]),
      ),
    );
  }
}
