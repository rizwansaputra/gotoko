import 'package:flutter/material.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/styles.dart';

class RequiredTitle extends StatelessWidget {
  final String title;
  final bool isRequired;
  const RequiredTitle({Key? key, required this.title, this.isRequired = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        style: fontSizeMedium.copyWith(
          fontSize: Dimensions.fontSizeLarge,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
        children: <TextSpan>[
          TextSpan(
              text: '  *', style: fontSizeBold.copyWith(color: Colors.red)),
        ],
      ),
    );
  }
}
