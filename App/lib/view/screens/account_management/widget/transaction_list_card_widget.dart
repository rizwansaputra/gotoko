import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/data/model/response/transaction_model.dart';
import 'package:gotoko/helper/price_converter.dart';
import 'package:gotoko/util/color_resources.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_divider.dart';

class TransactionCardViewWidget extends StatelessWidget {
  final Transfers? transfer;
  final int? index;
  const TransactionCardViewWidget({Key? key, this.index, this.transfer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 5, color: Theme.of(context).primaryColor.withOpacity(0.06)),
        Container(
          color: Theme.of(context).cardColor,
          child: Column(
            children: [
              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                leading: Text(
                  '${index! + 1}.',
                  style: fontSizeRegular.copyWith(
                      color: Theme.of(context).secondaryHeaderColor),
                ),
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${'account_type'.tr}: ${transfer!.account != null ? transfer!.account!.account : ''}',
                        style: fontSizeMedium.copyWith(
                            color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      Text(
                        '${'type'.tr}: ${transfer!.tranType}',
                        style: fontSizeMedium.copyWith(
                            color: ColorResources.getTextColor()),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      Text(
                        '${'transaction_date'.tr}: ${transfer!.date}',
                        style: fontSizeRegular.copyWith(
                            color: Theme.of(context).hintColor),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Debit: ',
                              style: fontSizeRegular.copyWith(
                                  color: Theme.of(context).hintColor)),
                          Text(
                              '- ${transfer!.debit == 1 ? PriceConverter.priceWithSymbol(transfer!.amount!) : 0}',
                              style: fontSizeRegular.copyWith(
                                  color: Theme.of(context).hintColor)),
                        ],
                      ),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Credit: ',
                              style: fontSizeRegular.copyWith(
                                  color: Theme.of(context).hintColor)),
                          Text(
                              '${transfer!.credit == 1 ? PriceConverter.priceWithSymbol(transfer!.amount!) : 0}',
                              style: fontSizeRegular.copyWith(
                                  color: Theme.of(context).hintColor)),
                        ],
                      ),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault),
                child: CustomDivider(color: Theme.of(context).hintColor),
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                leading: const SizedBox(),
                title: Text('Balance',
                    style: fontSizeRegular.copyWith(
                        color: ColorResources.getTextColor())),
                trailing: Text(
                    PriceConverter.priceWithSymbol(transfer!.balance!),
                    style: fontSizeRegular.copyWith(
                        color: Theme.of(context).hintColor)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault,
                    vertical: Dimensions.paddingSizeSmall),
                child: Row(
                  children: [
                    Text('${'description'.tr} : ',
                        style: fontSizeRegular.copyWith(
                            color: ColorResources.getTextColor())),
                    Text('- ${transfer!.description}',
                        style: fontSizeRegular.copyWith(
                            color: Theme.of(context).hintColor)),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
            height: 5, color: Theme.of(context).primaryColor.withOpacity(0.06)),
      ],
    );
  }
}
