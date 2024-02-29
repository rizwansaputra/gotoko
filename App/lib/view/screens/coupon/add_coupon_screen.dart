import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/coupon_controller.dart';
import 'package:gotoko/data/model/response/coupon_model.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_app_bar.dart';
import 'package:gotoko/view/base/custom_button.dart';
import 'package:gotoko/view/base/custom_date_picker.dart';
import 'package:gotoko/view/base/custom_drawer.dart';
import 'package:gotoko/view/base/custom_field_with_title.dart';
import 'package:gotoko/view/base/custom_header.dart';
import 'package:gotoko/view/base/custom_snackbar.dart';
import 'package:gotoko/view/base/custom_text_field.dart';

class AddCouponScreen extends StatefulWidget {
  final Coupons? coupon;
  const AddCouponScreen({Key? key, this.coupon}) : super(key: key);

  @override
  State<AddCouponScreen> createState() => _AddNewCouponScreenState();
}

class _AddNewCouponScreenState extends State<AddCouponScreen> {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _couponCodeFocusNode = FocusNode();
  final FocusNode _limitForSameUserFocusNode = FocusNode();
  final FocusNode _minPurchaseFocusNode = FocusNode();
  final FocusNode _maxPurchaseFocusNode = FocusNode();
  final FocusNode _discountAmountFocusNode = FocusNode();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _couponCodeController = TextEditingController();
  final TextEditingController _limitForSameUserController =
      TextEditingController();
  final TextEditingController _minPurchaseController = TextEditingController();
  final TextEditingController _maxPurchaseController = TextEditingController();
  final TextEditingController _discountAmountController =
      TextEditingController();
  late bool update;
  String? selectedCouponType = 'Default';
  String? selectedDiscountType = 'percent';

