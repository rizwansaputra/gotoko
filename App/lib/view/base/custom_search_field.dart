import 'package:flutter/material.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';

class CustomSearchField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final IconData prefix;
  final Function iconPressed;
  final Function? onSubmit;
  final Function? onChanged;
  final Function? filterAction;
  final bool isFilter;
  const CustomSearchField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.prefix,
    required this.iconPressed,
    this.onSubmit,
    this.onChanged,
    this.filterAction,
    this.isFilter = false,
  }) : super(key: key);

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.controller,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: fontSizeRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall,
                  color: Theme.of(context).disabledColor),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
              filled: true,
              fillColor: Theme.of(context).cardColor,
              isDense: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: .70),
                borderRadius: BorderRadius.circular(50),
              ),
              prefixIcon: IconButton(
                onPressed: widget.iconPressed as void Function()?,
                icon: Icon(widget.prefix, color: Theme.of(context).hintColor),
              ),
            ),
            onSubmitted: widget.onSubmit as void Function(String)?,
            onChanged: widget.onChanged as void Function(String)?,
          ),
        ),
        widget.isFilter
            ? Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault),
                child: GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    widget.filterAction!(details.globalPosition);
                  },
                  child: Image.asset(Images.filterIcon,
                      width: Dimensions.paddingSizeLarge),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
