import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/brand_controller.dart';
import 'package:gotoko/controller/category_controller.dart';
import 'package:gotoko/controller/product_controller.dart';
import 'package:gotoko/controller/supplier_controller.dart';
import 'package:gotoko/controller/unit_controller.dart';
import 'package:gotoko/data/model/response/product_model.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_app_bar.dart';
import 'package:gotoko/view/base/custom_button.dart';
import 'package:gotoko/view/base/custom_drawer.dart';
import 'package:gotoko/view/base/custom_header.dart';
import 'package:gotoko/view/base/custom_snackbar.dart';
import 'package:gotoko/view/screens/product_setup_screen/widget/product_general_info.dart';
import 'package:gotoko/view/screens/product_setup_screen/widget/product_price_info.dart';

class AddProductScreen extends StatefulWidget {
  final Products? product;
  const AddProductScreen({Key? key, this.product}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  int selectedIndex = 0;
  late bool update;

  Future<void> _loadData() async {
    Get.find<CategoryController>()
        .getCategoryList(1, product: widget.product, reload: true, limit: 100);
    Get.find<BrandController>()
        .getBrandList(1, product: widget.product, reload: true, limit: 100);
    Get.find<UnitController>()
        .getUnitList(1, product: widget.product, limit: 100);
    Get.find<SupplierController>()
        .getSupplierList(1, product: widget.product, reload: true, limit: 100);
  }

  @override
  void initState() {
    super.initState();

    final productController = Get.find<ProductController>();

    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    _tabController?.addListener(() {
      if (_tabController != null && !_tabController!.indexIsChanging) {
        productController.setIndexForTabBar(_tabController!.index);
      }
    });

    update = widget.product != null;
    productController.setIndexForTabBar(0, isUpdate: false);
    _loadData();

    if (update) {
      productController.productSellingPriceController.text =
          widget.product!.sellingPrice.toString();
      productController.productPurchasePriceController.text =
          widget.product!.purchasePrice.toString();
      productController.productTaxController.text =
          widget.product!.tax.toString();
      productController.productDiscountController.text =
          widget.product!.discount.toString();
      productController.productSkuController.text =
          widget.product!.productCode!;
      productController.productStockController.text =
          widget.product!.quantity.toString();
      productController.productNameController.text = widget.product!.title!;
      productController.unitValueController.text =
          widget.product!.unitValue.toString();
    } else {
      productController.productSellingPriceController.clear();
      productController.productPurchasePriceController.clear();
      productController.productTaxController.clear();
      productController.productDiscountController.clear();
      productController.productSkuController.clear();
      productController.productStockController.clear();
      productController.productNameController.clear();
      productController.unitValueController.clear();

      Get.find<BrandController>().setBrandEmpty();
      Get.find<CategoryController>().setCategoryAndSubCategoryEmpty();
      Get.find<UnitController>().setUnitEmpty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(),
      appBar: const CustomAppBar(),
      body: Column(children: [
        CustomHeader(
            title: update ? 'update_product'.tr : 'add_product'.tr,
            headerImage: Images.addNewCategory),
        Center(
          child: Container(
            width: 1170,
            color: Theme.of(context).cardColor,
            child: TabBar(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraLarge),
              controller: _tabController,
              labelColor: Theme.of(context).secondaryHeaderColor,
              unselectedLabelColor: Theme.of(context).primaryColor,
              indicatorColor: Theme.of(context).secondaryHeaderColor,
              indicatorWeight: 3,
              unselectedLabelStyle: fontSizeRegular.copyWith(
                fontSize: Dimensions.fontSizeDefault,
                fontWeight: FontWeight.w400,
              ),
              labelStyle: fontSizeRegular.copyWith(
                fontSize: Dimensions.fontSizeDefault,
                fontWeight: FontWeight.w700,
              ),
              tabs: [
                Tab(text: 'general_info'.tr),
                Tab(text: 'price_info'.tr),
              ],
            ),
          ),
        ),
        Expanded(
            child: TabBarView(
          controller: _tabController,
          children: [
            ProductGeneralInfo(product: widget.product),
            const ProductPriceInfo(),
          ],
        )),
      ]),
      bottomNavigationBar:
          GetBuilder<ProductController>(builder: (productController) {
        return Container(
          height: 70,
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: productController.selectionTabIndex == 0
              ? CustomButton(
                  buttonText: 'next'.tr,
                  onPressed: () {
                    _tabController!.animateTo((_tabController!.index + 1) % 2);
                    selectedIndex = _tabController!.index + 1;
                    productController.setIndexForTabBar(selectedIndex);
                  },
                )
              : Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        buttonColor: Theme.of(context).hintColor,
                        buttonText: 'back'.tr,
                        onPressed: () {
                          _tabController!
                              .animateTo((_tabController!.index + 1) % 2);
                          selectedIndex = _tabController!.index + 1;
                          productController.setIndexForTabBar(selectedIndex);
                        },
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeDefault),
                    GetBuilder<CategoryController>(
                        builder: (categoryController) {
                      return Expanded(
                        child: CustomButton(
                          buttonText: update ? 'update'.tr : 'save'.tr,
                          onPressed: () {
                            String sellingPrice = productController
                                .productSellingPriceController.text
                                .trim();
                            String purchasePrice = productController
                                .productPurchasePriceController.text
                                .trim();
                            String tax = productController
                                .productTaxController.text
                                .trim();
                            String discount = productController
                                .productDiscountController.text
                                .trim();
                            String? categoryId;
                            if (categoryController.categoryIndex != 0) {
                              categoryId = categoryController
                                  .categoryList[
                                      categoryController.categoryIndex - 1]
                                  .id
                                  .toString();
                            }

                            String subCategoryId =
                                Get.find<CategoryController>()
                                    .subCategoryIndex
                                    .toString();
                            String unitId =
                                Get.find<UnitController>().unitIndex.toString();
                            int? brandId =
                                Get.find<BrandController>().brandIndex;
                            int? supplierId =
                                Get.find<SupplierController>().supplierIndex;
                            String productName = productController
                                .productNameController.text
                                .trim();
                            String productCode = productController
                                .productSkuController.text
                                .trim();
                            String unitValue = productController
                                .unitValueController.text
                                .trim();
                            int productQuantity = 0;
                            if (productController.productStockController.text
                                .trim()
                                .isNotEmpty) {
                              productQuantity = int.parse(productController
                                  .productStockController.text
                                  .trim());
                            }
                            String? selectedDiscountType =
                                productController.selectedDiscountType;

                            if (productName.isEmpty) {
                              showCustomSnackBar('product_name_required'.tr);
                            } else if (categoryId == null) {
                              showCustomSnackBar('please_select_a_category'.tr);
                            } else if (Get.find<UnitController>().unitIndex ==
                                0) {
                              showCustomSnackBar('please_select_unit'.tr);
                            } else if (unitValue.isEmpty) {
                              showCustomSnackBar('unit_value_required'.tr);
                            } else if (productCode.isEmpty) {
                              showCustomSnackBar('sku_required'.tr);
                            } else if (productQuantity < 1) {
                              showCustomSnackBar('stock_quantity_required'.tr);
                            } else if (sellingPrice.isEmpty) {
                              showCustomSnackBar('selling_price_required'.tr);
                            } else if (purchasePrice.isEmpty) {
                              showCustomSnackBar('purchase_price_required'.tr);
                            } else if (discount.isEmpty) {
                              showCustomSnackBar('discount_price_required'.tr);
                            } else if (tax.isEmpty) {
                              showCustomSnackBar('tax_price_required'.tr);
                            } else {
                              Products product = Products(
                                  id: update ? widget.product!.id : null,
                                  title: productName,
                                  sellingPrice: double.parse(sellingPrice),
                                  purchasePrice: double.parse(purchasePrice),
                                  tax: double.parse(tax),
                                  discount: double.parse(discount),
                                  discountType: selectedDiscountType,
                                  unitType: int.parse(unitId),
                                  productCode: productCode,
                                  quantity: productQuantity,
                                  unitValue: unitValue);
                              productController.addProduct(product, categoryId,
                                  subCategoryId, brandId, supplierId, update);
                            }
                          },
                        ),
                      );
                    })
                  ],
                ),
        );
      }),
    );
  }
}
