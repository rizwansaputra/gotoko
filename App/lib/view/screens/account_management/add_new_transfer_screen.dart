import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:gotoko/controller/transaction_controller.dart';
import 'package:gotoko/data/model/response/transaction_model.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_app_bar.dart';
import 'package:gotoko/view/base/custom_button.dart';
import 'package:gotoko/view/base/custom_drawer.dart';
import 'package:gotoko/view/base/custom_field_with_title.dart';
import 'package:gotoko/view/base/custom_header.dart';
import 'package:gotoko/view/base/custom_snackbar.dart';
import 'package:gotoko/view/base/custom_text_field.dart';

class AddNewTransferScreen extends StatefulWidget {
  const AddNewTransferScreen({Key? key}) : super(key: key);

  @override
  State<AddNewTransferScreen> createState() => _AddNewTransferScreenState();
}

class _AddNewTransferScreenState extends State<AddNewTransferScreen> {
  TextEditingController expenseDescriptionController = TextEditingController();
  TextEditingController expenseAmountController = TextEditingController();
  TextEditingController transferDateController = TextEditingController();

  FocusNode accountDescriptionNode = FocusNode();
  FocusNode accountBalanceNode = FocusNode();
  FocusNode accountNumberNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Get.find<TransactionController>().getTransactionAccountList(1);
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2022, 1),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
          String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
          transferDateController.text = formattedDate;
        });
      }
    }

    return Scaffold(
      appBar: const CustomAppBar(isBackButtonExist: true),
      endDrawer: const CustomDrawer(),
      body: GetBuilder<TransactionController>(builder: (transactionController) {
        return SingleChildScrollView(
          child: Column(children: [
            CustomHeader(
                title: 'add_new_transfer'.tr, headerImage: Images.brand),
            Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    Dimensions.paddingSizeDefault,
                    0,
                    Dimensions.paddingSizeDefault,
                    0),
                child: Container(
                  padding:
                      const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'account_from'.tr,
                            style: fontSizeRegular.copyWith(
                                color: Theme.of(context).primaryColor),
                          ),
                          Text(
                            ' *',
                            style: fontSizeRegular.copyWith(
                                color: Theme.of(context).secondaryHeaderColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: Dimensions.paddingSizeSmall),
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
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    Dimensions.paddingSizeDefault,
                    0,
                    Dimensions.paddingSizeDefault,
                    0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'account_to'.tr,
                          style: fontSizeRegular.copyWith(
                              color: Theme.of(context).primaryColor),
                        ),
                        Text(
                          ' *',
                          style: fontSizeRegular.copyWith(
                              color: Theme.of(context).secondaryHeaderColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeSmall),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          border: Border.all(
                              width: .5,
                              color:
                                  Theme.of(context).hintColor.withOpacity(.7)),
                          borderRadius: BorderRadius.circular(
                              Dimensions.paddingSizeMediumBorder)),
                      child: DropdownButton<int>(
                        hint: Text('select'.tr),
                        value: transactionController.toAccountIndex,
                        items: transactionController.toAccountIds
                            ?.map((int? value) {
                          return DropdownMenuItem<int>(
                              value: value,
                              child: Text(transactionController
                                  .accountList![(transactionController
                                      .toAccountIds!
                                      .indexOf(value))]
                                  .account!));
                        }).toList(),
                        onChanged: (int? value) {
                          if (value == transactionController.fromAccountIndex) {
                            transactionController.setAccountIndex(
                                1, 'to', true);
                          } else {
                            transactionController.setAccountIndex(
                                value, 'to', true);
                          }
                        },
                        isExpanded: true,
                        underline: const SizedBox(),
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                  ],
                ),
              ),
              CustomFieldWithTitle(
                customTextField: CustomTextField(
                  hintText: 'description'.tr,
                  controller: expenseDescriptionController,
                  inputAction: TextInputAction.next,
                  focusNode: accountDescriptionNode,
                  nextFocus: accountBalanceNode,
                ),
                title: 'description'.tr,
                requiredField: true,
              ),
              CustomFieldWithTitle(
                customTextField: CustomTextField(
                    hintText: 'init_balance_hint'.tr,
                    controller: expenseAmountController,
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.number),
                title: 'amount'.tr,
                requiredField: true,
              ),
              InkWell(
                onTap: () => selectDate(context),
                child: CustomFieldWithTitle(
                  customTextField: CustomTextField(
                    hintText: '2022-05-17'.tr,
                    controller: transferDateController,
                    suffix: true,
                    suffixIcon: Images.calender,
                    isEnabled: false,
                    inputAction: TextInputAction.done,
                  ),
                  title: 'date'.tr,
                  requiredField: true,
                ),
              ),
            ]),
            transactionController.isLoading
                ? Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).cardColor,
                    ),
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      buttonText: 'save'.tr,
                      onPressed: () {
                        String description =
                            expenseDescriptionController.text.trim();
                        String balance = expenseAmountController.text.trim();
                        String expenseDate =
                            transferDateController.text.toString();
                        int? fromAccountId =
                            transactionController.selectedFromAccountId;
                        int? toAccountId =
                            transactionController.selectedToAccountId;

                        if (description.isEmpty) {
                          showCustomSnackBar('expense_description_required'.tr);
                        } else if (fromAccountId == toAccountId) {
                          showCustomSnackBar('cant_transfer_same_account'.tr);
                        } else if (balance.isEmpty) {
                          showCustomSnackBar('expense_balance_required'.tr);
                        } else if (expenseDate.isEmpty) {
                          showCustomSnackBar('expense_date_required'.tr);
                        } else {
                          Transfers transfer = Transfers(
                            description: description,
                            amount: double.parse(balance),
                            date: expenseDate,
                          );
                          transactionController.addTransaction(
                              transfer, fromAccountId, toAccountId);
                        }
                      },
                    ),
                  ),
          ]),
        );
      }),
    );
  }
}
