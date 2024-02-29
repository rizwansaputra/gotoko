import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/unit_controller.dart';
import 'package:gotoko/view/base/no_data_screen.dart';
import 'package:gotoko/view/screens/unit/widget/unit_card_widget.dart';

class UnitListView extends StatelessWidget {
  final ScrollController? scrollController;
  const UnitListView({Key? key, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    scrollController?.addListener(() {
      if (scrollController!.position.maxScrollExtent ==
              scrollController!.position.pixels &&
          Get.find<UnitController>().unitList != null &&
          Get.find<UnitController>().unitList!.isNotEmpty &&
          !Get.find<UnitController>().isLoading) {
        int? pageSize;
        pageSize = Get.find<UnitController>().unitListLength;

        if (offset < pageSize!) {
          offset++;
          Get.find<UnitController>().showBottomLoader();
          Get.find<UnitController>().getUnitList(offset);
        }
      }
    });

    return GetBuilder<UnitController>(
      builder: (unitController) {
        return Column(children: [
          unitController.unitList == null
              ? const CircularProgressIndicator()
              : unitController.unitList!.isEmpty
                  ? const NoDataScreen()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: unitController.unitList!.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return UnitCardWidget(
                            unit: unitController.unitList![index]);
                      }),
        ]);
      },
    );
  }
}
