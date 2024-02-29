import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/account_controller.dart';
import 'package:gotoko/controller/transaction_controller.dart';
import 'package:gotoko/util/app_constants.dart';
import 'package:gotoko/util/color_resources.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_app_bar.dart';
import 'package:gotoko/view/base/custom_date_picker.dart';
import 'package:gotoko/view/base/custom_drawer.dart';
import 'package:gotoko/view/base/custom_header.dart';
import 'package:gotoko/view/base/custom_snackbar.dart';
import 'package:gotoko/view/base/secondary_header_view.dart';
import 'package:gotoko/view/screens/account_management/widget/customer_transaction_list_view.dart';
import 'package:gotoko/view/screens/account_management/widget/transaction_list_view.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionListScreen extends StatefulWidget {
  final bool fromCustomer;
  final int? customerId;
  const TransactionListScreen(
      {Key? key, this.fromCustomer = false, this.customerId})
      : super(key: key);

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    if (widget.fromCustomer) {
      Get.find<TransactionController>().getCustomerWiseTransactionListList(
          widget.customerId, 1,
          isUpdate: false);
    } else {
      Get.find<TransactionController>().getTransactionList(1, isUpdate: false);
    }

    Get.find<TransactionController>().getTransactionTypeList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(isBackButtonExist: true),
      endDrawer: const CustomDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          color: Theme.of(context).cardColor,
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {},
          child: CustomScrollView(
            controller: Get.find<TransactionController>().scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(children: [
                  CustomHeader(
                      title: 'transaction_List'.tr,
                      headerImage: Images.peopleIcon),
                  GetBuilder<TransactionController>(
                      builder: (transactionController) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GetBuilder<AccountController>(
                                builder: (accountController) {
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      Dimensions.paddingSizeDefault,
                                      0,
                                      Dimensions.paddingSizeDefault,
                                      0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'account'.tr,
                                        style: fontSizeRegular.copyWith(
                                            color:
                                                Theme.of(context).primaryColor),
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
                                                width: .5,
                                                color: Theme.of(context)
                                                    .hintColor
                                                    .withOpacity(.7)),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions
                                                    .paddingSizeMediumBorder)),
                                        child: DropdownButton<int>(
                                          value: accountController.accountIndex,
                                          items: accountController.accountIds
                                              .map((int? value) {
                                            return DropdownMenuItem<int>(
                                                value: value,
                                                child: Text(accountController
                                                    .accountList[
                                                        (accountController
                                                            .accountIds
                                                            .indexOf(value))]
                                                    .account!));
                                          }).toList(),
                                          onChanged: (int? value) {
                                            accountController.setAccountIndex(
                                                value, true);
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
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    Dimensions.paddingSizeDefault,
                                    0,
                                    Dimensions.paddingSizeDefault,
                                    0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'transaction_type'.tr,
                                      style: fontSizeRegular.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
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
                                              width: .5,
                                              color: Theme.of(context)
                                                  .hintColor
                                                  .withOpacity(.7)),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions
                                                  .paddingSizeMediumBorder)),
                                      child: DropdownButton<int>(
                                        value: transactionController
                                            .transactionTypeIndex,
                                        items: transactionController
                                            .transactionTypeIds
                                            .map((int? value) {
                                          return DropdownMenuItem<int>(
                                              value: value,
                                              child: Text(transactionController
                                                  .transactionTypeList![
                                                      (transactionController
                                                          .transactionTypeIds
                                                          .indexOf(value))]
                                                  .tranType!));
                                        }).toList(),
                                        onChanged: (int? value) {
                                          transactionController
                                              .setTransactionTypeIndex(
                                                  value, true);
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
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: CustomDatePicker(
                                title: 'from'.tr,
                                text: transactionController.startDate != null
                                    ? transactionController.dateFormat
                                        .format(
                                            transactionController.startDate!)
                                        .toString()
                                    : 'from_date'.tr,
                                image: Images.calender,
                                requiredField: false,
                                selectDate: () => transactionController
                                    .selectDate("start", context),
                              ),
                            ),
                            Expanded(
                              child: CustomDatePicker(
                                title: 'to'.tr,
                                text: transactionController.endDate != null
                                    ? transactionController.dateFormat
                                        .format(transactionController.endDate!)
                                        .toString()
                                    : 'to_date'.tr,
                                image: Images.calender,
                                requiredField: false,
                                selectDate: () => transactionController
                                    .selectDate("end", context),
                              ),
                            ),
                          ],
                        ),
                        Row(children: [
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                _launchUrl(Uri.parse(
                                    '${AppConstants.baseUrl}${AppConstants.transactionListExportUri}'));
                                _launchUrl(Uri.parse(
                                    '${AppConstants.baseUrl}${AppConstants.transactionListExportUri}?'
                                    'from=${transactionController.startDate.toString()}&to=${transactionController.endDate.toString()}&account_id=0&transaction_type='));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.paddingSizeSmall),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.paddingSizeSmall,
                                      vertical: Dimensions.paddingSizeSmall),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.paddingSizeBorder),
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                  ),
                                  child: Center(
                                      child: Text(
                                    'export'.tr,
                                    style: fontSizeRegular.copyWith(
                                        color: Theme.of(context).cardColor),
                                  )),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                transactionController.getTransactionList(1);
                                transactionController.resetDate();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.paddingSizeSmall),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.paddingSizeSmall,
                                      vertical: Dimensions.paddingSizeSmall),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.paddingSizeBorder),
                                    color: ColorResources
                                        .getCategoryWithProductColor(),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'reset'.tr,
                                    style: fontSizeRegular.copyWith(
                                        color: ColorResources.getTextColor()),
                                  )),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                String startDate =
                                    transactionController.startDate.toString();
                                String endDate =
                                    transactionController.endDate.toString();
                                String selectedStartDate = '';
                                String selectedEndDate = '';

                                if (startDate == 'null' && endDate == 'null') {
                                  showCustomSnackBar(
                                      'select_from_and_to_date'.tr);
                                } else {
                                  selectedStartDate = transactionController
                                      .dateFormat
                                      .format(transactionController.startDate!)
                                      .toString();
                                  selectedEndDate = transactionController
                                      .dateFormat
                                      .format(transactionController.endDate!)
                                      .toString();

                                  transactionController.getTransactionFilter(
                                      selectedStartDate,
                                      selectedEndDate,
                                      Get.find<AccountController>()
                                          .accountIndex,
                                      transactionController
                                              .transactionTypeName ??
                                          'income',
                                      1);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.paddingSizeSmall),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.paddingSizeSmall,
                                      vertical: Dimensions.paddingSizeSmall),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.paddingSizeBorder),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Center(
                                      child: Text(
                                    'filter'.tr,
                                    style: fontSizeRegular.copyWith(
                                        color: Theme.of(context).cardColor),
                                  )),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ]),
                    );
                  }),
                  SecondaryHeaderView(
                    isSerial: true,
                    key: UniqueKey(),
                    isTransaction: true,
                    title: 'transaction_info'.tr,
                  ),
                  widget.fromCustomer
                      ? CustomerTransactionListView(
                          isHome: false,
                          scrollController: _scrollController,
                          customerId: widget.customerId,
                        )
                      : const TransactionListView(
                          isHome: false,
                        )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}
