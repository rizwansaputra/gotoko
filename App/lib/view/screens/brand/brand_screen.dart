import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/brand_controller.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/view/base/custom_app_bar.dart';
import 'package:gotoko/view/base/custom_drawer.dart';
import 'package:gotoko/view/base/custom_header.dart';
import 'package:gotoko/view/screens/brand/widget/add_new_brand_screen.dart';
import 'package:gotoko/view/screens/brand/widget/brand_list_view.dart';

class BrandListViewScreen extends StatefulWidget {
  const BrandListViewScreen({Key? key}) : super(key: key);

  @override
  State<BrandListViewScreen> createState() => _BrandListViewScreenState();
}

class _BrandListViewScreenState extends State<BrandListViewScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.find<BrandController>().getBrandList(1, reload: true);
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
                        title: 'brand_list'.tr, headerImage: Images.brand),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    BrandListView(
                      scrollController: _scrollController,
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Get.to(const AddNewBrand());
        },
        child: Image.asset(Images.addCategoryIcon),
      ),
    );
  }
}
