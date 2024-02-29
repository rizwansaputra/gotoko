import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/unit_controller.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/view/base/custom_app_bar.dart';
import 'package:gotoko/view/base/custom_drawer.dart';
import 'package:gotoko/view/base/custom_header.dart';
import 'package:gotoko/view/screens/unit/widget/add_new_unit_screen.dart';
import 'package:gotoko/view/screens/unit/widget/unit_list_view.dart';

class UnitListViewScreen extends StatefulWidget {
  const UnitListViewScreen({Key? key}) : super(key: key);

  @override
  State<UnitListViewScreen> createState() => _UnitListViewScreenState();
}

class _UnitListViewScreenState extends State<UnitListViewScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.find<UnitController>().getUnitList(1);
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
                        title: 'unit_list'.tr, headerImage: Images.categories),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    UnitListView(
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
          Get.to(const AddNewUnit());
        },
        child: Image.asset(Images.addCategoryIcon),
      ),
    );
  }
}
