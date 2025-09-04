import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pmis_flutter/utils/theme_util.dart';
import 'data/db/models/asset_collection.dart';
import 'data/local/constants.dart';
import 'data/local/strings.dart';
import 'data/remote/api_provider.dart';
import 'ui/features/splash/splash_screen.dart';

void main() async {

  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter<AssetCollection>(AssetCollectionAdapter());
  await Hive.openBox<AssetCollection>('image');

/*  // init the hive
  await Hive.initFlutter();

  // open a box
  var box = await Hive.openBox('mybox');*/

  await GetStorage.init();
  _setDefaultValues();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
  gIsDarkMode = ThemeService().loadThemeFromBox();
  Get.put(APIProvider());
}

void _setDefaultValues() {
  GetStorage().writeIfNull(PreferenceKey.darkMode, false);
  GetStorage().writeIfNull(PreferenceKey.isLoggedIn, false);
  GetStorage().writeIfNull(PreferenceKey.languageKey, DefaultValue.languageKey);
  GetStorage().writeIfNull(PreferenceKey.fiscalYearId, "");
  GetStorage().writeIfNull(PreferenceKey.developmentPlanTypeId, "");
  GetStorage().writeIfNull(PreferenceKey.TagComeFrom, "");
  //GetStorage().writeIfNull(PreferenceKey.TagRoleName, "");
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentKey = GetStorage().read(PreferenceKey.languageKey);
    Locale language = Locale(currentKey);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      // theme: lightTheme,
      // darkTheme: darkTheme,
      // themeMode: currentTheme.currentTheme(),
      translations: Strings(),
      locale: language,
      fallbackLocale: const Locale(DefaultValue.languageKey),
      initialRoute: "/",
      // localizationsDelegates: const [
      //   CountryLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      home: const SplashScreen(),
      // home: UpgradeAlert(
      //     upgrader: Upgrader(
      //         durationUntilAlertAgain: const Duration(days: 1),
      //         minAppVersion: '1.0.1',
      //         shouldPopScope: () => true,
      //         dialogStyle: Platform.isIOS
      //             ? UpgradeDialogStyle.cupertino
      //             : UpgradeDialogStyle.material),
      //     child: const SplashScreen()),
    );
  }
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
