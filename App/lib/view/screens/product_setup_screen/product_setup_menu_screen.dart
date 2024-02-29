import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/view/base/custom_app_bar.dart';
import 'package:gotoko/view/base/custom_category_button.dart';
import 'package:gotoko/view/base/custom_drawer.dart';
import 'package:gotoko/view/screens/brand/brand_screen.dart';
import 'package:gotoko/view/screens/category/category_screen.dart';
import 'package:gotoko/view/screens/coupon/coupon_screen.dart';
import 'package:gotoko/view/screens/product_setup_screen/product_setup_screen.dart';
import 'package:gotoko/view/screens/unit/unit_list_screen.dart';

class ProductSetupMenuScreen extends StatelessWidget {
  final bool isFromDrawer;
  const ProductSetupMenuScreen({Key? key, this.isFromDrawer = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * .12;
    return Scaffold(
      appBar: isFromDrawer ? const CustomAppBar() : null,
      endDrawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomCategoryButton(
              buttonText: 'categories'.tr,
              icon: Images.categories,
              isSelected: false,
              isDrawer: false,
              padding: width,
              onTap: () => Get.to(const CategoryScreen()),
            ),
            CustomCategoryButton(
              buttonText: 'brands'.tr,
              icon: Images.brand,
              isSelected: false,
              onTap: () => Get.to(const BrandListViewScreen()),
              padding: width,
              isDrawer: false,
            ),
            CustomCategoryButton(
              buttonText: 'product_units'.tr,
              icon: Images.productUnit,
              isSelected: false,
              onTap: () => Get.to(const UnitListViewScreen()),
              padding: width,
              isDrawer: false,
            ),
            CustomCategoryButton(
              buttonText: 'product_setup'.tr,
              icon: Images.productSetup,
              isSelected: false,
              onTap: () => Get.to(const ProductSetupScreen()),
              padding: width,
              isDrawer: false,
            ),
            CustomCategoryButton(
              buttonText: 'coupons'.tr,
              icon: Images.coupon,
              isSelected: false,
              onTap: () => Get.to(const CouponScreen()),
              padding: width,
              isDrawer: false,
            )
          ],
        ),
      ),
    );
  }
}
