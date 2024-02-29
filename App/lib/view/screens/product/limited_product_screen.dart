import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/product_controller.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/view/base/custom_header.dart';
import 'package:gotoko/view/base/secondary_header_view.dart';
import 'package:gotoko/view/screens/product/widget/limited_product_list_view.dart';

class LimitedStockProductScreen extends StatefulWidget {
  const LimitedStockProductScreen({Key? key}) : super(key: key);

  @override
  State<LimitedStockProductScreen> createState() =>
      _LimitedStockProductScreenState();
}

class _LimitedStockProductScreenState extends State<LimitedStockProductScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          color: Theme.of(context).cardColor,
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            Get.find<ProductController>()
                .getLimitedStockProductList(1, reload: true);
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(children: [
                  CustomHeader(
                      title: 'product_list'.tr, headerImage: Images.peopleIcon),
                  const SizedBox(height: Dimensions.paddingSizeBorder),
                  SecondaryHeaderView(key: UniqueKey(), isLimited: true),
                  LimitedStockProductListView(
                    scrollController: _scrollController,
                    isHome: false,
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
