import 'dart:async';
import 'dart:io';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:gotoko/controller/localization_controller.dart';
import 'package:gotoko/controller/theme_controller.dart';
import 'package:gotoko/helper/route_helper.dart';
import 'package:gotoko/theme/dark_theme.dart';
import 'package:gotoko/theme/light_theme.dart';
import 'package:gotoko/util/app_constants.dart';
import 'package:gotoko/util/messages.dart';
import 'package:gotoko/view/screens/root/not_found_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'helper/get_di.dart' as di;

Future<void> main() async {
  if (GetPlatform.isIOS || GetPlatform.isAndroid) {
    HttpOverrides.global = MyHttpOverrides();
  }
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  Map<String, Map<String, String>> languages = await di.init();

  runApp(MyApp(languages: languages));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>>? languages;

  const MyApp({Key? key, required this.languages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetBuilder<LocalizationController>(
          builder: (localizeController) {
            return GetMaterialApp(
              title: AppConstants.appName,
              debugShowCheckedModeBanner: false,
              navigatorKey: Get.key,
              theme: themeController.darkTheme ? dark : light,
              locale: localizeController.locale,
              translations: Messages(languages: languages),
              fallbackLocale: Locale(AppConstants.languages[0].languageCode!,
                  AppConstants.languages[0].countryCode),
              initialRoute: RouteHelper.splash,
              getPages: RouteHelper.routes,
              unknownRoute:
                  GetPage(name: '/', page: () => const NotFoundScreen()),
              defaultTransition: Transition.topLevel,
              transitionDuration: const Duration(milliseconds: 500),
              builder: (ctx, widget) => MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                child: Material(child: widget!),
              ),
            );
          },
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
