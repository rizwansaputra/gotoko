import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/supplier_controller.dart';
import 'package:gotoko/data/model/response/supplier_model.dart';
import 'package:gotoko/helper/price_converter.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/animated_custom_dialog.dart';
import 'package:gotoko/view/base/custom_app_bar.dart';
import 'package:gotoko/view/base/custom_date_picker.dart';
import 'package:gotoko/view/base/custom_drawer.dart';
import 'package:gotoko/view/base/custom_header.dart';
import 'package:gotoko/view/base/secondary_header_view.dart';
import 'package:gotoko/view/screens/user/widget/supplier_new_purchase_dialog.dart';
import 'package:gotoko/view/screens/user/widget/supplier_transaction_list.dart';

class SupplierTransactionListScreen extends StatefulWidget {
  final int? supplierId;
  final Suppliers? supplier;
  const SupplierTransactionListScreen({
    Key? key,
    this.supplierId,
    this.supplier,
  }) : super(key: key);

  @override
  State<SupplierTransactionListScreen> createState() =>
      _SupplierTransactionListScreenState();
}

class _SupplierTransactionListScreenState
    extends State<SupplierTransactionListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    Get.find<SupplierController>()
        .getSupplierTransactionList(1, widget.supplierId);
    Get.find<SupplierController>().getSupplierProfile(widget.supplierId);
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
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(children: [
                  CustomHeader(
                      title: 'transaction_List'.tr,
                      headerImage: Images.peopleIcon),
                  GetBuilder<SupplierController>(builder: (supplierController) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(children: [
                            Expanded(
                                child: Container(
                              padding: const EdgeInsets.fromLTRB(
                                  Dimensions.paddingSizeSmall,
                                  Dimensions.paddingSizeSmall,
                                  Dimensions.paddingSizeSmall,
                                  0),
                              height: 80,
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.05),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.paddingSizeSmall),
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  supplierController.supplierProfile != null
                                      ? Text(
                                          PriceConverter.priceWithSymbol(
                                              supplierController
                                                      .supplierProfile!
                                                      .dueAmount ??
                                                  0),
                                          style: fontSizeBold.copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize:
                                                  Dimensions.fontSizeLarge),
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeExtraSmall),
                                  Text(
                                    'due_amount'.tr,
                                    style: fontSizeMedium.copyWith(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  Container(
                                    transform: Matrix4.translationValues(
                                        0.0, -10.0, 0.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Spacer(),
                                        SizedBox(
                                            width: Dimensions.iconSizeSmall,
                                            height: Dimensions.iconSizeSmall,
                                            child: Image.asset(
                                              Images.dollar,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                            const SizedBox(width: Dimensions.paddingSizeSmall),
                            Expanded(
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      showAnimatedDialog(
                                          context,
                                          SupplierNewPurchaseDialog(
                                            supplier: widget.supplier,
                                          ),
                                          dismissible: false,
                                          isFlip: false);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.paddingSizeSmall,
                                          vertical:
                                              Dimensions.paddingSizeSmall),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.paddingSizeBorder),
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                      ),
                                      child: Center(
                                          child: Text(
                                        'add_new_purchase'.tr,
                                        style: fontSizeRegular.copyWith(
                                            color: Theme.of(context).cardColor),
                                      )),
                                    ),
                                  ),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeSmall),
                                  InkWell(
                                    onTap: () {
                                      showAnimatedDialog(
                                          context,
                                          SupplierNewPurchaseDialog(
                                              fromPay: true,
                                              dueAmount: supplierController
                                                      .supplierProfile!
                                                      .dueAmount ??
                                                  0,
                                              supplier: widget.supplier),
                                          dismissible: false,
                                          isFlip: false);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.paddingSizeSmall,
                                          vertical:
                                              Dimensions.paddingSizeSmall),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.paddingSizeBorder),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: Center(
                                          child: Text(
                                        'pay'.tr,
                                        style: fontSizeRegular.copyWith(
                                            color: Theme.of(context).cardColor),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          const SizedBox(height: Dimensions.paddingSizeDefault),
                          Row(
                            children: [
                              Expanded(
                                child: CustomDatePicker(
                                  title: 'from'.tr,
                                  text: supplierController.startDate != null
                                      ? supplierController.dateFormat
                                          .format(supplierController.startDate!)
                                          .toString()
                                      : 'from_date'.tr,
                                  image: Images.calender,
                                  requiredField: false,
                                  selectDate: () => supplierController
                                      .selectDate("start", context),
                                ),
                              ),
                              Expanded(
                                child: CustomDatePicker(
                                  title: 'to'.tr,
                                  text: supplierController.endDate != null
                                      ? supplierController.dateFormat
                                          .format(supplierController.endDate!)
                                          .toString()
                                      : 'to_date'.tr,
                                  image: Images.calender,
                                  requiredField: false,
                                  selectDate: () => supplierController
                                      .selectDate("end", context),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimensions.paddingSizeSmall),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                0, 0, Dimensions.paddingSizeDefault, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    String fromDate = supplierController
                                        .dateFormat
                                        .format(supplierController.startDate!)
                                        .toString();
                                    String toDate = supplierController
                                        .dateFormat
                                        .format(supplierController.endDate!)
                                        .toString();

                                    supplierController
                                        .getSupplierTransactionFilterList(
                                            1,
                                            widget.supplierId,
                                            fromDate,
                                            toDate);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions.paddingSizeLarge,
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  SecondaryHeaderView(
                    isSerial: true,
                    key: UniqueKey(),
                    isTransaction: true,
                    title: 'transaction_info'.tr,
                  ),
                  SupplierTransactionListView(
                      scrollController: _scrollController,
                      supplier: widget.supplier)
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
