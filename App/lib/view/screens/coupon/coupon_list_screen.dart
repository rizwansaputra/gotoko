import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/coupon_controller.dart';
import 'package:gotoko/util/color_resources.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/view/base/custom_app_bar.dart';
import 'package:gotoko/view/base/custom_drawer.dart';
import 'package:gotoko/view/base/custom_header.dart';
import 'package:gotoko/view/screens/coupon/add_coupon_screen.dart';
import 'package:gotoko/view/screens/coupon/widget/coupon_list_view.dart';

class CouponListScreen extends StatefulWidget {
  const CouponListScreen({Key? key}) : super(key: key);

  @override
  State<CouponListScreen> createState() => _CouponListScreenState();
}

class _CouponListScreenState extends State<CouponListScreen> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  @override
  initState() {
    super.initState();
    Get.find<CouponController>().getCouponListData(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
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
                    CustomHeader(
                        title: 'coupon_list'.tr,
                        headerImage: Images.categories),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    CouponListView(scrollController: _scrollController),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: ColorResources.whiteColor,
        child: Image.asset(Images.addNewCategory),
        onPressed: () => Get.to(() => const AddCouponScreen()),
      ),
    );
  }
}
