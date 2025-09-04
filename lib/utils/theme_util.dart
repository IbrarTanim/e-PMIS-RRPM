import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'colors.dart';
import 'dimens.dart';

// class Themes with ChangeNotifier {
//   bool isDark = false;
//
//   ThemeMode currentTheme() {
//     return isDark ? ThemeMode.dark : ThemeMode.light;
//   }
//
//   void switchTheme() {
//     isDark = !isDark;
//     notifyListeners();
//   }
//
//   void setThemeMode(bool isDarkMode) {
//     isDark = isDarkMode;
//     notifyListeners();
//   }
// }
//
// ThemeData lightTheme = ThemeData(
//     primaryColor: primary,
//     primaryColorDark: textColor,
//     primaryColorLight: grayDeep,
//     colorScheme: ThemeData.light().colorScheme.copyWith(secondary: accent),
//     backgroundColor: white,
//     scaffoldBackgroundColor: Colors.white,
//     secondaryHeaderColor: black,
//     // bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: kPrimaryColor, selectedItemColor: kAccentColor, unselectedItemColor: kGrayColor),
//
//     textTheme: TextTheme(
//       headline5: GoogleFonts.roboto(
//           color: primary, fontSize: dp22, fontWeight: FontWeight.normal),
//       headline6: GoogleFonts.roboto(
//           color: primary, fontSize: dp20, fontWeight: FontWeight.normal),
//       subtitle1: GoogleFonts.roboto(
//           color: primary, fontSize: dp18, fontWeight: FontWeight.normal),
//       bodyText1: GoogleFonts.roboto(
//           color: primary, fontSize: dp16, fontWeight: FontWeight.normal),
//       button: GoogleFonts.roboto(
//           color: textColor, fontSize: dp16, fontWeight: FontWeight.bold),
//     ));
//
// ThemeData darkTheme = ThemeData(
//     primaryColor: grayLight,
//     primaryColorDark: grayLight,
//     primaryColorLight: Colors.white,
//     colorScheme: ThemeData.dark().colorScheme.copyWith(secondary: textColor),
//     scaffoldBackgroundColor: grayLight,
//     backgroundColor: Colors.black,
//     secondaryHeaderColor: grayDeep,
//     textTheme: TextTheme(
//       headline5: GoogleFonts.roboto(
//           color: grayLight, fontSize: dp22, fontWeight: FontWeight.normal),
//       headline6: GoogleFonts.roboto(
//           color: grayLight, fontSize: dp20, fontWeight: FontWeight.normal),
//       subtitle1: GoogleFonts.roboto(
//           color: grayLight, fontSize: dp18, fontWeight: FontWeight.normal),
//       bodyText1: GoogleFonts.roboto(
//           color: grayLight, fontSize: dp16, fontWeight: FontWeight.normal),
//       button: GoogleFonts.roboto(
//           color: white, fontSize: dp16, fontWeight: FontWeight.bold),
//     ));

class Themes {
  static final light = ThemeData.light().copyWith(
      // primaryColor: primary,
      // primaryColorDark: textColor,
      // primaryColorLight: grayDeep,
      // scaffoldBackgroundColor: Colors.white,
      // secondaryHeaderColor: black,
      // textTheme: lightTextTheme,
      // colorScheme: ThemeData.light()
      //     .colorScheme
      //     .copyWith(secondary: accent)
      //     .copyWith(background: white));

  primaryColor: accentBlue,
  primaryColorDark: newTextColor,
  primaryColorLight: grayDeep,
  //backgroundColor: white,
  scaffoldBackgroundColor: Colors.white,
  secondaryHeaderColor: black,
  textTheme: lightTextTheme, colorScheme: ThemeData.light().colorScheme.copyWith(secondary: accent).copyWith(background: white));

  static final dark = ThemeData.dark().copyWith(
      primaryColor: grayLight,
      primaryColorDark: grayLight,
      primaryColorLight: Colors.white,
      scaffoldBackgroundColor: grayLight,
      //backgroundColor: Colors.black,
      secondaryHeaderColor: grayDeep,
      textTheme: darkTextTheme, colorScheme: ThemeData.dark().colorScheme.copyWith(secondary: newTextColor).copyWith(background: Colors.black));

