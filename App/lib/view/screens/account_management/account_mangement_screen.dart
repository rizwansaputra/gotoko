import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/view/base/custom_app_bar.dart';
import 'package:gotoko/view/base/custom_category_button.dart';
import 'package:gotoko/view/base/custom_drawer.dart';
import 'package:gotoko/view/screens/account_management/account_list_screen.dart';
import 'package:gotoko/view/screens/account_management/add_account_screen.dart';
import 'package:gotoko/view/screens/account_management/add_new_expense_screen.dart';
import 'package:gotoko/view/screens/account_management/add_new_transfer_screen.dart';
import 'package:gotoko/view/screens/account_management/transaction_list_screen.dart';

class AccountManagementScreen extends StatelessWidget {
  const AccountManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 0.12;
    return Scaffold(
      appBar: const CustomAppBar(isBackButtonExist: true),
      endDrawer: const CustomDrawer(),
      body: ListView(children: [
        CustomCategoryButton(
          buttonText: 'account_list'.tr,
          icon: Images.account,
          isSelected: false,
          isDrawer: false,
          padding: width,
          onTap: () => Get.to(() => const AccountListScreen(
                fromAccount: true,
              )),
        ),
        CustomCategoryButton(
          buttonText: 'add_account'.tr,
          icon: Images.account,
          isSelected: false,
          padding: width,
          isDrawer: false,
          onTap: () => Get.to(() => const AddAccountScreen()),
        ),
        CustomCategoryButton(
          buttonText: 'expense_list'.tr,
          icon: Images.expense,
          isSelected: false,
          isDrawer: false,
          padding: width,
          onTap: () => Get.to(() => const AccountListScreen()),
        ),
        CustomCategoryButton(
          buttonText: 'add_new_expanse'.tr,
          icon: Images.expense,
          isSelected: false,
          padding: width,
          isDrawer: false,
          onTap: () => Get.to(() => const AddNewExpenseScreen()),
        ),
        CustomCategoryButton(
          buttonText: 'income_list'.tr,
          icon: Images.income,
          isSelected: false,
          isDrawer: false,
          padding: width,
          onTap: () => Get.to(() => const AccountListScreen(isIncome: true)),
        ),
        CustomCategoryButton(
          buttonText: 'add_new_income'.tr,
          icon: Images.income,
          isSelected: false,
          padding: width,
          isDrawer: false,
          onTap: () => Get.to(() => const AddNewExpenseScreen(
                fromIncome: true,
              )),
        ),
        CustomCategoryButton(
          buttonText: 'add_new_transfer'.tr,
          icon: Images.brand,
          isSelected: false,
          padding: width,
          isDrawer: false,
          onTap: () => Get.to(() => const AddNewTransferScreen()),
        ),
        CustomCategoryButton(
          buttonText: 'transaction_list'.tr,
          icon: Images.transaction,
          isSelected: false,
          isDrawer: false,
          padding: width,
          onTap: () => Get.to(() => const TransactionListScreen()),
        ),
      ]),
    );
  }
}
