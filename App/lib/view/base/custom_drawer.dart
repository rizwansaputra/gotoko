import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/menu_controller.dart';
import 'package:gotoko/controller/splash_controller.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_category_button.dart';
import 'package:gotoko/view/base/sign_out_confirmation_dialog.dart';
import 'package:gotoko/view/screens/account_management/account_mangement_screen.dart';
import 'package:gotoko/view/screens/dashboard/nav_bar_screen.dart';
import 'package:gotoko/view/screens/langulage/change_language.dart';
import 'package:gotoko/view/screens/product_setup_screen/product_setup_menu_screen.dart';
import 'package:gotoko/view/screens/order/order_screen.dart';
import 'package:gotoko/view/screens/shop/shop_settings.dart';
import 'package:gotoko/view/screens/user/user_screen.dart';

import 'animated_custom_dialog.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      color: Theme.of(context).cardColor,
      child: GetBuilder<SplashController>(builder: (configController) {
        return Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).primaryColor,
            height: 200,
            child: Column(children: [
              SizedBox(height: MediaQuery.of(context).viewPadding.top),
              SizedBox(
                width: 80,
                height: 80,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: FadeInImage.assetNetwork(
                      placeholder: Images.placeholder,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                      image:
                          '${configController.baseUrls!.adminImageUrl}/${configController.profileModel != null ? configController.profileModel!.image ?? '' : ''}',
                      imageErrorBuilder: (c, o, s) => Image.asset(
                        Images.placeholder,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                '${configController.profileModel!.fName} ${configController.profileModel!.lName}'
                    .tr,
                style: fontSizeRegular.copyWith(
                  color: Theme.of(context).cardColor,
                  fontSize: Dimensions.fontSizeExtraLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  '${configController.profileModel!.email}',
                  style: fontSizeRegular.copyWith(
                    color: Theme.of(context).cardColor,
                    fontSize: Dimensions.fontSizeSmall,
                  ),
                ),
              ),
            ]),
          ),
          Expanded(
            child: ListView(padding: EdgeInsets.zero, children: [
              CustomCategoryButton(
                icon: Images.dashboard,
                buttonText: 'dashboard'.tr,
                onTap: () {
                  Get.back();
                  Get.to(() => const NavBarScreen());
                  Get.find<BottomMenuController>().selectHomePage();
                },
              ),
              Divider(height: 3, color: Theme.of(context).cardColor),
              CustomCategoryButton(
                icon: Images.pos,
                buttonText: 'pos_section'.tr,
                onTap: () {
                  Get.back();
                  Get.to(() => const NavBarScreen());
                  Get.find<BottomMenuController>().selectPosScreen();
                },
              ),
              Divider(height: 3, color: Theme.of(context).cardColor),
              CustomCategoryButton(
                icon: Images.productSetup,
                buttonText: 'product_setup'.tr,
                onTap: () => Get.to(
                    () => const ProductSetupMenuScreen(isFromDrawer: true)),
              ),
              Divider(height: 3, color: Theme.of(context).cardColor),
              CustomCategoryButton(
                icon: Images.item,
                buttonText: 'orders'.tr,
                onTap: () => Get.to(() => const OrderScreen(fromNavBar: false)),
              ),
              Divider(height: 3, color: Theme.of(context).cardColor),
              CustomCategoryButton(
                icon: Images.accountManagement,
                buttonText: 'accounts_management'.tr,
                onTap: () => Get.to(() => const AccountManagementScreen()),
              ),
              Divider(height: 3, color: Theme.of(context).cardColor),
              CustomCategoryButton(
                icon: Images.profilePlaceHolder,
                buttonText: 'users'.tr,
                onTap: () => Get.to(() => const UserScreen()),
              ),
              Divider(height: 3, color: Theme.of(context).cardColor),
              CustomCategoryButton(
                icon: Images.shopIcon,
                buttonText: 'shop_settings'.tr,
                onTap: () => Get.to(() => const ShopSettings()),
              ),
              Divider(height: 3, color: Theme.of(context).cardColor),
              CustomCategoryButton(
                icon: Images.languageLogo,
                buttonText: 'change_language'.tr,
                onTap: () => Get.to(() => const ChooseLanguageScreen()),
              ),
              CustomCategoryButton(
                  icon: Images.logout,
                  buttonText: 'log_out'.tr,
                  onTap: () => showAnimatedDialog(
                      context, const SignOutConfirmationDialog(),
                      isFlip: true)),
            ]),
          ),
        ]);
      }),
    );
  }
}