  static final lightTextTheme = TextTheme(
    headlineSmall: GoogleFonts.roboto(
        color: primary, fontSize: dp22, fontWeight: FontWeight.normal),
    titleLarge: GoogleFonts.roboto(
        color: primary, fontSize: dp20, fontWeight: FontWeight.normal),
    titleMedium: GoogleFonts.roboto(
        color: primary, fontSize: dp18, fontWeight: FontWeight.normal),
    bodyLarge: GoogleFonts.roboto(
        color: primary, fontSize: dp16, fontWeight: FontWeight.normal),
    labelLarge: GoogleFonts.roboto(
        color: newTextColor, fontSize: dp16, fontWeight: FontWeight.bold),
  );

  static final darkTextTheme = TextTheme(
    headlineSmall: GoogleFonts.roboto(
        color: grayLight, fontSize: dp22, fontWeight: FontWeight.normal),
    titleLarge: GoogleFonts.roboto(
        color: grayLight, fontSize: dp20, fontWeight: FontWeight.normal),
    titleMedium: GoogleFonts.roboto(
        color: grayLight, fontSize: dp18, fontWeight: FontWeight.normal),
    bodyLarge: GoogleFonts.roboto(
        color: grayLight, fontSize: dp16, fontWeight: FontWeight.normal),
    labelLarge: GoogleFonts.roboto(
        color: white, fontSize: dp16, fontWeight: FontWeight.bold),
  );
}

// ThemeData getLightTheme() {
//   ThemeData theme = ThemeData();
//   theme = ThemeData().copyWith(
//     textTheme: lightTextTheme,
//     colorScheme: theme.colorScheme.copyWith(secondary: accent),
//     primaryColor: primary,
//     primaryColorLight: grayDeep,
//     primaryColorDark: textColor,
//     backgroundColor: white,
//     secondaryHeaderColor: black,
//   );
//   return theme;
// }

// static final lightTextTheme = TextTheme(
//   headline5: GoogleFonts.roboto(color: primary, fontSize: dp22),
//   headline6: GoogleFonts.roboto(color: primary, fontSize: dp20),
//   subtitle1: GoogleFonts.roboto(color: primary, fontSize: dp16),
//   bodyText1: GoogleFonts.roboto(color: primary, fontSize: dp16),
//   button: GoogleFonts.roboto(color: textColor, fontSize: dp18, fontWeight: FontWeight.bold),
// );
//
// ThemeData getDarkTheme() {
//   ThemeData theme = ThemeData();
//   theme = ThemeData().copyWith(
//       primaryColor: primary,
//       primaryColorDark: primaryDark,
//       colorScheme: theme.colorScheme.copyWith(secondary: accent),
//       textTheme: darkTextTheme);
//   return theme;
// }

// static final darkTextTheme = TextTheme(
//   headline5: GoogleFonts.roboto(
//       color: primary, fontSize: dp22, fontWeight: FontWeight.w700),
//   headline6: GoogleFonts.roboto(
//       color: primary, fontSize: dp20, fontWeight: FontWeight.w700),
//   subtitle1: GoogleFonts.roboto(
//       color: primary, fontSize: dp18, fontWeight: FontWeight.w700),
//   bodyText1: GoogleFonts.roboto(
//       color: primary, fontSize: dp16, fontWeight: FontWeight.w700),
//   button: GoogleFonts.roboto(
//       color: primary, fontSize: dp16, fontWeight: FontWeight.w700),
// );
// }

class ThemeService {
  ThemeMode get theme => loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  bool loadThemeFromBox() => GetStorage().read(PreferenceKey.darkMode) ?? false;

  _saveThemeToBox(bool isDarkMode) =>
      GetStorage().write(PreferenceKey.darkMode, isDarkMode);

  void switchTheme() {
    var isDark = loadThemeFromBox();
    //print("switchTheme ${Get.isDarkMode}");
    gIsDarkMode = !gIsDarkMode;
    Get.changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!isDark);
  }
}
