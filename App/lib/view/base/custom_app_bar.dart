import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/cart_controller.dart';
import 'package:gotoko/controller/menu_controller.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_ink_well.dart';
import 'package:gotoko/view/screens/dashboard/nav_bar_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isBackButtonExist;
  const CustomAppBar({Key? key, this.isBackButtonExist = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).cardColor,
      titleSpacing: 0,
      elevation: 5,
      leadingWidth: isBackButtonExist ? 50 : 120,
      leading: isBackButtonExist
          ? Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeSmall),
              child: CustomInkWell(
                onTap: () => Get.back(),
                child: Icon(Icons.arrow_back_sharp,
                    color: Theme.of(context).primaryColor, size: 25),
              ),
            )
          : Padding(
              padding:
                  const EdgeInsets.only(left: Dimensions.fontSizeExtraSmall),
              child: InkWell(
                  onTap: () =>
                      Get.find<BottomMenuController>().selectHomePage(),
                  child:
                      Image.asset(Images.logoWithName, width: 120, height: 30)),
            ),
      title: const Text(''),
      actions: [
        GetBuilder<CartController>(builder: (cartController) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              onPressed: () {
                Get.to(const NavBarScreen());
                Get.find<BottomMenuController>().selectPosScreen();
              },
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    Images.cart,
                    height: Dimensions.iconSizeDefault,
                    width: Dimensions.iconSizeDefault,
                    color: Theme.of(context).primaryColor,
                  ),
                  Positioned(
                    top: -4,
                    right: -4,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: Theme.of(context).secondaryHeaderColor,
                      child: Text(
                          '${cartController.customerCartList.isNotEmpty ? cartController.customerCartList[cartController.customerIndex].cart!.length : 0}',
                          style: fontSizeRegular.copyWith(
                              color: Theme.of(context).cardColor,
                              fontSize: Dimensions.fontSizeSmall)),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        Builder(builder: (context) {
          return IconButton(
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            icon: Icon(Icons.menu_outlined,
                color: Theme.of(context).primaryColor),
          );
        }),
      ],
    );
  }

  @override
  Size get preferredSize =>
      Size(Dimensions.webMaxWidth, GetPlatform.isDesktop ? 70 : 50);
}
