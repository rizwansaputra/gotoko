import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/account_controller.dart';
import 'package:gotoko/controller/menu_controller.dart';
import 'package:gotoko/controller/product_controller.dart';
import 'package:gotoko/util/color_resources.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_drawer.dart';
import 'package:gotoko/view/base/title_row.dart';
import 'package:gotoko/view/screens/account_management/account_list_screen.dart';
import 'package:gotoko/view/screens/account_management/widget/account_list_view.dart';
import 'package:gotoko/view/screens/home/widget/revenue_statistics.dart';
import 'package:gotoko/view/screens/home/widget/transaction_chart.dart';
import 'package:gotoko/view/screens/product/widget/limited_product_list_view.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? maxYExpense = 0, maxYIncome = 0;
  double intervalRateExpense = 0, intervalRateIncome = 0;
  double spaceRateExpense = 0, spaceRateIncome = 0;
  bool permGranted = true;
  @override
  void initState() {
    Perizinan();
    super.initState();
  }

  // ignore: non_constant_identifier_names
  void Perizinan() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      permGranted = false;
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.bluetoothScan,
        Permission.bluetoothAdvertise,
        Permission.bluetoothConnect
      ].request();
      if (statuses[Permission.location]!.isGranted &&
          statuses[Permission.bluetoothScan]!.isGranted &&
          statuses[Permission.bluetoothAdvertise]!.isGranted &&
          statuses[Permission.bluetoothConnect]!.isGranted) {
        permGranted = true;
      } //check each permission status after.
    }
  }

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(.03),
      resizeToAvoidBottomInset: false,
      endDrawer: const CustomDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          color: Theme.of(context).cardColor,
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {},
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const RevenueStatistics(),
                    GetBuilder<AccountController>(builder: (chartController) {
                      if (chartController.yearWiseExpenseList.isNotEmpty) {
                        maxYExpense = chartController
                            .yearWiseExpenseList[
                                chartController.yearWiseExpenseList.length - 1]
                            .totalAmount;
                        intervalRateExpense = maxYExpense!.ceil() / 5;

                        maxYIncome = chartController
                            .yearWiseIncomeList[
                                chartController.yearWiseIncomeList.length - 1]
                            .totalAmount;
                        intervalRateIncome = maxYIncome!.ceil() / 5;
                      }

                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: TransactionChart(
                          maxYExpense: intervalRateExpense,
                          maxYIncome: intervalRateIncome,
                        ),
                      );
                    }),
                    GetBuilder<AccountController>(builder: (account) {
                      return account.accountList.isNotEmpty
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: Dimensions.paddingSizeSmall),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          Dimensions.paddingSizeDefault,
                                          Dimensions.paddingSizeDefault,
                                          Dimensions.paddingSizeDefault,
                                          Dimensions.paddingSizeDefault),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                              width: Dimensions.iconSizeSmall,
                                              child: Image.asset(
                                                  Images.myAccount)),
                                          const SizedBox(
                                              width:
                                                  Dimensions.paddingSizeSmall),
                                          Expanded(
                                              child: TitleRow(
                                            title: 'my_account'.tr,
                                            onTap: () {
                                              Get.to(const AccountListScreen(
                                                  fromAccount: true));
                                            },
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: Dimensions.paddingSizeDefault,
                                    bottom: Dimensions.paddingSizeSmall,
                                    right: Dimensions.paddingSizeDefault,
                                  ),
                                  child: Row(
                                    children: [
                                      const Text('#'),
                                      const SizedBox(
                                          width: Dimensions.paddingSizeLarge),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            'account'.tr,
                                            style: fontSizeMedium.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeLarge,
                                                color: ColorResources
                                                    .getTitleColor()),
                                          )),
                                      Text(
                                        'balance'.tr,
                                        style: fontSizeMedium.copyWith(
                                            fontSize: Dimensions.fontSizeLarge,
                                            color:
                                                ColorResources.getTitleColor()),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    padding: const EdgeInsets.only(
                                        top: Dimensions.paddingSizeSmall,
                                        bottom: Dimensions.paddingSizeSmall),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor),
                                    child: AccountListView(
                                        scrollController: _scrollController,
                                        isHome: true)),
                              ],
                            )
                          : const SizedBox();
                    }),
                    GetBuilder<ProductController>(builder: (stockOutProduct) {
                      return stockOutProduct.limitedStockProductList.isNotEmpty
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: Dimensions.paddingSizeSmall),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          Dimensions.paddingSizeDefault,
                                          Dimensions.paddingSizeDefault,
                                          Dimensions.paddingSizeDefault,
                                          Dimensions.paddingSizeDefault),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                              width: Dimensions.iconSizeSmall,
                                              child: Image.asset(
                                                  Images.limitedStock)),
                                          const SizedBox(
                                              width:
                                                  Dimensions.paddingSizeSmall),
                                          Expanded(
                                              child: TitleRow(
                                            title: 'limited_stocks'.tr,
                                            onTap: () {
                                              Get.find<BottomMenuController>()
                                                  .selectStockOutProductList();
                                            },
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: Dimensions.paddingSizeDefault,
                                      bottom: Dimensions.paddingSizeSmall,
                                      right: Dimensions.paddingSizeDefault),
                                  child: Row(
                                    children: [
                                      const Text('#'),
                                      const SizedBox(
                                          width: Dimensions.paddingSizeLarge),
                                      Expanded(
                                          flex: 9,
                                          child: Text(
                                            'product_name'.tr,
                                            style: fontSizeMedium.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeLarge,
                                                color: ColorResources
                                                    .getTitleColor()),
                                          )),
                                      Text(
                                        'qty'.tr,
                                        style: fontSizeMedium.copyWith(
                                            fontSize: Dimensions.fontSizeLarge,
                                            color:
                                                ColorResources.getTitleColor()),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    padding: const EdgeInsets.only(
                                        top: Dimensions.paddingSizeSmall,
                                        bottom:
                                            Dimensions.paddingSizeExtraLarge),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor),
                                    child: LimitedStockProductListView(
                                        scrollController: _scrollController,
                                        isHome: true)),
                              ],
                            )
                          : const SizedBox();
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 70 ||
        oldDelegate.minExtent != 70 ||
        child != oldDelegate.child;
  }
}
