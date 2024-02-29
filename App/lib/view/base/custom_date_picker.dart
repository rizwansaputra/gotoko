import 'package:flutter/material.dart';
import 'package:gotoko/util/color_resources.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/styles.dart';

class CustomDatePicker extends StatefulWidget {
  final String? title;
  final String? text;
  final String? image;
  final bool requiredField;
  final Function? selectDate;
  const CustomDatePicker(
      {Key? key,
      this.title,
      this.text,
      this.image,
      this.requiredField = false,
      this.selectDate})
      : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: Dimensions.paddingSizeDefault,
          right: Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: widget.title,
              style: fontSizeRegular.copyWith(
                  color: Theme.of(context).primaryColor),
              children: <TextSpan>[
                widget.requiredField
                    ? TextSpan(
                        text: '  *',
                        style: fontSizeBold.copyWith(color: Colors.red))
                    : const TextSpan(),
              ],
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          Container(
            height: 50,
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(
              border:
                  Border.all(color: ColorResources.primaryColor, width: 0.1),
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.text!,
                  style: fontSizeRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall),
                ),
                InkWell(
                  onTap: widget.selectDate as void Function()?,
                  child: SizedBox(
                      width: 20, height: 20, child: Image.asset(widget.image!)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
