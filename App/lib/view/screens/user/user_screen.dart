import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/view/base/custom_app_bar.dart';
import 'package:gotoko/view/base/custom_category_button.dart';
import 'package:gotoko/view/base/custom_drawer.dart';
import 'package:gotoko/view/screens/user/supplier_or_customer_list.dart';
import 'package:gotoko/view/screens/user/add_new_suppliers_and_customers.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 0.12;
    return Scaffold(
      appBar: const CustomAppBar(isBackButtonExist: true),
      endDrawer: const CustomDrawer(),
      body: ListView(children: [
        CustomCategoryButton(
          buttonText: 'supplier_list'.tr,
          icon: Images.peopleIcon,
          isSelected: false,
          isDrawer: false,
          padding: width,
          onTap: () => Get.to(() => const SupplierOrCustomerList()),
        ),
        CustomCategoryButton(
          buttonText: 'add_new_supplier'.tr,
          icon: Images.addCategoryIcon,
          isSelected: false,
          padding: width,
          isDrawer: false,
          onTap: () => Get.to(() => const AddNewSuppliersOrCustomer()),
        ),
        CustomCategoryButton(
          buttonText: 'customer_list'.tr,
          icon: Images.peopleIcon,
          isSelected: false,
          isDrawer: false,
          padding: width,
          onTap: () =>
              Get.to(() => const SupplierOrCustomerList(isCustomer: true)),
        ),
        CustomCategoryButton(
          buttonText: 'add_new_customer'.tr,
          icon: Images.addCategoryIcon,
          isSelected: false,
          padding: width,
          isDrawer: false,
          onTap: () => Get.to(() => const AddNewSuppliersOrCustomer(
                isCustomer: true,
              )),
        ),
      ]),
    );
  }
}
