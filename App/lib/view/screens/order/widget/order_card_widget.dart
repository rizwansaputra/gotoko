import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/data/model/response/order_model.dart';
import 'package:gotoko/helper/date_converter.dart';
import 'package:gotoko/helper/price_converter.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_button.dart';
import 'package:gotoko/view/screens/order/invoice_screen.dart';
import 'package:gotoko/view/screens/user/widget/custom_divider.dart';

class OrderCardWidget extends StatelessWidget {
  final Orders? order;
  const OrderCardWidget({Key? key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 5, color: Theme.of(context).primaryColor.withOpacity(0.03)),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
              Text('${order!.id}',
                  style: fontSizeRegular.copyWith(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontSize: Dimensions.fontSizeLarge,
                  )),
              const SizedBox(height: 5),
              Text(
                  DateConverter.dateTimeStringToMonthAndTime(order!.createdAt!),
                  style: fontSizeRegular),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeSmall),
                child: CustomDivider(color: Theme.of(context).hintColor),
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('order_summary'.tr,
                            style: fontSizeRegular.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: Dimensions.fontSizeLarge,
                            )),
                        const SizedBox(height: 5),
                        Text(
                          '${'order_amount'.tr}: ${PriceConverter.priceWithSymbol(order!.orderAmount!)}',
                          style: fontSizeRegular.copyWith(
                              color: Theme.of(context).hintColor),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${'tax'.tr}: ${PriceConverter.priceWithSymbol(
                            double.tryParse(order!.totalTax.toString())!,
                          )}',
                          style: fontSizeRegular.copyWith(
                              color: Theme.of(context).hintColor),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${'extra_discount'.tr}: ${PriceConverter.priceWithSymbol(double.parse(order!.extraDiscount.toString()))}',
                          style: fontSizeRegular.copyWith(
                              color: Theme.of(context).hintColor),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${'coupon_discount'.tr}: ${PriceConverter.priceWithSymbol(
                            double.tryParse(
                                order!.couponDiscountAmount.toString())!,
                          )}',
                          style: fontSizeRegular.copyWith(
                              color: Theme.of(context).hintColor),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('payment_method'.tr,
                                style: fontSizeRegular.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeLarge,
                                )),
                            const SizedBox(height: 5),
                            Text(
                              order!.account != null
                                  ? order!.account!.account!
                                  : 'customer balance',
                              style: fontSizeRegular.copyWith(
                                color: Theme.of(context).hintColor,
                                fontSize: Dimensions.fontSizeLarge,
                              ),
                            ),
                          ],
                        ),
                        CustomButton(
                          buttonText: 'invoice'.tr,
                          width: 120,
                          height: 40,
                          icon: Icons.event_note_outlined,
                          onPressed: () =>
                              Get.to(() => InVoiceScreen(orderId: order!.id)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            ],
          ),
        ),
        Container(
            height: 5, color: Theme.of(context).primaryColor.withOpacity(0.03)),
      ],
    );
  }
}
