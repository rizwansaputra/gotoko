import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/account_controller.dart';
import 'package:gotoko/data/model/response/account_model.dart';
import 'package:gotoko/helper/price_converter.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/animated_custom_dialog.dart';
import 'package:gotoko/view/base/custom_divider.dart';
import 'package:gotoko/view/base/custom_ink_well.dart';
import 'package:gotoko/view/base/logout_dialog.dart';
import 'package:gotoko/view/screens/account_management/add_account_screen.dart';

class AccountCardViewWidget extends StatelessWidget {
  final bool isHome;
  final Accounts? account;
  final int? index;
  const AccountCardViewWidget(
      {Key? key, this.account, this.index, this.isHome = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isHome
        ? Container(
            height: 40,
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('${index! + 1}.',
                        style: fontSizeRegular.copyWith(
                            color: Theme.of(context).primaryColor)),
                    const SizedBox(width: Dimensions.paddingSizeLarge),
                    Expanded(
                        child: Text(
                      '${account?.account}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: fontSizeRegular.copyWith(
                          color: Theme.of(context).primaryColor),
                    )),
                    const Spacer(),
                    Text(PriceConverter.convertPrice(context, account?.balance),
                        style: fontSizeRegular.copyWith(
                            color: Theme.of(context).primaryColor)),
                  ],
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                CustomDivider(color: Theme.of(context).hintColor, height: .5)
              ],
            ),
          )
        : Column(
            children: [
              Container(
                  height: 5,
                  color: Theme.of(context).primaryColor.withOpacity(0.06)),
              Container(
                color: Theme.of(context).cardColor,
                child: Column(
                  children: [
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      leading: Text(
                        '${index! + 1}.',
                        style: fontSizeRegular.copyWith(
                            color: Theme.of(context).secondaryHeaderColor),
                      ),
                      title: Text(
                        '${'account_type'.tr} : ${account!.account}',
                        style: fontSizeRegular.copyWith(
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault),
                      child: CustomDivider(color: Theme.of(context).hintColor),
                    ),
                    ListTile(
                        leading: const SizedBox(),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: Dimensions.paddingSizeSmall),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('balance_info'.tr,
                                    style: fontSizeMedium.copyWith(
                                        color: Theme.of(context).primaryColor)),
                                Text(
                                    '${'balance'.tr} : ${PriceConverter.convertPrice(context, account?.balance)}'),
                                Text(
                                    '${'total_in'.tr}: ${PriceConverter.convertPrice(context, account?.totalIn)}'),
                                Text(
                                    '${'total_out'.tr}: ${PriceConverter.convertPrice(context, account?.totalOut)}'),
                              ]),
                        ),
                        trailing: account!.id == 1 ||
                                account!.id == 2 ||
                                account!.id == 3
                            ? const SizedBox()
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                          Dimensions.paddingSizeDefault),
                                      child: CustomInkWell(
                                        child: Image.asset(Images.editIcon,
                                            height: 20),
                                        onTap: () {
                                          Get.to(AddAccountScreen(
                                              account: account));
                                        },
                                      ),
                                    ),
                                  ),
                                  GetBuilder<AccountController>(
                                      builder: (accountController) {
                                    return Flexible(
                                      child: CustomInkWell(
                                        child: Image.asset(Images.deleteIcon,
                                            height: 20),
                                        onTap: () {
                                          showAnimatedDialog(
                                              context,
                                              CustomDialog(
                                                delete: true,
                                                icon: Icons.exit_to_app_rounded,
                                                title: '',
                                                description:
                                                    'are_you_sure_you_want_to_delete_account'
                                                        .tr,
                                                onTapFalse: () =>
                                                    Navigator.of(context)
                                                        .pop(true),
                                                onTapTrue: () {
                                                  accountController
                                                      .deleteAccount(
                                                          account!.id);
                                                },
                                                onTapTrueText: 'yes'.tr,
                                                onTapFalseText: 'cancel'.tr,
                                              ),
                                              dismissible: false,
                                              isFlip: true);
                                        },
                                      ),
                                    );
                                  }),
                                ],
                              ))
                  ],
                ),
              ),
              Container(
                  height: 5,
                  color: Theme.of(context).primaryColor.withOpacity(0.06)),
            ],
          );
  }
}
