import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/supplier_controller.dart';
import 'package:gotoko/controller/transaction_controller.dart';
import 'package:gotoko/data/model/response/supplier_model.dart';
import 'package:gotoko/util/color_resources.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_button.dart';
import 'package:gotoko/view/base/custom_field_with_title.dart';
import 'package:gotoko/view/base/custom_snackbar.dart';
import 'package:gotoko/view/base/custom_text_field.dart';

class SupplierNewPurchaseDialog extends StatefulWidget {
  final double? dueAmount;
  final bool fromPay;
  final Suppliers? supplier;
  const SupplierNewPurchaseDialog(
      {Key? key, this.fromPay = false, this.dueAmount, this.supplier})
      : super(key: key);

  @override
  State<SupplierNewPurchaseDialog> createState() =>
      _SupplierNewPurchaseDialogState();
}

class _SupplierNewPurchaseDialogState extends State<SupplierNewPurchaseDialog> {
  TextEditingController purchaseAmountController = TextEditingController();
  TextEditingController paidAmountController = TextEditingController();
  TextEditingController dueAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.fromPay) {
      purchaseAmountController.text = widget.dueAmount.toString();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      child: GetBuilder<SupplierController>(builder: (supplierController) {
        return Container(
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
          height: 310,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomFieldWithTitle(
                      customTextField: CustomTextField(
                        hintText: 'purchased_amount_hint'.tr,
                        controller: purchaseAmountController,
                        inputType: TextInputType.number,
                        isEnabled: widget.fromPay ? false : true,
                      ),
                      title: widget.fromPay
                          ? 'total_due'.tr
                          : 'purchased_amount'.tr,
                      requiredField: false,
                    ),
                  ),
                  Expanded(
                    child: CustomFieldWithTitle(
                      customTextField: CustomTextField(
                        hintText: 'paid_amount_hint'.tr,
                        onChanged: (e) {
                          dueAmountController.text = (double.parse(
                                      purchaseAmountController.text
                                          .toString()) -
                                  double.parse(
                                      paidAmountController.text.toString()))
                              .toString();
                        },
                        controller: paidAmountController,
                        inputType: TextInputType.number,
                      ),
                      title: 'paid_amount'.tr,
                      requiredField: false,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 130,
                    child: CustomFieldWithTitle(
                      customTextField: CustomTextField(
                        hintText: '0',
                        controller: dueAmountController,
                        isEnabled: false,
                      ),
                      title:
                          widget.fromPay ? 'remaining_due'.tr : 'due_amount'.tr,
                      requiredField: false,
                    ),
                  ),
                  Expanded(
                    child: GetBuilder<TransactionController>(
                        builder: (transactionController) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(
                            Dimensions.paddingSizeDefault,
                            0,
                            Dimensions.paddingSizeDefault,
                            0),
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: Dimensions.paddingSizeDefault),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'account_to'.tr,
                                style: fontSizeRegular.copyWith(
                                    color: Theme.of(context).primaryColor),
                              ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeSmall),
                              Container(
                                height: 50,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.paddingSizeSmall),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    border: Border.all(
                                        width: .5,
                                        color: Theme.of(context)
                                            .hintColor
                                            .withOpacity(.7)),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.paddingSizeMediumBorder)),
                                child: DropdownButton<int>(
                                  hint: Text('select'.tr),
                                  value: transactionController.fromAccountIndex,
                                  items: transactionController.fromAccountIds
                                      ?.map((int? value) {
                                    return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text(transactionController
                                            .accountList![(transactionController
                                                .fromAccountIds!
                                                .indexOf(value))]
                                            .account!));
                                  }).toList(),
                                  onChanged: (int? value) {
                                    transactionController.setAccountIndex(
                                        value, 'from', true);
                                  },
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                ),
                              ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeSmall),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                            buttonText: 'cancel'.tr,
                            buttonColor: Theme.of(context).hintColor,
                            textColor: ColorResources.getTextColor(),
                            isClear: true,
                            onPressed: () => Get.back())),
                    const SizedBox(width: Dimensions.paddingSizeDefault),
                    Expanded(
                        child: CustomButton(
                      buttonText: 'submit'.tr,
                      onPressed: () {
                        String purchaseAmount = purchaseAmountController.text;
                        String paidAmount = paidAmountController.text;
                        String dueAmount = dueAmountController.text;

                        if (purchaseAmount.isEmpty) {
                          showCustomSnackBar('purchase_amount_cant_empty'.tr);
                        } else if (paidAmount.isEmpty) {
                          showCustomSnackBar('pay_minimum_0'.tr);
                        } else if (double.parse(paidAmount) >
                            double.parse(purchaseAmount)) {
                          showCustomSnackBar(
                              'cant_pay_more_than_purchase_amount'.tr);
                        } else if (double.parse(purchaseAmount) < 0.0) {
                          showCustomSnackBar(
                              'purchase_amount_cant_negative'.tr);
                        } else if (double.parse(paidAmount) < 0.0) {
                          showCustomSnackBar('paid_amount_cant_negative'.tr);
                        } else {
                          widget.fromPay
                              ? supplierController.supplierPayment(
                                  widget.supplier!.id,
                                  widget.dueAmount,
                                  double.parse(paidAmount),
                                  double.parse(dueAmount),
                                  Get.find<TransactionController>()
                                      .selectedFromAccountId)
                              : supplierController.supplierNewPurchase(
                                  widget.supplier!.id,
                                  double.parse(purchaseAmount),
                                  double.parse(paidAmount),
                                  double.parse(dueAmount),
                                  Get.find<TransactionController>()
                                      .selectedFromAccountId);
                          // Get.back();
                        }
                      },
                    )),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
