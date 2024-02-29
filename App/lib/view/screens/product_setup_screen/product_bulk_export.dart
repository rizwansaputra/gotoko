import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/product_controller.dart';
import 'package:gotoko/util/app_constants.dart';
import 'package:gotoko/util/color_resources.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_app_bar.dart';
import 'package:gotoko/view/base/custom_button.dart';
import 'package:gotoko/view/base/custom_drawer.dart';
import 'package:gotoko/view/base/custom_header.dart';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductBulkExport extends StatefulWidget {
  const ProductBulkExport({Key? key}) : super(key: key);

  @override
  State<ProductBulkExport> createState() => _ProductBulkExportState();
}

class _ProductBulkExportState extends State<ProductBulkExport> {
  final ReceivePort _port = ReceivePort();

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
      body: GetBuilder<ProductController>(builder: (exportController) {
        return Column(
          children: [
            CustomHeader(title: 'bulk_export'.tr, headerImage: Images.import),
            InkWell(
              onTap: () async {
                _launchUrl(Uri.parse(
                    '${AppConstants.baseUrl}${AppConstants.bulkExportProductUri}'));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 100, child: Image.asset(Images.download)),
                  Text(
                    'click_download_button'.tr,
                    textAlign: TextAlign.center,
                    style: fontSizeRegular.copyWith(
                        color: ColorResources.downloadFormat.withOpacity(.5)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault,
                  vertical: Dimensions.paddingSizeLarge),
              child: CustomButton(
                buttonText: 'download'.tr,
                onPressed: () async {
                  _launchUrl(Uri.parse(
                      '${AppConstants.baseUrl}${AppConstants.bulkExportProductUri}'));
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}

Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}
