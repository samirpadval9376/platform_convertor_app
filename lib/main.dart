import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:platform_convertor_app/controllers/contact_controlller.dart';
import 'package:platform_convertor_app/controllers/date_time_controller.dart';
import 'package:platform_convertor_app/controllers/platform_controller.dart';
import 'package:platform_convertor_app/controllers/profile_controller.dart';
import 'package:platform_convertor_app/controllers/theme_controller.dart';
import 'package:platform_convertor_app/utils/my_page_routes_utils.dart';
import 'package:platform_convertor_app/views/screens/home_page.dart';
import 'package:platform_convertor_app/views/screens/ios_home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => PlatformController(),
          ),
          ChangeNotifierProvider(
            create: (context) => ProfileController(),
          ),
          ChangeNotifierProvider(
            create: (context) => ThemeController(prefs: prefs),
          ),
          ChangeNotifierProvider(
            create: (context) => ContactController(preferences: prefs),
          ),
          ChangeNotifierProvider(
            create: (context) => DateTimeController(preferences: prefs),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Provider.of<PlatformController>(context).isAndroid)
        ? CupertinoApp(
            debugShowCheckedModeBanner: false,
            builder: DevicePreview.appBuilder,
            locale: DevicePreview.locale(context),
            theme: CupertinoThemeData(
              brightness: Provider.of<ThemeController>(context).isDark
                  ? Brightness.dark
                  : Brightness.light,
            ),
            routes: {
              MyPageRoute.home: (context) => IosHomePage(),
            },
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            builder: DevicePreview.appBuilder,
            locale: DevicePreview.locale(context),
            themeMode: Provider.of<ThemeController>(context).getTheme
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.blue,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
            ),
            routes: {
              MyPageRoute.home: (context) => HomePage(),
            },
          );
  }
}