  @override
  initState() {
    super.initState();
    update = widget.coupon != null;
    if (update) {
      _titleController.text = widget.coupon!.title!;
      _couponCodeController.text = widget.coupon!.couponCode!;
      _limitForSameUserController.text = widget.coupon!.userLimit.toString();
      _minPurchaseController.text = widget.coupon!.minPurchase.toString();
      _maxPurchaseController.text = widget.coupon!.maxDiscount.toString();
      _discountAmountController.text = widget.coupon!.discount.toString();
      selectedDiscountType = widget.coupon!.discountType;
      selectedCouponType = widget.coupon!.couponType;

      DateTime start = DateTime.parse(widget.coupon!.startDate!);
      DateTime end = DateTime.parse(widget.coupon!.startDate!);

      Get.find<CouponController>().setDate('start', start);
      Get.find<CouponController>().setDate('end', end);

      Get.find<CouponController>().setDiscountTypeIndex(
          widget.coupon!.discountType == 'percent' ? 0 : 1, false);
    } else {
      Get.find<CouponController>().setDate('start', null);
      Get.find<CouponController>().setDate('end', null);
      Get.find<CouponController>().setDiscountTypeIndex(0, false);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _couponCodeController.dispose();
    _limitForSameUserController.dispose();
    _minPurchaseController.dispose();
    _maxPurchaseController.dispose();
    _discountAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(),
      appBar: const CustomAppBar(isBackButtonExist: true),
      body: GetBuilder<CouponController>(
        builder: (couponController) => Column(
          children: [
            CustomHeader(
                title: !update ? 'add_coupon'.tr : 'update_coupon'.tr,
                headerImage: Images.couponListIcon),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomFieldWithTitle(
                      title: 'title'.tr,
                      requiredField: true,
                      customTextField: CustomTextField(
                        hintText: 'new_year_discount'.tr,
                        controller: _titleController,
                        focusNode: _titleFocusNode,
                        nextFocus: _couponCodeFocusNode,
                        inputType: TextInputType.text,
                      ),
                    ),
                    CustomFieldWithTitle(
                      title: 'coupon_code'.tr,
                      requiredField: true,
                      customTextField: CustomTextField(
                        hintText: 'new_year'.tr,
                        controller: _couponCodeController,
                        focusNode: _couponCodeFocusNode,
                        inputType: TextInputType.text,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(
                          Dimensions.paddingSizeDefault,
                          0,
                          Dimensions.paddingSizeDefault,
                          0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'coupon_type'.tr,
                              style: fontSizeRegular.copyWith(
                                  color: Theme.of(context).primaryColor),
                            ),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Container(
                              height: 50,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeSmall),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                border: Border.all(
                                    width: .7,
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(.3)),
                                borderRadius: BorderRadius.circular(
                                    Dimensions.paddingSizeExtraSmall),
                              ),
                              child: DropdownButton<String>(
                                value: couponController.dropDownPosition == 0
                                    ? 'Default'
                                    : 'First order',
                                items: <String>['Default', 'First order']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  couponController.setDropDownPosition(
                                      value == 'Default' ? 0 : 1);
                                  selectedCouponType = value;
                                },
                                isExpanded: true,
                                underline: const SizedBox(),
                              ),
                            ),
                          ]),
                    ),
                    CustomFieldWithTitle(
                      title: 'limit_for_same_user'.tr,
                      requiredField: true,
                      customTextField: CustomTextField(
                        hintText: 'limit_user_hint'.tr,
                        controller: _limitForSameUserController,
                        focusNode: _limitForSameUserFocusNode,
                        inputType: TextInputType.number,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomDatePicker(
                            title: 'start_date'.tr,
                            text: couponController.startDate != null
                                ? couponController.dateFormat
                                    .format(couponController.startDate!)
                                    .toString()
                                : 'select_date'.tr,
                            image: Images.calender,
                            requiredField: true,
                            selectDate: () =>
                                couponController.selectDate("start", context),
                          ),
                        ),
                        Expanded(
                          child: CustomDatePicker(
                            title: 'end_date'.tr,
                            text: couponController.endDate != null
                                ? couponController.dateFormat
                                    .format(couponController.endDate!)
                                    .toString()
                                : 'select_date'.tr,
                            image: Images.calender,
                            requiredField: true,
                            selectDate: () =>
                                couponController.selectDate("end", context),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(
                                Dimensions.paddingSizeDefault,
                                0,
                                Dimensions.paddingSizeDefault,
                                0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'discount_type'.tr,
                                    style: fontSizeRegular.copyWith(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeSmall),
                                  Container(
                                    height: 50,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.paddingSizeSmall),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      border: Border.all(
                                          width: .7,
                                          color: Theme.of(context)
                                              .hintColor
                                              .withOpacity(.3)),
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.paddingSizeExtraSmall),
                                    ),
                                    child: DropdownButton<String>(
                                      value:
                                          couponController.discountTypeIndex ==
                                                  0
                                              ? 'percent'
                                              : 'amount',
                                      items: <String>['percent', 'amount']
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value.tr),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        couponController.setDiscountTypeIndex(
                                            value == 'percent' ? 0 : 1, true);
                                        selectedDiscountType = value;
                                      },
                                      isExpanded: true,
                                      underline: const SizedBox(),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        Expanded(
                          child: CustomFieldWithTitle(
                            title: 'discount_amount'.tr,
                            requiredField: true,
                            customTextField: CustomTextField(
                              hintText: 'discount_amount_hint'.tr,
                              controller: _discountAmountController,
                              focusNode: _discountAmountFocusNode,
                              inputAction: TextInputAction.done,
                              inputType: TextInputType.number,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomFieldWithTitle(
                              title: 'min_purchase'.tr,
                              requiredField: true,
                              customTextField: CustomTextField(
                                hintText: 'min_purchase_hint'.tr,
                                controller: _minPurchaseController,
                                focusNode: _minPurchaseFocusNode,
                                nextFocus: _maxPurchaseFocusNode,
                                inputType: TextInputType.text,
                              ),
                            ),
                          ),
                          if (couponController.discountTypeIndex == 0)
                            Expanded(
                              child: CustomFieldWithTitle(
                                title: 'max_discount'.tr,
                                requiredField: true,
                                customTextField: CustomTextField(
                                  hintText: 'max_discount_hint'.tr,
                                  controller: _maxPurchaseController,
                                  focusNode: _maxPurchaseFocusNode,
                                  inputType: TextInputType.text,
                                ),
                              ),
                            ),
                        ]),
                  ],
                ),
              ),
            ),
            couponController.isAdded
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width / 2 - 30,
                            vertical: Dimensions.paddingSizeLarge),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(25)),
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  )
                : CustomButton(
                    margin: const EdgeInsets.only(
                      left: Dimensions.paddingSizeDefault,
                      right: Dimensions.paddingSizeDefault,
                      bottom: Dimensions.paddingSizeDefault,
                    ),
                    buttonText: update ? 'update'.tr : 'save'.tr,
                    onPressed: () {
                      String title = _titleController.text.trim();
                      String couponCode = _couponCodeController.text.trim();
                      String limitForSameUser =
                          _limitForSameUserController.text.trim();
                      String? startDate;
                      String? endDate;

                      if (update) {
                        startDate = widget.coupon!.startDate;
                        endDate = widget.coupon!.expireDate;
                      } else {
                        if (couponController.startDate != null) {
                          startDate = couponController.dateFormat
                              .format(couponController.startDate!);
                        }

                        if (couponController.endDate != null) {
                          endDate = couponController.dateFormat
                              .format(couponController.endDate!);
                        }
                      }
                      String minPurchase = _minPurchaseController.text.trim();
                      String maxPurchase = _maxPurchaseController.text.trim();
                      String discountAmount =
                          _discountAmountController.text.trim();

                      if (title.isEmpty) {
                        showCustomSnackBar('enter_title'.tr);
                      } else if (couponCode.isEmpty) {
                        showCustomSnackBar('enter_coupon_code'.tr);
                      } else if (limitForSameUser.isEmpty) {
                        showCustomSnackBar('enter_limit_for_user'.tr);
                      } else if (int.parse(limitForSameUser) < 1) {
                        showCustomSnackBar('enter_minimum_1'.tr);
                      } else if (startDate == null) {
                        showCustomSnackBar('enter_start_date'.tr);
                      } else if (endDate == null) {
                        showCustomSnackBar('enter_end_date'.tr);
                      } else if (!(couponController.startDate!
                              .isBefore(couponController.endDate!) ||
                          couponController.startDate!
                              .isAtSameMomentAs(couponController.endDate!))) {
                        showCustomSnackBar('select_valid_date_range'.tr);
                      } else if (minPurchase.isEmpty) {
                        showCustomSnackBar('enter_min_purchase'.tr);
                      } else if (couponController.discountTypeIndex == 0 &&
                          maxPurchase.isEmpty) {
                        showCustomSnackBar('enter_max_discount'.tr);
                      } else if (discountAmount.isEmpty) {
                        showCustomSnackBar('enter_discount_amount'.tr);
                      } else {
                        Coupons coupon = Coupons(
                          id: update ? widget.coupon!.id : null,
                          title: title,
                          couponType: selectedCouponType,
                          userLimit: int.parse(limitForSameUser),
                          couponCode: couponCode,
                          startDate: startDate,
                          expireDate: endDate,
                          minPurchase: minPurchase,
                          maxDiscount: couponController.discountTypeIndex == 0
                              ? maxPurchase
                              : null,
                          discount: discountAmount,
                          discountType: selectedDiscountType,
                        );
                        couponController.addCoupon(coupon, update);
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
