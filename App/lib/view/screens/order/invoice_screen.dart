import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/order_controller.dart';
import 'package:gotoko/controller/splash_controller.dart';
import 'package:gotoko/helper/date_converter.dart';
import 'package:gotoko/helper/price_converter.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_app_bar.dart';
import 'package:gotoko/view/base/custom_divider.dart';
import 'package:gotoko/view/base/custom_drawer.dart';
import 'package:gotoko/view/base/custom_header.dart';
import 'package:gotoko/view/screens/pos_printer/invoice_print.dart';
import 'widget/invoice_element_view.dart';

class InVoiceScreen extends StatefulWidget {
  final int? orderId;
  const InVoiceScreen({Key? key, this.orderId}) : super(key: key);

  @override
  State<InVoiceScreen> createState() => _InVoiceScreenState();
}

class _InVoiceScreenState extends State<InVoiceScreen> {
  Future<void> _loadData() async {
    await Get.find<OrderController>().getInvoiceData(widget.orderId);
  }

  double totalPayableAmount = 0;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      endDrawer: const CustomDrawer(),
      body: GetBuilder<SplashController>(builder: (shopController) {
        return SingleChildScrollView(
          child: GetBuilder<OrderController>(builder: (invoiceController) {
            if (invoiceController.invoice != null &&
                invoiceController.invoice!.orderAmount != null) {
              totalPayableAmount = invoiceController.invoice!.orderAmount! +
                  invoiceController.totalTaxAmount -
                  invoiceController.invoice!.extraDiscount! -
                  invoiceController.invoice!.couponDiscountAmount!;
            }
            return Column(
              children: [
                CustomHeader(
                    title: 'invoice'.tr, headerImage: Images.peopleIcon),
                Padding(
                  padding:
                      const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Expanded(flex: 3, child: SizedBox.shrink()),
                      Padding(
                        padding:
                            const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: Container(
                          width: 80,
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeSmall,
                              vertical: Dimensions.paddingSizeSmall),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.paddingSizeBorder),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.to(InVoicePrintScreen(
                                configModel: shopController.configModel,
                                invoice: invoiceController.invoice,
                                orderId: widget.orderId,
                                discountProduct:
                                    invoiceController.discountOnProduct,
                                total: totalPayableAmount,
                              ));
                            },
                            child: Center(
                                child: Row(
                              children: [
                                Icon(
                                  Icons.event_note_outlined,
                                  color: Theme.of(context).cardColor,
                                  size: 15,
                                ),
                                const SizedBox(
                                    width: Dimensions.paddingSizeMediumBorder),
                                Text(
                                  'print'.tr,
                                  style: fontSizeRegular.copyWith(
                                      color: Theme.of(context).cardColor),
                                ),
                              ],
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Text(
                      shopController.configModel!.businessInfo!.shopName!,
                      style: fontSizeBold.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: Dimensions.fontSizeOverOverLarge,
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    Text(
                      shopController.configModel!.businessInfo!.shopAddress!,
                      style: fontSizeRegular.copyWith(
                          color: Theme.of(context).hintColor),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    Text(
                      shopController.configModel!.businessInfo!.shopPhone!,
                      style: fontSizeRegular.copyWith(
                          color: Theme.of(context).hintColor),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    Text(shopController.configModel!.businessInfo!.shopEmail!,
                        style: fontSizeRegular.copyWith(
                            color: Theme.of(context).hintColor)),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    Text(shopController.configModel!.businessInfo!.vat ?? 'vat',
                        style: fontSizeRegular.copyWith(
                            color: Theme.of(context).hintColor)),
                  ],
                ),
                GetBuilder<OrderController>(builder: (orderController) {
                  return orderController.invoice != null &&
                          orderController.invoice!.orderAmount != null
                      ? Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.paddingSizeDefault),
                          child: Column(
                            children: [
                              CustomDivider(color: Theme.of(context).hintColor),
                              const SizedBox(
                                  height: Dimensions.paddingSizeDefault),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      '${'invoice'.tr.toUpperCase()} # ${widget.orderId}',
                                      style: fontSizeBold.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: Dimensions.fontSizeLarge)),
                                  Text('payment_method'.tr,
                                      style: fontSizeBold.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: Dimensions.fontSizeLarge)),
                                ],
                              ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeSmall),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      DateConverter
                                          .dateTimeStringToMonthAndTime(
                                              orderController
                                                  .invoice!.createdAt!),
                                      style: fontSizeRegular),
                                  Text(
                                      '${'paid_by'.tr} ${invoiceController.invoice!.account != null ? invoiceController.invoice!.account!.account : 'customer balance'}',
                                      style: fontSizeRegular.copyWith(
                                        color: Theme.of(context).hintColor,
                                        fontSize: Dimensions.fontSizeDefault,
                                      )),
                                ],
                              ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeDefault),
                              CustomDivider(color: Theme.of(context).hintColor),
                              const SizedBox(
                                  height: Dimensions.paddingSizeLarge),
                              InvoiceElementView(
                                  serial: 'sl'.tr,
                                  title: 'product_info'.tr,
                                  quantity: 'qty'.tr,
                                  price: 'price'.tr,
                                  isBold: true),
                              const SizedBox(
                                  height: Dimensions.paddingSizeDefault),
                              ListView.builder(
                                itemBuilder: (con, index) {
                                  return SizedBox(
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text((index + 1).toString()),
                                          const SizedBox(
                                              width: Dimensions
                                                  .paddingSizeDefault),
                                          Expanded(
                                              child: Text(
                                            jsonDecode(orderController
                                                .invoice!
                                                .details![index]
                                                .productDetails!)['name'],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: Dimensions
                                                    .paddingSizeLarge),
                                            child: Text(orderController.invoice!
                                                .details![index].quantity
                                                .toString()),
                                          ),
                                          Text(PriceConverter.priceWithSymbol(
                                              orderController.invoice!
                                                  .details![index].price!)),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount:
                                    orderController.invoice!.details!.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.paddingSizeDefault),
                                child: CustomDivider(
                                    color: Theme.of(context).hintColor),
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'subtotal'.tr,
                                        style: fontSizeRegular.copyWith(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      Text(PriceConverter.priceWithSymbol(
                                          orderController
                                              .subTotalProductAmount)),
                                    ],
                                  ),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeSmall),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'product_discount'.tr,
                                        style: fontSizeRegular.copyWith(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      Text(PriceConverter.priceWithSymbol(
                                          invoiceController.discountOnProduct)),
                                    ],
                                  ),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeSmall),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'coupon_discount'.tr,
                                        style: fontSizeRegular.copyWith(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      Text(PriceConverter.priceWithSymbol(
                                          orderController
                                              .invoice!.couponDiscountAmount!)),
                                    ],
                                  ),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeSmall),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'extra_discount'.tr,
                                        style: fontSizeRegular.copyWith(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      Text(PriceConverter.priceWithSymbol(
                                          orderController
                                              .invoice!.extraDiscount!)),
                                    ],
                                  ),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeSmall),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'tax'.tr,
                                        style: fontSizeRegular.copyWith(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      Text(PriceConverter.priceWithSymbol(
                                          invoiceController.totalTaxAmount)),
                                    ],
                                  ),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeSmall),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.paddingSizeExtraSmall),
                                child: CustomDivider(
                                    color: Theme.of(context).hintColor),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'total'.tr,
                                    style: fontSizeBold.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: Dimensions.fontSizeLarge),
                                  ),
                                  Text(
                                      PriceConverter.priceWithSymbol(
                                          totalPayableAmount),
                                      style: fontSizeBold.copyWith(
                                          fontSize: Dimensions.fontSizeLarge)),
                                ],
                              ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeDefault),
                              if (orderController.invoice?.account?.account
                                      ?.toLowerCase() ==
                                  'cash')
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'change'.tr,
                                      style: fontSizeRegular.copyWith(
                                          fontSize: Dimensions.fontSizeDefault),
                                    ),
                                    Text(
                                        PriceConverter.priceWithSymbol(
                                            orderController
                                                    .invoice!.collectedCash! -
                                                totalPayableAmount),
                                        style: fontSizeRegular.copyWith(
                                            fontSize:
                                                Dimensions.fontSizeDefault)),
                                  ],
                                ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeDefault),
                              Column(
                                children: [
                                  Text('terms_and_condition'.tr,
                                      style: fontSizeMedium.copyWith(
                                          fontSize:
                                              Dimensions.fontSizeExtraLarge)),
                                  const SizedBox(
                                    height: Dimensions.paddingSizeSmall,
                                  ),
                                  Text(
                                    'terms_and_condition_details'.tr,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: fontSizeRegular.copyWith(
                                        fontSize: Dimensions.fontSizeSmall),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.paddingSizeLarge),
                                child: CustomDivider(
                                    color: Theme.of(context).hintColor),
                              ),
                              Column(
                                children: [
                                  Text(
                                      '${'powered_by'.tr} ${shopController.configModel!.businessInfo!.shopName}',
                                      style: fontSizeMedium.copyWith(
                                          fontSize:
                                              Dimensions.fontSizeExtraLarge)),
                                  const SizedBox(
                                    height: Dimensions.paddingSizeSmall,
                                  ),
                                  Text(
                                    '${'shop_online'.tr} ${shopController.configModel!.businessInfo!.shopName}',
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: fontSizeRegular.copyWith(
                                        fontSize: Dimensions.fontSizeSmall),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeCustomBottom),
                            ],
                          ),
                        )
                      : const SizedBox();
                }),
              ],
            );
          }),
        );
      }),
    );
  }
}
