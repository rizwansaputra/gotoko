import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/brand_controller.dart';
import 'package:gotoko/controller/splash_controller.dart';
import 'package:gotoko/data/model/response/brand_model.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/view/base/custom_app_bar.dart';
import 'package:gotoko/view/base/custom_button.dart';
import 'package:gotoko/view/base/custom_drawer.dart';
import 'package:gotoko/view/base/custom_header.dart';
import 'package:gotoko/view/base/custom_snackbar.dart';
import 'package:gotoko/view/base/custom_text_field.dart';
import 'package:gotoko/view/base/required_title.dart';

class AddNewBrand extends StatefulWidget {
  final Brands? brand;
  const AddNewBrand({Key? key, this.brand}) : super(key: key);

  @override
  State<AddNewBrand> createState() => _AddNewBrandState();
}

class _AddNewBrandState extends State<AddNewBrand> {
  final TextEditingController _brandController = TextEditingController();
  final FocusNode _brandFocusNode = FocusNode();

  late bool update;

  @override
  void initState() {
    super.initState();
    update = widget.brand != null;
    if (update) {
      _brandController.text = widget.brand!.name!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(),
      body: GetBuilder<BrandController>(builder: (brandController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(
              isBackButtonExist: true,
            ),
            const SizedBox(
              height: Dimensions.paddingSizeDefault,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomHeader(
                      title: update ? 'edit_brand'.tr : 'add_brand'.tr,
                      headerImage: Images.addNewCategory),
                  RequiredTitle(title: 'brand_name'.tr),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  CustomTextField(
                    controller: _brandController,
                    focusNode: _brandFocusNode,
                    hintText: 'brand_name_hint'.tr,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  RequiredTitle(title: 'brand_image'.tr),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Align(
                      alignment: Alignment.center,
                      child: Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                              Dimensions.paddingSizeSmall),
                          child: brandController.brandImage != null
                              ? Image.file(
                                  File(brandController.brandImage!.path),
                                  width: 150,
                                  height: 120,
                                  fit: BoxFit.cover,
                                )
                              : widget.brand != null
                                  ? FadeInImage.assetNetwork(
                                      placeholder: Images.placeholder,
                                      image:
                                          '${Get.find<SplashController>().baseUrls!.brandImageUrl}/${widget.brand!.image ?? ''}',
                                      height: 120,
                                      width: 150,
                                      fit: BoxFit.cover,
                                      imageErrorBuilder: (c, o, s) =>
                                          Image.asset(Images.placeholder,
                                              height: 120,
                                              width: 150,
                                              fit: BoxFit.cover),
                                    )
                                  : Image.asset(
                                      Images.placeholder,
                                      height: 120,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          top: 0,
                          left: 0,
                          child: InkWell(
                            onTap: () => brandController.pickImage(false),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(
                                    Dimensions.paddingSizeSmall),
                                border: Border.all(
                                    width: 1,
                                    color: Theme.of(context).primaryColor),
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(25),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.white),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.camera_alt,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ])),
                ],
              ),
            ),
            const SizedBox(
              height: Dimensions.paddingSizeLarge,
            ),
            brandController.isLoading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width / 2 - 30,
                            vertical: Dimensions.paddingSizeLarge),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(25)),
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
                    child: CustomButton(
                      buttonText: update ? 'update'.tr : 'save'.tr,
                      onPressed: () {
                        int? brandId = widget.brand?.id;
                        String brandName = _brandController.text.trim();
                        if (brandName.isEmpty) {
                          showCustomSnackBar('brand_name_is_required'.tr);
                        } else if (brandController.brandImage == null &&
                            !update) {
                          showCustomSnackBar('brand_image_is_required'.tr);
                        } else {
                          brandController.addBrand(brandName, brandId);
                        }
                      },
                    ),
                  ),
          ],
        );
      }),
    );
  }
}
