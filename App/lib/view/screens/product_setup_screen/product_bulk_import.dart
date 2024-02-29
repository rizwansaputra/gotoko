import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gotoko/controller/product_controller.dart';
import 'package:gotoko/util/color_resources.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_app_bar.dart';
import 'package:gotoko/view/base/custom_button.dart';
import 'package:gotoko/view/base/custom_drawer.dart';
import 'package:gotoko/view/base/custom_header.dart';
import 'package:gotoko/view/base/custom_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductBulkImport extends StatefulWidget {
  const ProductBulkImport({Key? key}) : super(key: key);

  @override
  State<ProductBulkImport> createState() => _ProductBulkImportState();
}

class _ProductBulkImportState extends State<ProductBulkImport> {
  final ReceivePort _port = ReceivePort();
  final List<String> fileExtensions = ['xlsx', 'xlsm', 'xlsb', 'xltx'];

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      setState(() {});
    });

    FlutterDownloader.registerCallback(
        (id, status, progress) => downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(),
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          CustomHeader(title: 'bulk_import'.tr, headerImage: Images.import),
          GetBuilder<ProductController>(builder: (importController) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault,
                      vertical: Dimensions.paddingSizeSmall),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('instructions'.tr,
                          style: fontSizeBold.copyWith(
                              fontSize: Dimensions.fontSizeExtraLarge)),
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      Text('instructions_details'.tr),
                      const SizedBox(
                        height: Dimensions.paddingSizeLarge,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: Dimensions.iconSizeSmall,
                              child: Image.asset(Images.import)),
                          const SizedBox(width: Dimensions.iconSizeSmall),
                          Text('import'.tr,
                              style: fontSizeBold.copyWith(
                                  fontSize: Dimensions.fontSizeLarge,
                                  color: ColorResources.getTitleColor())),
                          const Spacer(),
                          InkWell(
                            onTap: () async {
                              final status = await Permission.storage.request();
                              if (status.isGranted) {
                                importController
                                    .getSampleFile()
                                    .then((value) async {
                                  _launchUrl(Uri.parse(
                                      '${importController.bulkImportSampleFilePath}'));
                                });
                              }
                            },
                            child: Row(
                              children: [
                                Text('download_format'.tr,
                                    style: fontSizeRegular.copyWith(
                                        color: ColorResources.downloadFormat)),
                                const SizedBox(
                                    width: Dimensions.paddingSizeSmall),
                                SizedBox(
                                    width: Dimensions.iconSizeSmall,
                                    child: Image.asset(Images.downloadFormat)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                InkWell(
                  onTap: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: fileExtensions,
                    );
                    if (result != null) {
                      File file = File(result.files.single.path!);
                      importController.setSelectedFileName(file);
                    } else {}
                  },
                  child: Builder(builder: (context) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 100, child: Image.asset(Images.upload)),
                        importController.selectedFileForImport != null
                            ? Text(
                                basename(importController
                                    .selectedFileForImport!.path),
                                style: fontSizeRegular.copyWith(
                                    color: ColorResources.downloadFormat
                                        .withOpacity(.5)),
                              )
                            : Text('upload_file'.tr,
                                style: fontSizeRegular.copyWith(
                                  color: ColorResources.downloadFormat
                                      .withOpacity(.5),
                                )),
                      ],
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault,
                    vertical: Dimensions.paddingSizeLarge,
                  ),
                  child: CustomButton(
                      buttonText: 'submit'.tr,
                      onPressed: () async {
                        if (importController.selectedFileForImport != null) {
                          if (importController.checkFileExtension(
                              fileExtensions,
                              importController.selectedFileForImport!.path)) {
                            importController.bulkImportFile();
                          } else {
                            showCustomSnackBar('please_submit_correct_file'.tr);
                          }
                        } else {
                          showCustomSnackBar('select_file_first'.tr);
                        }
                      }),
                ),
              ],
            );
          })
        ],
      ),
    );
  }
}

Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}
