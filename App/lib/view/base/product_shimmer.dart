import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:gotoko/util/color_resources.dart';
import 'package:gotoko/util/dimensions.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: (1 / 1.5),
      ),
      itemCount: 12,
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).highlightColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5)
            ],
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            enabled: true,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Product Image
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorResources.getIconBg(),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                    ),
                  ),

                  // Product Details
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: 20, color: Colors.white),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall),
                          Row(children: [
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: 20,
                                        width: 50,
                                        color: Colors.white),
                                  ]),
                            ),
                            Container(
                                height: 10, width: 50, color: Colors.white),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        );
      },
    );
  }
}
