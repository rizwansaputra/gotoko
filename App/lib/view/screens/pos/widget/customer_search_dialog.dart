import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/cart_controller.dart';
import 'package:gotoko/controller/theme_controller.dart';
import 'package:gotoko/controller/transaction_controller.dart';
import 'package:gotoko/data/model/response/account_model.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_divider.dart';

class CustomerSearchDialog extends StatelessWidget {
  const CustomerSearchDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.25;
    return GetBuilder<CartController>(builder: (searchCustomer) {
      return searchCustomer.searchedCustomerList != null &&
              searchCustomer.searchedCustomerList!.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraLarge),
              child: Container(
                height: height,
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.paddingSizeBorder),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[
                              Get.find<ThemeController>().darkTheme
                                  ? 800
                                  : 400]!,
                          spreadRadius: .5,
                          blurRadius: 12,
                          offset: const Offset(3, 5))
                    ]),
                child: ListView.builder(
                    itemCount: searchCustomer.searchedCustomerList!.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      return GetBuilder<CartController>(builder: (cart) {
                        return InkWell(
                          onTap: () {
                            searchCustomer.setCustomerInfo(
                              searchCustomer.searchedCustomerList![index].id,
                              searchCustomer.searchedCustomerList![index].name,
                              searchCustomer
                                  .searchedCustomerList![index].mobile,
                              searchCustomer
                                  .searchedCustomerList![index].balance,
                              true,
                            );
                            searchCustomer.searchCustomerController.text =
                                searchCustomer
                                    .searchedCustomerList![index].name!;
                            cart.customerWalletController.text = searchCustomer
                                .searchedCustomerList![index].balance
                                .toString();
                            Get.find<TransactionController>()
                                .addCustomerBalanceIntoAccountList(Accounts(
                                    id: 0, account: 'customer balance'));
                            cart.setSearchCustomerList(null);
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: Dimensions.paddingSizeSmall),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${searchCustomer.searchedCustomerList![index].name}',
                                      style: fontSizeRegular.copyWith(
                                          fontSize:
                                              Dimensions.fontSizeDefault)),
                                  const SizedBox(
                                    height: Dimensions.paddingSizeMediumBorder,
                                  ),
                                  CustomDivider(
                                      height: .5,
                                      color: Theme.of(context).hintColor),
                                ],
                              )),
                        );
                      });
                    }),
              ),
            )
          : const SizedBox.shrink();
    });
  }
}
