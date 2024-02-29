import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:maswend_pos_printer_platform/maswend_pos_printer_platform.dart';
import 'package:get/get.dart';
import 'package:gotoko/data/model/response/config_model.dart';
import 'package:gotoko/data/model/response/invoice_model.dart';
import 'package:gotoko/helper/date_converter.dart';
import 'package:gotoko/view/base/custom_app_bar.dart';
import 'package:gotoko/view/base/custom_drawer.dart';
import 'package:gotoko/view/base/no_data_screen.dart';
import 'package:maswend_bt_printer/maswend_bt_printer.dart';
import 'package:gotoko/format_rupiah.dart';

class InVoicePrintScreen extends StatefulWidget {
  final Invoice? invoice;
  final ConfigModel? configModel;
  final int? orderId;
  final double? discountProduct;
  final double? total;
  const InVoicePrintScreen(
      {Key? key,
      this.invoice,
      this.configModel,
      this.orderId,
      this.discountProduct,
      this.total})
      : super(key: key);

  @override
  State<InVoicePrintScreen> createState() => _InVoicePrintScreenState();
}

class _InVoicePrintScreenState extends State<InVoicePrintScreen> {
  var defaultPrinterType = PrinterType.bluetooth;
  final _isBle = false;
  var printerManager = PrinterManager.instance;
  StreamSubscription<PrinterDevice>? _subscription;
  StreamSubscription<BTStatus>? _subscriptionBtStatus;
  final BTStatus _currentStatus = BTStatus.none;
  List<int>? pendingTask;
  final String _ipAddress = '';
  final String _port = '9100';
  final _ipController = TextEditingController();
  final _portController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getBluetooth();
  }

  bool connected = false;
  List availableBluetoothDevices = [];

  Future<void> getBluetooth() async {
    final List? bluetooths = await MaswendBTPrinter.getBluetooths;
    print("Print $bluetooths");
    setState(() {
      availableBluetoothDevices = bluetooths!;
    });
  }

  Future<void> setConnect(String mac) async {
    final String? result = await MaswendBTPrinter.connect(mac);
    print("state conneected $result");
    if (result == "true") {
      setState(() {
        connected = true;
      });
    }
  }

  Future<void> printTicket(List<int> bytes, Generator generator) async {
    String? isConnected = await MaswendBTPrinter.connectionStatus;
    if (isConnected == "true") {
      bytes += generator.cut();
      final result = await MaswendBTPrinter.writeBytes(bytes);
      print("Print $result");
    } else {
      //Hadnle Not Connected Senario
    }
  }

  Future _printReceiveTest() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];
    bytes += generator.text('${widget.configModel!.businessInfo!.shopName}',
        styles: const PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1);

    bytes += generator.text('Kasir : Admin',
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text('${widget.configModel!.businessInfo!.shopAddress}',
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text(
        'Kontak: ${widget.configModel!.businessInfo!.shopPhone}',
        styles: const PosStyles(align: PosAlign.center),
        linesAfter: 1);
    bytes += generator.text(
        'No Faktur: ${'invoice'.tr.toUpperCase()}#${widget.orderId}',
        styles: const PosStyles(align: PosAlign.left),
        linesAfter: 1);

    bytes += generator.row([
      PosColumn(
          text: 'sl'.tr.toUpperCase(),
          width: 2,
          styles: const PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: 'product_info'.tr,
          width: 6,
          styles: const PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: 'qty'.tr,
          width: 1,
          styles: const PosStyles(align: PosAlign.center, bold: true)),
      PosColumn(
          text: 'price'.tr,
          width: 3,
          styles: const PosStyles(align: PosAlign.right, bold: true)),
    ]);
    bytes += generator.hr();
    for (int i = 0; i < widget.invoice!.details!.length; i++) {
      bytes += generator.row([
        PosColumn(
          text: '${i + 1}',
          width: 2,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text:
              '${jsonDecode(widget.invoice!.details![i].productDetails!)['name']}',
          width: 6,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: widget.invoice!.details![i].quantity.toString(),
          width: 1,
          styles: const PosStyles(align: PosAlign.right),
        ),
        PosColumn(
          /* text: CurrencyFormat.formatrupiah(
              widget.invoice!.details![i].price!.toDouble(), 0),*/
          text: CurrencyFormat.formatrupiah(
              widget.invoice!.details![i].price!.toDouble() *
                  widget.invoice!.details![i].quantity!.toDouble(),
              0),
          width: 3,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
    }

    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(
          text: 'subtotal'.tr,
          width: 8,
          styles: const PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: CurrencyFormat.convertToIdr(
              widget.invoice!.orderAmount!.toDouble(), 0),
          width: 4,
          styles: const PosStyles(
            align: PosAlign.right,
          )),
    ]);
    bytes += generator.row([
      PosColumn(
          text: 'product_discount'.tr,
          width: 8,
          styles: const PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: CurrencyFormat.convertToIdr(
              widget.discountProduct!.toDouble(), 0),
          width: 4,
          styles: const PosStyles(
            align: PosAlign.right,
          )),
    ]);
    bytes += generator.row([
      PosColumn(
          text: 'coupon_discount'.tr,
          width: 8,
          styles: const PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: CurrencyFormat.convertToIdr(
              widget.invoice!.couponDiscountAmount!.toDouble(), 0),
          width: 4,
          styles: const PosStyles(
            align: PosAlign.right,
          )),
    ]);
    bytes += generator.row([
      PosColumn(
          text: 'extra_discount'.tr,
          width: 8,
          styles: const PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: CurrencyFormat.convertToIdr(
              widget.invoice!.extraDiscount!.toDouble(), 0),
          width: 4,
          styles: const PosStyles(
            align: PosAlign.right,
          )),
    ]);
    bytes += generator.row([
      PosColumn(
          text: 'tax'.tr,
          width: 8,
          styles: const PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: CurrencyFormat.convertToIdr(
              widget.invoice!.totalTax!.toDouble(), 0),
          width: 4,
          styles: const PosStyles(
            align: PosAlign.right,
          )),
    ]);
    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(
          text: 'total'.tr,
          width: 8,
          styles: const PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: CurrencyFormat.convertToIdr(
              widget.total! - widget.discountProduct!, 0),
          width: 4,
          styles: const PosStyles(align: PosAlign.right, bold: true)),
    ]);

    bytes += generator.row([
      PosColumn(
          text: 'Metode:',
          width: 8,
          styles: const PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: 'Tunai',
          width: 4,
          styles: const PosStyles(
            align: PosAlign.right,
          )),
    ]);
    bytes += generator.row([
      PosColumn(
          text: 'paidcash'.tr,
          width: 8,
          styles: const PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: CurrencyFormat.convertToIdr(widget.invoice!.collectedCash!, 0),
          width: 4,
          styles: const PosStyles(
            align: PosAlign.right,
          )),
    ]);
    bytes += generator.row([
      PosColumn(
          text: 'change'.tr,
          width: 8,
          styles: const PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: CurrencyFormat.convertToIdr(
              widget.invoice!.collectedCash! -
                  widget.total! -
                  widget.discountProduct!,
              0),
          width: 4,
          styles: const PosStyles(
            align: PosAlign.right,
          )),
    ]);

    bytes += generator.hr(ch: '=', linesAfter: 1);

    // ticket.feed(2);
    bytes += generator.text('terms_and_condition'.tr,
        styles: const PosStyles(align: PosAlign.center, bold: true));

    bytes += generator.text('terms_and_condition_details'.tr,
        styles: const PosStyles(align: PosAlign.center), linesAfter: 1);

    bytes += generator.text(
        DateConverter.dateTimeStringToMonthAndTime(widget.invoice!.createdAt!),
        styles: const PosStyles(align: PosAlign.center),
        linesAfter: 1);

    bytes += generator.text('Developed By: Maswend',
        styles: const PosStyles(align: PosAlign.center), linesAfter: 1);

    printTicket(bytes, generator);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Cetak Struk Faktur'),
        ),
        body: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Cari Bluetooth Yang Terhubung"),
              TextButton(
                onPressed: () {
                  getBluetooth();
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.all(8.0),
                  textStyle: const TextStyle(fontSize: 13),
                ),
                child: const Text("Cari"),
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: availableBluetoothDevices.isNotEmpty
                      ? availableBluetoothDevices.length
                      : 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        String select = availableBluetoothDevices[index];
                        List list = select.split("#");
                        // String name = list[0];
                        String mac = list[1];
                        setConnect(mac);
                      },
                      title: Text('${availableBluetoothDevices[index]}'),
                      subtitle: const Text("Klik Untuk Sambungkan"),
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 200,
                height: 30,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  alignment: Alignment.center,
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(8.0),
                  textStyle: const TextStyle(fontSize: 13),
                ),
                onPressed: connected ? _printReceiveTest : null,
                child: const Text("CETAK FAKTUR"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
