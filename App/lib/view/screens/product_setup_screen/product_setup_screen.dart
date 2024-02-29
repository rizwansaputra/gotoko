import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/view/base/custom_app_bar.dart';
import 'package:gotoko/view/base/custom_category_button.dart';
import 'package:gotoko/view/base/custom_drawer.dart';
import 'package:gotoko/view/screens/product/product_view_screen.dart';
import 'package:gotoko/view/screens/product_setup_screen/add_product_screen.dart';
import 'package:gotoko/view/screens/product_setup_screen/product_bulk_export.dart';
import 'package:gotoko/view/screens/product_setup_screen/product_bulk_import.dart';

class ProductSetupScreen extends StatelessWidget {
  const ProductSetupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * .12;
    return Scaffold(
      appBar: const CustomAppBar(),
      endDrawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomCategoryButton(
                buttonText: 'product_list'.tr,
                icon: Images.productSetup,
                isSelected: false,
                isDrawer: false,
                padding: width,
                onTap: () => Get.to(const ProductScreen())),
            CustomCategoryButton(
                buttonText: 'add_new_product'.tr,
                icon: Images.addCategoryIcon,
                isSelected: false,
                onTap: () => Get.to(const AddProductScreen()),
                padding: width,
                isDrawer: false),
            CustomCategoryButton(
                buttonText: 'bulk_import'.tr,
                icon: Images.importExport,
                isSelected: false,
                onTap: () => Get.to(const ProductBulkImport()),
                padding: width,
                isDrawer: false),
            CustomCategoryButton(
                buttonText: 'bulk_export'.tr,
                icon: Images.importExport,
                isSelected: false,
                onTap: () => Get.to(const ProductBulkExport()),
                padding: width,
                isDrawer: false),
          ],
        ),
      ),
    );
  }
}
