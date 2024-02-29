import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/styles.dart';

class TitleRow extends StatelessWidget {
  final String title;
  final Function? icon;
  final Function? onTap;

  final bool? isDetailsPage;

  const TitleRow(
      {Key? key,
      required this.title,
      this.icon,
      this.onTap,
      this.isDetailsPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(title,
          style: fontSizeMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
      const Spacer(),
      onTap != null
          ? InkWell(
              onTap: onTap as void Function()?,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                isDetailsPage == null
                    ? Text('view_all'.tr,
                        style: fontSizeRegular.copyWith(
                            color: Theme.of(context).secondaryHeaderColor,
                            decoration: TextDecoration.underline,
                            fontSize: Dimensions.fontSizeDefault))
                    : const SizedBox.shrink(),
              ]),
            )
          : const SizedBox.shrink(),
    ]);
  }
}
