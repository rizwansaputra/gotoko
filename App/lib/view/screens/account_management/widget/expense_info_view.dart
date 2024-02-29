import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/data/model/response/expense_model.dart';
import 'package:gotoko/helper/price_converter.dart';
import 'package:gotoko/util/color_resources.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_divider.dart';

class ExpenseCardViewWidget extends StatelessWidget {
  final Expenses? expense;
  final int? index;
  const ExpenseCardViewWidget({Key? key, this.index, this.expense})
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
                        '${'account_type'.tr}: ${expense!.account != null ? expense!.account!.account : ''}',
                        style: fontSizeMedium.copyWith(
                            color: Theme.of(context).primaryColor),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${'debit'.tr}: ',
                              style: fontSizeRegular.copyWith(
                                  color: Theme.of(context).hintColor)),
                          Text(
                              '- ${expense!.debit == 1 ? PriceConverter.priceWithSymbol(expense!.amount!) : 0}',
                              style: fontSizeRegular.copyWith(
                                  color: Theme.of(context).hintColor)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${'credit'.tr}: ',
                              style: fontSizeRegular.copyWith(
                                  color: Theme.of(context).hintColor)),
                          Text(
                              ' ${expense!.credit == 1 ? PriceConverter.priceWithSymbol(expense!.credit!) : 0}',
                              style: fontSizeRegular.copyWith(
                                  color: Theme.of(context).hintColor)),
                        ],
                      ),
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
                title: Text('balance'.tr,
                    style: fontSizeRegular.copyWith(
                        color: Theme.of(context).hintColor)),
                trailing: Text(
                    ' ${PriceConverter.priceWithSymbol(expense!.balance!)}',
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
                    Text('- ${expense!.description}',
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
