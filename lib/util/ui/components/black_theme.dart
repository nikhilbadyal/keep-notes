//25-11-2021 01:02 PM

import 'package:notes/_aap_packages.dart';
import 'package:notes/_internal_packages.dart';

ThemeData blackTheme(final Color primary, final Color accent) {
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black,
    canvasColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: primary,
      elevation: 0,
      /*systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: primary == Colors.white ? primary : null,
        statusBarIconBrightness: Brightness.light,
      ),*/
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: accent,
    ),
    iconTheme: const IconThemeData().copyWith(color: Colors.white),
    colorScheme: ColorScheme.dark(primary: primary, secondary: accent),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: accent,
      actionTextColor: greyColor,
      contentTextStyle: TextStyle(color: greyColor),
      behavior: SnackBarBehavior.fixed,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.black,
    ),
    cardColor: Colors.black,
    dialogBackgroundColor: Colors.black,
    dividerColor: Colors.black,
    dialogTheme: DialogTheme(
      backgroundColor: Colors.black,
      titleTextStyle: const TextStyle().copyWith(color: Colors.white),
    ),
  );
}